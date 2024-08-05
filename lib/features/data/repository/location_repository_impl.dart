import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/features/data/datasource/remote/location_service/location_service.dart';
import 'package:smart_garden/features/data/model/location_model/location_model.dart';
import 'package:smart_garden/features/domain/repository/location_repository.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationService _service;

  LocationRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, bool>> sendLocation({
    required String userEmail,
    required DateTime time,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await _service.sendLocation(
        userEmail: userEmail,
        time: time,
        latitude: latitude,
        longitude: longitude,
      );
      return right(res);
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }

  @override
  Future<Either<BaseError, LocationModel>> getBlindPersonLocation({
    required String adminEmail,
  }) async {
    try {
      final res = await _service.getBlindPersonLocation(
        userEmail: adminEmail.userEmail,
      );
      return right(res);
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }
}
