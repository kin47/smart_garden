import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/datasource/remote/kit_service/kit_service.dart';
import 'package:smart_garden/features/data/request/control_kit_request/control_kit_request.dart';
import 'package:smart_garden/features/domain/entity/kit_entity.dart';
import 'package:smart_garden/features/domain/repository/kit_repository.dart';

@Injectable(as: KitRepository)
class KitRepositoryImpl implements KitRepository {
  final KitService _service;

  KitRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, KitEntity>> getKitDetail({
    required int kitId,
  }) async {
    try {
      final res = await _service.getKitDetail(kitId: kitId);
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(KitEntity.fromModel(res.data!));
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, bool>> controlKit({
    required int kitId,
    required ControlKitRequest request,
  }) async {
    try {
      await _service.controlKit(
        kitId: kitId,
        request: request,
      );
      return right(true);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
