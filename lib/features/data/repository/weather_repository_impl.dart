import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/datasource/remote/weather_service/weather_service.dart';
import 'package:smart_garden/features/data/request/weather_request/weather_request.dart';
import 'package:smart_garden/features/domain/entity/weather_entity.dart';
import 'package:smart_garden/features/domain/repository/weather_repository.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService _service;

  WeatherRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, WeatherEntity>> fetchWeather({
    required double lat,
    required double lon,
  }) async {
    try {
      final res = await _service.getWeather(
        request: WeatherRequest(
          lat: lat,
          lon: lon,
          lang: 'vi',
          appid: dotenv.get('WEATHER_API_KEY'),
        ),
      );
      return right(WeatherEntity.fromModel(res));
    } catch (e) {
      return left(BaseError.httpUnknownError('error_system'.tr()));
    }
  }
}
