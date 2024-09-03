import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_garden/gen/assets.gen.dart';

enum WeatherEnum {
  sunny,
  sunWithCloud,
  cloudy,
  lightRain,
  rainy,
  snowy,
  thunderstorm,
  foggy,
  windy;

  Widget get icon {
    switch (this) {
      case WeatherEnum.sunny:
        return Assets.images.icSunny.image(width: 100.w);
      case WeatherEnum.cloudy:
        return Assets.images.icCloudy.image(width: 100.w);
      case WeatherEnum.lightRain:
        return Assets.images.icLightRain.image(width: 100.w);
      case WeatherEnum.rainy:
        return Assets.images.icRain.image(width: 100.w);
      case WeatherEnum.snowy:
        return Assets.images.icSnow.image(width: 100.w);
      case WeatherEnum.thunderstorm:
        return Assets.images.icStorm.image(width: 100.w);
      case WeatherEnum.foggy:
        return Assets.images.icFoggy.image(width: 100.w);
      case WeatherEnum.windy:
        return Assets.images.icWindy.image(width: 100.w);
      default:
        return Assets.images.icSunWithCloud.image(width: 100.w);
    }
  }

  static WeatherEnum fromCode(int code) {
    if (code >= 200 && code < 300) {
      return WeatherEnum.thunderstorm;
    } else if ((code >= 300 && code < 400) || code == 500) {
      return WeatherEnum.lightRain;
    } else if (code > 500 && code < 600) {
      return WeatherEnum.rainy;
    } else if (code >= 600 && code < 700) {
      return WeatherEnum.snowy;
    } else if (code >= 700 && code < 800) {
      return WeatherEnum.foggy;
    } else if (code == 800) {
      return WeatherEnum.sunny;
    } else if (code == 801 || code == 802) {
      return WeatherEnum.sunWithCloud;
    } else if (code == 803 || code == 804) {
      return WeatherEnum.cloudy;
    } else {
      return WeatherEnum.sunny;
    }
  }
}