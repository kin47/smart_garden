import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/datasource/remote/auth_service/auth_service.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';
import 'package:smart_garden/features/data/request/resend_email_request/resend_email_request.dart';
import 'package:smart_garden/features/data/response/login_response/login_response.dart';
import 'package:smart_garden/features/data/response/logout_response/logout_response.dart';
import 'package:smart_garden/features/data/response/register_response/register_response.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, LoginResponse>> login({
    required LoginRequest request,
  }) async {
    try {
      final response = await _service.login(request: request);
      return right(response);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, RegisterResponse>> register({
    required RegisterRequest request,
  }) async {
    try {
      final response = await _service.register(request: request);
      return right(response);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, LogoutResponse>> logout() async {
    try {
      final response = await _service.logout();
      return right(response);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, UserEntity>> getUserInfo() async {
    try {
      final response = await _service.getUserInfo();
      if (response.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(UserEntity.fromModel(response.data!));
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, bool>> resendEmailVerification({
    required String email,
  }) async {
    try {
      final response = await _service.resendEmailVerification(
          request: ResendEmailRequest(email: email));
      if (response.message == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(true);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
