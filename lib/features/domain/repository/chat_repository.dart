import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/model/chat_message_socket/chat_message_socket.dart';
import 'package:smart_garden/features/data/model/web_socket_model/web_socket_model.dart';
import 'package:smart_garden/features/data/request/get_chat_messages_request/get_chat_messages_request.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';

abstract class ChatRepository {
  Future<int?> createSupportConversation();

  void initializeConversation(int conversationId);

  Future<Either<BaseError, List<ChatMessageEntity>>> getChatMessages({
    required GetChatMessagesRequest request,
  });

  Future<bool> readMessage();

  Future<bool> sendMessage({
    required String message,
  });

  Future<void> disconnectChat();

  Stream<WebSocketModel<ChatMessageSocket>> wsMessageStream();
}