import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/datasource/remote/notification_service/notification_service.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/notification_entity.dart';
import 'package:smart_garden/features/domain/repository/notification_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationService _service;

  NotificationRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, List<NotificationEntity>>> getData({
    required PaginationRequest request,
  }) async {
    try {
      final res = await _service.getNotifications(request: request);
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(
          res.data!.map((e) => NotificationEntity.fromModel(e)).toList());
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, bool>> markAsRead({
    required int id,
  }) async {
    try {
      final res = await _service.markAsRead(notificationId: id.toString());
      if (res.message == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(true);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
