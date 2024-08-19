import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/datasource/remote/store_service/store_service.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/store_entity.dart';
import 'package:smart_garden/features/domain/repository/store_repository.dart';

@Injectable(as: StoreRepository)
class StoreRepositoryImpl implements StoreRepository {
  final StoreService _service;

  StoreRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, List<StoreEntity>>> getStores({
    required PaginationRequest request,
  }) async {
    try {
      final res = await _service.getStores(request: request);
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(res.data!.map((e) => StoreEntity.fromModel(e)).toList());
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
