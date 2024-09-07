import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<BaseError, List<NotificationEntity>>> getData({
    required PaginationRequest request,
  });

  Future<Either<BaseError, bool>> markAsRead({
    required int id,
  });
}