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
  int? _lastReceivedMessageId;
  bool _manualDisconnect = false;

  Stream<WebSocketModel<ChatMessageSocket>> get wsEventStream => _events.stream;

  void initialize({required int conversationId}) {
    _conversationId = conversationId;
    _manualDisconnect = false;
    _connect();
  }

  Future<void> _connect() async {
    final token =
        await getIt<SecureStorage>().get(AuthConstants.token);
    final conversationId = _conversationId;
    if (token == null || token.isEmpty || conversationId == null) {
      return;
    }
    final userId = JwtDecoder.tryDecode(token)?.userId;

    final endpoint = dotenv.get('WS_URL').replaceFirst(RegExp(r'/$'), '');
    final uri = Uri.parse(
      '$endpoint/conversations/$conversationId/',
    ).replace(queryParameters: {'access_token': token});
    await _subscription?.cancel();
    _channel = WebSocketChannel.connect(uri);
    _subscription = _channel!.stream.listen(
      _onMessage,
      onDone: _reconnect,
      onError: (_) => _reconnect(),
    );
  }

  void _reconnect() {
    if (_manualDisconnect || _conversationId == null) {
      return;
    }
    Future<void>.delayed(const Duration(seconds: 1), _connect);
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
        _lastReceivedMessageId = (data['id'] as num?)?.toInt();
        _events.add(
          WebSocketModel<ChatMessageSocket>(
            action: WSActionEnum.sendChatMessage,
            data: ChatMessageSocket(
              message: data['body'] as String? ?? '',
              sender: senderId == userId ? SenderEnum.user : SenderEnum.admin,
            ),
          ),
        );
      } else if (type == 'conversation.read') {
        _events.add(
          WebSocketModel<ChatMessageSocket>(
            action: WSActionEnum.seen,
            data: const ChatMessageSocket(sender: SenderEnum.admin),
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

  Future<bool> readMessage() async {
    final messageId = _lastReceivedMessageId;
    if (messageId == null) {
      return true;
    }
    return _send({
      'type': 'conversation.read',
      'data': {'last_read_message_id': messageId},
    });
  }

  Future<bool> _send(Map<String, dynamic> payload) async {
    final channel = _channel;
    if (channel == null) {
      return false;
    }
    channel.sink.add(jsonEncode(payload));
    return true;
  }

  Future<void> dispose() async {
    _manualDisconnect = true;
    await _subscription?.cancel();
    await _channel?.sink.close(status.normalClosure);
    _channel = null;
    _conversationId = null;
  }
}
