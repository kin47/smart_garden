import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';
import 'package:smart_garden/features/data/response/login_response/login_response.dart';
import 'package:smart_garden/features/data/response/logout_response/logout_response.dart';
import 'package:smart_garden/features/data/response/register_response/register_response.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';

abstract class AuthRepository {
  Future<Either<BaseError, LoginResponse>> login({
    required LoginRequest request,
  });

  Future<Either<BaseError, RegisterResponse>> register({
    required RegisterRequest request,
  });

  Future<Either<BaseError, LogoutResponse>> logout();

  Future<Either<BaseError, UserEntity>> getUserInfo();

  Future<Either<BaseError, bool>> resendEmailVerification({
    required String email,
  });
}
