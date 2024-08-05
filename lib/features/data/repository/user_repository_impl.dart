import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/datasource/remote/user_service/user_service.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserService _service;

  UserRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, bool>> createUser({
    required RegisterRequest request,
  }) async {
    try {
      final res = await _service.createUser(request: request);
      return right(res);
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }

  @override
  Future<Either<BaseError, UserEntity>> getUserInfo({
    required String email,
  }) async {
    try {
      final res = await _service.getUserInfo(email: email);
      return right(UserEntity.fromModel(res));
    } catch (e) {
      return left(BaseError.httpUnknownError(e.toString()));
    }
  }
}
