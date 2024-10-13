import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/base/network/web_socket/chat_socket.dart';
import 'package:smart_garden/features/data/datasource/remote/chat_service/chat_service.dart';
import 'package:smart_garden/features/data/model/chat_message_model/chat_message_model.dart';
import 'package:smart_garden/features/data/request/connect_ws_request/connect_ws_request.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/data/request/send_message_request/send_message_request.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';
import 'package:smart_garden/features/domain/repository/chat_repository.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatService _service;
  final ChatSocket _chatSocket;

  ChatRepositoryImpl(this._service, this._chatSocket);

  @override
  Future<Either<BaseError, List<ChatMessageEntity>>> getChatMessages({
    required PaginationRequest request,
  }) async {
    try {
      final res = await _service.getChatMessages(request: request);
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(
        res.data!.map((e) => ChatMessageEntity.fromModel(e)).toList(),
      );
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, ChatMessageEntity>> sendMessage({
    required SendMessageRequest request,
  }) async {
    try {
      final res = await _service.sendMessage(request: request);
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(ChatMessageEntity.fromModel(res.data!));
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  void chatInitialize({
    required ConnectWSRequest connectRequest,
  }) {
    _chatSocket.initialize(
      connectRequest: connectRequest,
    );
  }

  @override
  Future<void> disconnectChat() {
    return _chatSocket.dispose();
  }

  @override
  Stream<ChatMessageEntity> wsMessageStream() async* {
    yield* _chatSocket.wsEventStream.asyncExpand(
      (event) async* {
        if (event.message == null) return;
        yield ChatMessageEntity.fromModel(
          ChatMessageModel(
            message: event.message,
            sender: event.sender,
          ),
        );
      },
    );
  }
}
