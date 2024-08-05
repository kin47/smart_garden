import 'package:smart_garden/di/di_setup.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

import '../constants/constants.dart';

class ErrorHandling implements Exception {
  String errorMessage = "";
  final Dio dio = getIt<Dio>();

  ErrorHandling.withError({
    required DioException error,
  }) {
    _handleError(error);
  }

  Future _handleError(DioException error) async {
    switch (error.type) {
      case DioExceptionType.cancel:
        errorMessage = "dio_cancel_request".tr();
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = "dio_cancel_request".tr();
        break;
      case DioExceptionType.unknown:
        errorMessage = "dio_cancel_request".tr();
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = "dio_cancel_request".tr();
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = "dio_cancel_request".tr();
        break;
      case DioExceptionType.badResponse:
        final code = error.response?.statusCode;
        if (code == StatusCode.unauthorized) {
          errorMessage = "unauthorized";
        } else {
          //todo: handle message =>
        }
        break;
      default:
        break;
    }
    return errorMessage;
  }

  Future<void> refreshToken(DioException error) async {
    error.requestOptions.cancelToken?.cancel();
    String token = "";
    //get new Token
    final headers = error.requestOptions.headers;
    headers['Authorization'] = token;
    final opts = Options(method: error.requestOptions.method, headers: headers);
    await dio.request(error.requestOptions.path,
        options: opts,
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters);
  }
}
