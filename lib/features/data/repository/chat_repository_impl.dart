import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/chat_message_entity.dart';
import 'package:smart_garden/features/domain/enum/owner_type_enum.dart';
import 'package:smart_garden/features/domain/repository/chat_repository.dart';

@Injectable(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<Either<BaseError, List<ChatMessageEntity>>> getChatMessages({
    required PaginationRequest request,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return right([
        ChatMessageEntity(
          id: 1,
          transDate: DateTime.now(),
          ownerType: OwnerTypeEnum.admin,
          message: 'Bạn chọn loại nào nhỉ?',
        ),
        ChatMessageEntity(
          id: 1,
          transDate: DateTime.now().subtract(Duration(minutes: 1)),
          ownerType: OwnerTypeEnum.admin,
          message: 'Bạn chờ mình chút nhé',
        ),
        ChatMessageEntity(
          id: 1,
          transDate: DateTime.now().subtract(Duration(minutes: 2)),
          ownerType: OwnerTypeEnum.user,
          message: 'Giá cả bao nhiêu nhỉ?',
        ),
        ChatMessageEntity(
          id: 1,
          transDate: DateTime.now().subtract(Duration(minutes: 3)),
          ownerType: OwnerTypeEnum.user,
          message: 'Cho mình 1 kit',
        ),
        ChatMessageEntity(
          id: 1,
          transDate: DateTime.now().subtract(Duration(minutes: 4)),
          ownerType: OwnerTypeEnum.admin,
          message: 'Hello bạn, mình có thể giúp gì bạn',
        ),
        ChatMessageEntity(
          id: 1,
          transDate: DateTime.now().subtract(Duration(minutes: 5)),
          ownerType: OwnerTypeEnum.user,
          message: 'Hello Admin',
        ),
      ]);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
