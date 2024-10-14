import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/model/chat_message_socket/chat_message_socket.dart';
import 'package:smart_garden/features/data/model/web_socket_model/web_socket_model.dart';
import 'package:smart_garden/features/data/request/connect_ws_request/connect_ws_request.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';
import 'package:smart_garden/features/domain/enum/ws_action_enum.dart';
import 'package:web_socket_channel/status.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class _Const {
  static const int timeOutCloseCode = 1000;
}

class ChatSocket {
  WebSocketChannel? _channel;
  final StreamController<WebSocketModel<ChatMessageSocket>>
      _wsEventStreamController =
      StreamController<WebSocketModel<ChatMessageSocket>>.broadcast();
  final int retryDelay = 1;
  late final int _userId;
  Future<String?> Function()? _getNewToken;

  Stream<WebSocketModel<ChatMessageSocket>> get wsEventStream =>
      _wsEventStreamController.stream;

  StreamSubscription listen(void Function(dynamic)? handler) =>
      _wsEventStreamController.stream.listen(handler);
  final String endpoint = dotenv.get('WS_URL');
  bool? isManualDisconnect;

  void initialize({
    required ConnectWSRequest connectRequest,
    Future<String?> Function()? getNewToken,
  }) {
    _userId = connectRequest.userId;
    _getNewToken = getNewToken;
    _connect(connectRequest);
    _handlerListener();
  }

  Future<StreamSubscription<dynamic>?> _handlerListener() async {
    return _channel?.stream.listen(
      _onMessage,
      onDone: () async {
        logger.d(
          'ChatService => socket closed: reason=[${_channel?.closeReason}], code:[${_channel?.closeCode}]',
        );
        isManualDisconnect = _channel?.closeCode == normalClosure;
        if (isManualDisconnect == false && _getNewToken != null) {
          //flutter toast
          logger.d(
            'ChatService => WebSocketChannel is disconnected. Try to reconnect after $retryDelay second...',
          );
          await Future.delayed(Duration(seconds: retryDelay));
          final token = "Bearer ${await _getNewToken?.call()}";
          _connect(
            ConnectWSRequest(
              userId: _userId,
            ),
          );
          _handlerListener();
        }
      },
      onError: (e) async {
        isManualDisconnect = _channel?.closeCode == normalClosure;
        logger.d('ChatService => #onError $e');
        // _wsEventStreamController.addError(e.toString());
        // await Future.delayed(Duration(seconds: retryDelay));
        // _connect();
      },
    );
  }

  void _connect(ConnectWSRequest connectRequest) async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('$endpoint/${connectRequest.userId}/'),
      );
      logger.d(
        'ChatService => WebSocketChannel connected to $endpoint/${connectRequest.userId} = ${!isDisconnected}!',
      );
      WebSocketModel<ConnectWSRequest> connectRequestModel =
          WebSocketModel<ConnectWSRequest>(
        action: WSActionEnum.authenticate,
        data: connectRequest,
      );

      add(jsonEncode(connectRequestModel.toJson((value) => value.toJson())));
    } catch (e) {
      logger.d('ChatService => error: $e');
    }
  }

  bool get isDisconnected => _channel?.closeCode == _Const.timeOutCloseCode;

  void _onMessage(message) {
    try {
      if (message is String) {
        Map<String, dynamic> messageData = jsonDecode(message);
        if (messageData['action'] == WSActionEnum.sendChatMessage.value) {
          final data = messageData['data'];
          final chatMessage = ChatMessageSocket.fromJson(data);
          logger.d('ChatService => New message: $data');
          _wsEventStreamController.sink.add(
            WebSocketModel<ChatMessageSocket>(
              action: WSActionEnum.sendChatMessage,
              data: chatMessage,
            ),
          );
        } else if (messageData['action'] == WSActionEnum.seen.value) {
          final sender = messageData['data']['sender'];
          if (sender == 1) {
            _wsEventStreamController.sink.add(
              WebSocketModel<ChatMessageSocket>(
                action: WSActionEnum.seen,
                data: const ChatMessageSocket(
                  sender: SenderEnum.admin,
                ),
              ),
            );
            logger.d('ChatService => Admin read message');
          }
        } else {
          logger.d('ChatService => Unknown message: $message');
        }
      }
    } catch (e) {
      logger.d('ChatService => error: $message');
    }
  }

  Future<bool> sendMessage(String message) async {
    WebSocketModel<ChatMessageSocket> chatMessage =
        WebSocketModel<ChatMessageSocket>(
      action: WSActionEnum.sendChatMessage,
      data: ChatMessageSocket(
        message: message,
        sender: SenderEnum.user,
      ),
    );
    await add(jsonEncode(chatMessage.toJson((value) => value)));
    if (!isDisconnected) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> readMessage() async {
    WebSocketModel<ChatMessageSocket> chatMessage =
        WebSocketModel<ChatMessageSocket>(
      action: WSActionEnum.seen,
      data: const ChatMessageSocket(
        sender: SenderEnum.user,
      ),
    );
    await add(jsonEncode(chatMessage.toJson((value) => value)));
    if (!isDisconnected) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> add(String data) async {
    logger.d('ChatService => Send message: $data');

    if (!isDisconnected) {
      _channel?.sink.add(data);
    } else {
      logger.d('ChatService => ChatService disconnected');
      // _connect();
    }
  }

  Future<void> dispose() async {
    await _wsEventStreamController.close();
  }
}
