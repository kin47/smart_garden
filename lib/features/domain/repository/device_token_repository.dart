import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/device_token_request/device_token_request.dart';

abstract class DeviceTokenRepository {
  Future<Either<BaseError, bool>> registerDeviceToken({
    required DeviceTokenRequest request,
  });

  Future<Either<BaseError, bool>> deleteDeviceToken({
    required DeviceTokenRequest request,
  });
}