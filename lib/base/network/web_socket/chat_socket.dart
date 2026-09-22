import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_garden/common/constants/auth_constants.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/common/utils/functions/jwt_decode.dart';
import 'package:smart_garden/features/data/model/chat_message_socket/chat_message_socket.dart';
import 'package:smart_garden/features/data/model/web_socket_model/web_socket_model.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';
import 'package:smart_garden/features/domain/enum/ws_action_enum.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatSocket {
  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _subscription;
  final _events =
      StreamController<WebSocketModel<ChatMessageSocket>>.broadcast();
  int? _conversationId;
  int? _userId;
  int? _lastReceivedMessageId;
  int? _pendingReadMessageId;
  bool _manualDisconnect = false;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  int _connectionGeneration = 0;
  static const _maxReconnectDelay = Duration(seconds: 30);

  Stream<WebSocketModel<ChatMessageSocket>> get wsEventStream => _events.stream;

  void initialize({required int conversationId}) {
    final generation = ++_connectionGeneration;
    _manualDisconnect = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    unawaited(_subscription?.cancel());
    final oldChannel = _channel;
    if (oldChannel != null) {
      unawaited(_closeChannel(oldChannel, status.normalClosure));
    }
    _subscription = null;
    _channel = null;
    _conversationId = conversationId;
    _lastReceivedMessageId = null;
    _pendingReadMessageId = null;
    _manualDisconnect = false;
    _reconnectAttempts = 0;
    unawaited(_connect(generation));
  }

  Future<void> _connect(int generation) async {
    final token = await getIt<SecureStorage>().get(AuthConstants.token);
    final conversationId = _conversationId;
    if (!_isCurrent(generation) ||
        token == null ||
        token.isEmpty ||
        conversationId == null) {
      return;
    }
    _userId = JwtDecoder.tryDecode(token)?.userId;

    final endpoint = dotenv.get('WS_URL').replaceFirst(RegExp(r'/$'), '');
    final uri = Uri.parse(
      '$endpoint/conversations/$conversationId/',
    ).replace(queryParameters: {'access_token': token});
    await _subscription?.cancel();
    final channel = WebSocketChannel.connect(uri);
    try {
      // WebSocketChannel exposes connection failures lazily; awaiting this
      // surfaces them here instead of as an unhandled zone error.
      await channel.ready;
    } catch (_) {
      await _closeChannel(channel, status.goingAway);
      _scheduleReconnect(generation);
      return;
    }
    if (!_isCurrent(generation)) {
      await _closeChannel(channel, status.normalClosure);
      return;
    }
    _channel = channel;
    _reconnectAttempts = 0;
    unawaited(_flushPendingRead());
    _subscription = channel.stream.listen(
      _onMessage,
      onDone: () => _scheduleReconnect(generation),
      onError: (_) => _scheduleReconnect(generation),
      cancelOnError: true,
    );
  }

  // Stream contracts emit onError followed by onDone for the same failure,
  // so guard with a single pending timer to avoid duplicate reconnects.
  void _scheduleReconnect(int generation) {
    if (!_isCurrent(generation) || _reconnectTimer != null) {
      return;
    }
    final delaySeconds = 1 << _reconnectAttempts.clamp(0, 5); // 1,2,4,8,16,32s
    _reconnectAttempts++;
    final delay = Duration(seconds: delaySeconds) > _maxReconnectDelay
        ? _maxReconnectDelay
        : Duration(seconds: delaySeconds);
    _reconnectTimer = Timer(delay, () {
      _reconnectTimer = null;
      if (_isCurrent(generation)) {
        unawaited(_connect(generation));
      }
    });
  }

  bool _isCurrent(int generation) =>
      !_manualDisconnect &&
      generation == _connectionGeneration &&
      _conversationId != null;

  Future<void> _closeChannel(WebSocketChannel channel, int closeCode) async {
    try {
      await channel.sink.close(closeCode);
    } on Object {
      // The channel may already be closed after a failed handshake.
    }
  }

  void _onMessage(dynamic raw) {
    if (raw is! String) {
      return;
    }
    try {
      final payload = jsonDecode(raw) as Map<String, dynamic>;
      final type = payload['type'];
      final data = payload['data'];
      if (type == 'message.created' && data is Map<String, dynamic>) {
        final senderId = (data['sender_id'] as num?)?.toInt();
        final messageId = (data['id'] as num?)?.toInt();
        if (senderId != _userId && messageId != null) {
          _lastReceivedMessageId = _maxMessageId(
            _lastReceivedMessageId,
            messageId,
          );
        }
        _events.add(
          WebSocketModel<ChatMessageSocket>(
            action: WSActionEnum.sendChatMessage,
            data: ChatMessageSocket(
              id: messageId,
              conversationId: (data['conversation_id'] as num?)?.toInt(),
              senderId: senderId,
              message: data['body'] as String? ?? '',
              createdAt: data['created_at'] is String
                  ? DateTime.tryParse(data['created_at'] as String)
                  : null,
              sender: senderId == _userId ? SenderEnum.user : SenderEnum.admin,
            ),
          ),
        );
      } else if (type == 'conversation.read' && data is Map<String, dynamic>) {
        final readerUserId = (data['user_id'] as num?)?.toInt();
        if (readerUserId == _userId) {
          return;
        }
        _events.add(
          WebSocketModel<ChatMessageSocket>(
            action: WSActionEnum.seen,
            data: ChatMessageSocket(
              conversationId: (data['conversation_id'] as num?)?.toInt(),
              readerUserId: readerUserId,
              lastReadMessageId: (data['last_read_message_id'] as num?)
                  ?.toInt(),
            ),
          ),
        );
      }
    } on Object {
      // Ignore malformed server frames; the connection remains usable.
    }
  }

  Future<bool> sendMessage(String message) async {
    return _send({
      'type': 'message.send',
      'data': {'body': message},
    });
  }

  Future<bool> readMessage([int? messageId]) async {
    final candidateMessageId = messageId ?? _lastReceivedMessageId;
    if (candidateMessageId == null) {
      return true;
    }
    _lastReceivedMessageId = _maxMessageId(
      _lastReceivedMessageId,
      candidateMessageId,
    );
    _pendingReadMessageId = _maxMessageId(
      _pendingReadMessageId,
      candidateMessageId,
    );
    return _flushPendingRead();
  }

  int _maxMessageId(int? current, int candidate) =>
      current == null || candidate > current ? candidate : current;

  Future<bool> _flushPendingRead() async {
    final messageId = _pendingReadMessageId;
    if (messageId == null) {
      return true;
    }
    if (_channel == null) {
      return true;
    }
    final sent = await _send({
      'type': 'conversation.read',
      'data': {'last_read_message_id': messageId},
    });
    if (sent && _pendingReadMessageId == messageId) {
      _pendingReadMessageId = null;
    }
    return sent;
  }

  Future<bool> _send(Map<String, dynamic> payload) async {
    final channel = _channel;
    if (channel == null) {
      return false;
    }
    try {
      channel.sink.add(jsonEncode(payload));
      return true;
    } on Object {
      return false;
    }
  }

  Future<void> dispose() async {
    _connectionGeneration++;
    _manualDisconnect = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    await _subscription?.cancel();
    final channel = _channel;
    if (channel != null) {
      await _closeChannel(channel, status.normalClosure);
    }
    _subscription = null;
    _channel = null;
    _conversationId = null;
    _lastReceivedMessageId = null;
    _pendingReadMessageId = null;
  }
}
