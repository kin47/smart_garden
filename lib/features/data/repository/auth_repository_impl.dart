import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/datasource/remote/auth_service/auth_service.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthService _service;

  AuthRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, UserCredential>> register({
    required RegisterRequest request,
  }) async {
    try {
      final res = await _service.register(
        email: request.email,
        password: request.password,
      );
      return right(res);
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }

  @override
  Future<Either<BaseError, UserCredential>> signInWithEmailAndPassword({
    required LoginRequest request,
  }) async {
    try {
      final res = await _service.login(
        email: request.email,
        password: request.password,
      );
      return right(res);
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }

  @override
  Future<Either<BaseError, bool>> signOut() async {
    try {
      await _service.signOut();
      return right(true);
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }

  @override
  Either<BaseError, User> getUserInfo() {
    try {
      final res = _service.currentUser;
      if (res == null) {
        return left(BaseError.httpUnknownError('User not found'));
      }
      return right(res);
    } catch (e) {
      return left(BaseError.httpUnknownError('error_system'.tr()));
    }
  }
}
