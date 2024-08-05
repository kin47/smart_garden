import 'package:smart_garden/base/network/errors/error.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_garden/base/network/models/base_data.dart';

extension DioErrorMessage on DioException {
  BaseError get baseError {
    BaseError errorMessage = const BaseError.httpUnknownError("unknown");
    switch (type) {
      case DioExceptionType.cancel:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr());
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr());
        break;
      case DioExceptionType.unknown:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr());
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr());
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr());
        break;
      case DioExceptionType.badResponse:
        try {
          final data = BaseData.fromJson(
            response?.data,
            (json) {},
          );
          errorMessage = BaseError.dataError(data.message ?? 'error_system'.tr());
        } catch (e) {
          errorMessage = BaseError.httpInternalServerError('error_system'.tr());
        }
        break;
      default:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr());
        break;
    }
    return errorMessage;
  }
}

extension BaseErrorMessage on BaseError {
  String get getError {
    if (this is HttpInternalServerError) {
      return "error_system".tr();
    } else if (this is HttpUnAuthorizedError) {
      return "HttpUnAuthorizedError";
    } else if (this is DataError) {
      return (this as DataError).message;
    }
    return "error_system".tr();
  }
}
