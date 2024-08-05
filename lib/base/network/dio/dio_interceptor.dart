import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:smart_garden/common/constants/auth_constants.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/common/utils/functions/common_functions.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final Map<String, dynamic> header = {};
    final isPublicApi = EndpointConstants.publicAPI.any(
      (element) => checkPathMatch(
        pathPattern: element,
        urlPath: options.path,
      ),
    );
    if(isPublicApi == false) {
      final token =
          await getIt<SecureStorage>().get(AuthConstants.token);
      header[AuthConstants.authorization] = 'Bearer $token';
    }
    options.headers.addAll(header);
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      getIt<EventBus>().fire(const OpenLoginPageEvent());
      return handler.reject(err);
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ///valid response
    if (response.statusCode == 200 &&
        response.data != null &&
        response.data is Map &&
        response.data["data"] != null) {
      //if response has any error
      if (response.data["data"] is Map &&
          response.data["data"]["error"] != null) {
        return handler.reject(
          DioException(
            type: DioExceptionType.badResponse,
            requestOptions: response.requestOptions,
            response: response,
          ),
        );
      }
    }
    super.onResponse(response, handler);
  }
}
