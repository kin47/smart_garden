import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/base/network/web_socket/chat_socket.dart';
import 'package:smart_garden/common/constants/auth_constants.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/common/utils/functions/jwt_decode.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/datasource/remote/chat_service/chat_service.dart';
import 'package:smart_garden/features/data/model/chat_message_socket/chat_message_socket.dart';
import 'package:smart_garden/features/data/model/web_socket_model/web_socket_model.dart';
import 'package:smart_garden/features/data/request/get_chat_messages_request/get_chat_messages_request.dart';
import 'package:smart_garden/features/data/request/send_message_request/send_message_request.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';
import 'package:smart_garden/features/domain/enum/sender_enum.dart';
import 'package:smart_garden/features/domain/enum/ws_action_enum.dart';
import 'package:smart_garden/features/domain/repository/chat_repository.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatService _service;
  final ChatSocket _chatSocket;

  ChatRepositoryImpl(this._service, this._chatSocket);
  int? _conversationId;

  @override
  Future<int?> createSupportConversation() async {
    try {
      final response = await _service.createSupportConversation(
        body: const {'kind': 'support'},
      );
      return response.data?.id;
    } on DioException {
      return null;
    }
  }

  @override
  void initializeConversation(int conversationId) {
    _conversationId = conversationId;
    _chatSocket.initialize(conversationId: conversationId);
  }

  @override
  Future<Either<BaseError, List<ChatMessageEntity>>> getChatMessages({
    required GetChatMessagesRequest request,
  }) async {
    final conversationId = _conversationId;
    if (conversationId == null) {
      return left(BaseError.httpUnknownError('error_system'.tr()));
    }
    try {
      final res = await _service.getChatMessages(
        conversationId: conversationId,
        request: request,
      );
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      final token = await getIt<SecureStorage>().get(AuthConstants.token);
      final userId = token == null ? null : JwtDecoder.tryDecode(token)?.userId;
      return right(
        res.data!
            .map(
              (message) => ChatMessageEntity.fromModel(
                message,
                sender: message.senderId == userId
                    ? SenderEnum.user
                    : SenderEnum.admin,
              ),
            )
            .toList(),
      );
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<bool> readMessage({int? lastReadMessageId}) async {
    try {
      final res = await _chatSocket.readMessage(lastReadMessageId);
      return res;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> sendMessage({required String message}) async {
    final conversationId = _conversationId;
    if (conversationId == null) {
      return false;
    }
    try {
      final response = await _service.sendMessage(
        conversationId: conversationId,
        request: SendMessageRequest(
          sender: SenderEnum.user,
          message: message,
          time: DateTime.now(),
        ),
      );
      return response.data != null;
    } on DioException {
      return false;
    }
  }

  @override
  Future<bool> hasUnreadMessages() async {
    try {
      final response = await _service.getUnreadMessages();
      return response.hasUnreadMessages;
    } on DioException {
      return false;
    }
  }

  @override
  Future<void> disconnectChat() {
    return _chatSocket.dispose();
  }

  @override
  Stream<WebSocketModel<ChatMessageSocket>> wsMessageStream() async* {
    yield* _chatSocket.wsEventStream.asyncExpand((event) async* {
      switch (event.action) {
        case WSActionEnum.sendChatMessage:
          yield WebSocketModel<ChatMessageSocket>(
            action: WSActionEnum.sendChatMessage,
            data: ChatMessageSocket(
              id: event.data?.id,
              conversationId: event.data?.conversationId,
              senderId: event.data?.senderId,
              message: event.data?.message ?? '',
              createdAt: event.data?.createdAt,
              sender: event.data?.sender ?? SenderEnum.user,
            ),
          );
          break;
        case WSActionEnum.seen:
          // 'conversation.read' payloads never carry a sender; the socket
          // layer already filters out our own read receipts by user id.
          yield WebSocketModel<ChatMessageSocket>(
            action: WSActionEnum.seen,
            data: event.data,
          );
          break;
        default:
          break;
      }
    });
  }
}
