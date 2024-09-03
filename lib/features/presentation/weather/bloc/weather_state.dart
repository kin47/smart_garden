part of 'weather_bloc.dart';

@CopyWith()
class WeatherState extends BaseBlocState {
  final double? temperature;
  final double? maxTemperature;
  final double? minTemperature;
  final WeatherEnum? weather;
  final int? humidity;
  final DateTime? sunrise;
  final DateTime? sunset;
  final String description;
  final String city;
  final int? timezone;

  const WeatherState({
    required super.status,
    super.message,
    this.weather,
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.humidity,
    this.sunrise,
    this.sunset,
    this.description = '-',
    this.city = '-',
    this.timezone,
  });

  factory WeatherState.init() => const WeatherState(
        status: BaseStateStatus.init,
      );

  @override
  List get props => [
        status,
        message,
        weather,
        temperature,
        maxTemperature,
        minTemperature,
        humidity,
        sunrise,
        sunset,
        description,
        city,
        timezone,
      ];
}
