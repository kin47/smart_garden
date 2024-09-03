import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/domain/entity/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<BaseError, WeatherEntity>> fetchWeather({
    required double lat,
    required double lon,
  });
}
