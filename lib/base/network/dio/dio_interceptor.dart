import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:smart_garden/common/constants/auth_constants.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/common/utils/functions/common_functions.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';

class DioInterceptor extends Interceptor {
  static const String _retryAttempted = 'auth_retry_attempted';
  static const String _skipRefresh = 'skip_auth_refresh';

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
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    if (err.requestOptions.extra[_retryAttempted] == true) {
      getIt<EventBus>().fire(const OpenLoginPageEvent());
      return handler.reject(err);
    }

    if (err.requestOptions.extra[_skipRefresh] == true) {
      return super.onError(err, handler);
    }

    _refreshAndRetry(err, handler);
  }

  Future<void> _refreshAndRetry(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final storage = getIt<SecureStorage>();
      final refreshToken = await storage.get(AuthConstants.refreshToken);
      if (refreshToken == null || refreshToken.isEmpty) {
        throw StateError('Missing refresh token');
      }

      final response = await getIt<Dio>().post<Map<String, dynamic>>(
        EndpointConstants.refresh,
        data: <String, dynamic>{'refresh_token': refreshToken},
        options: Options(extra: <String, dynamic>{_skipRefresh: true}),
      );
      final data = response.data;
      final accessToken = data?['access_token'] as String?;
      final nextRefreshToken = data?['refresh_token'] as String?;
      if (accessToken == null || accessToken.isEmpty) {
        throw StateError('Refresh response has no access token');
      }

      await storage.save(AuthConstants.token, accessToken);
      if (nextRefreshToken != null && nextRefreshToken.isNotEmpty) {
        await storage.save(AuthConstants.refreshToken, nextRefreshToken);
      }

      final requestOptions = err.requestOptions;
      requestOptions.headers[AuthConstants.authorization] = 'Bearer $accessToken';
      requestOptions.extra[_retryAttempted] = true;
      final retryResponse = await getIt<Dio>().fetch<dynamic>(requestOptions);
      return handler.resolve(retryResponse);
    } on Object {
      getIt<EventBus>().fire(const OpenLoginPageEvent());
      return handler.reject(err);
    }
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
