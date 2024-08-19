import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/store_entity.dart';

abstract class StoreRepository {
  Future<Either<BaseError, List<StoreEntity>>> getStores({
    required PaginationRequest request,
  });
}
