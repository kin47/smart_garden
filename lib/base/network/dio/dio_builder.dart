import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../common/config/index.dart';
import '../../../common/logger/index.dart';
import 'dio_interceptor.dart';

class DioBuilder {
  Dio? dio;

  Dio getDio() {
    if (dio == null) {
      final BaseOptions options = BaseOptions(
        baseUrl: getUrl(),
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: ApiConfig.connectTimeout),
        receiveTimeout: const Duration(seconds: ApiConfig.receiveTimeout),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
        },
      );
      dio = Dio(options);
      dio?.interceptors.addAll(
        [
          DioInterceptor(),
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
          ),
        ],
      );
    }
    return dio!;
  }

  String getUrl() {
    return dotenv.get('BASE_URL');
  }
}

class WeatherDioBuilder extends DioBuilder {
  @override
  String getUrl() {
    return dotenv.get('WEATHER_API_BASE_URL');
  }
}