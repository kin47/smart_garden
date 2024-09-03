import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@freezed
class Main with _$Main {
  const factory Main({
    double? temp,
    @JsonKey(name: "temp_min") double? tempMin,
    @JsonKey(name: "temp_max") double? tempMax,
    int? pressure,
    int? humidity,
  }) = _Main;

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@freezed
class Sys with _$Sys {
  const factory Sys({
    int? type,
    int? id,
    String? country,
    int? sunrise,
    int? sunset,
  }) = _Sys;
  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);
}

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    List<Weather>? weather,
    String? base,
    Main? main,
    Sys? sys,
    int? timezone,
    String? name,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

