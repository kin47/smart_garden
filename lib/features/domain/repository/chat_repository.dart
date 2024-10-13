import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/connect_ws_request/connect_ws_request.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/data/request/send_message_request/send_message_request.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';

abstract class ChatRepository {
  Future<Either<BaseError, List<ChatMessageEntity>>> getChatMessages({
    required PaginationRequest request,
  });

  Future<Either<BaseError, ChatMessageEntity>> sendMessage({
    required SendMessageRequest request,
  });

  void chatInitialize({required ConnectWSRequest connectRequest});

  Future<void> disconnectChat();

  Stream<ChatMessageEntity> wsMessageStream();
}