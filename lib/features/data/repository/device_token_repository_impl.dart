import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/datasource/remote/device_token_service/device_token_service.dart';
import 'package:smart_garden/features/data/request/device_token_request/device_token_request.dart';
import 'package:smart_garden/features/domain/repository/device_token_repository.dart';

@Injectable(as: DeviceTokenRepository)
class DeviceTokenRepositoryImpl implements DeviceTokenRepository {
  final DeviceTokenService _service;

  DeviceTokenRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, bool>> registerDeviceToken({
    required DeviceTokenRequest request,
  }) async {
    try {
      final res = await _service.registerDeviceToken(request: request);
      if (res.message == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(true);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, bool>> deleteDeviceToken({
    required DeviceTokenRequest request,
  }) async {
    try {
      final res = await _service.deleteDeviceToken(request: request);
      if (res.message == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(true);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
