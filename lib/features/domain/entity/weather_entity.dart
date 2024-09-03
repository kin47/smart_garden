import 'package:smart_garden/common/constants/other_constants.dart';
import 'package:smart_garden/common/extensions/double_extension.dart';
import 'package:smart_garden/common/utils/date_time/date_time_utils.dart';
import 'package:smart_garden/features/data/model/weather_model/weather_model.dart';
import 'package:smart_garden/features/domain/enum/weather_enum.dart';

class WeatherEntity {
  final String city;
  final double temperature;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final WeatherEnum weather;
  final String description;
  final DateTime sunrise;
  final DateTime sunset;
  final int? timezone;

  WeatherEntity({
    required this.city,
    required this.temperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.weather,
    required this.description,
    required this.sunrise,
    required this.sunset,
    this.timezone,
  });

  factory WeatherEntity.fromModel(WeatherModel model) {
    return WeatherEntity(
      city: model.name ?? '-',
      weather: WeatherEnum.fromCode(model.weather?.first.id ?? 0),
      temperature: model.main?.temp.celsiusDegree ?? 0,
      minTemperature: model.main?.tempMin.celsiusDegree ?? 0,
      maxTemperature: model.main?.tempMax.celsiusDegree ?? 0,
      humidity: model.main?.humidity ?? 0,
      description: model.weather?.first.description ?? '-',
      sunrise: DateTimeUtils.getDateBasedOnTimezone(
        DateTime.fromMillisecondsSinceEpoch((model.sys?.sunrise ?? 0) * 1000),
        model.timezone ?? DateTimeConstants.defaultTimezone,
      ),
      sunset: DateTimeUtils.getDateBasedOnTimezone(
        DateTime.fromMillisecondsSinceEpoch((model.sys?.sunset ?? 0) * 1000),
        model.timezone ?? DateTimeConstants.defaultTimezone,
      ),
      timezone: model.timezone,
    );
  }
}
