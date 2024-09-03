part of 'weather_bloc.dart';

@freezed
class WeatherEvent with _$WeatherEvent {
  const factory WeatherEvent.init() = Init;

  const factory WeatherEvent.getWeather({
    required double lat,
    required double lon,
  }) = GetWeather;
}
