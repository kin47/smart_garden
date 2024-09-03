import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_request.freezed.dart';
part 'weather_request.g.dart';

@freezed
class WeatherRequest with _$WeatherRequest {
  const factory WeatherRequest({
    required double lat,
    required double lon,
    required String appid,
    required String lang,
  }) = _WeatherRequest;

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);
}