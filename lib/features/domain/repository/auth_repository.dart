import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';

abstract class AuthRepository {
  Future<Either<BaseError, UserCredential>> signInWithEmailAndPassword({
    required LoginRequest request,
  });

  Future<Either<BaseError, UserCredential>> register({
    required RegisterRequest request,
  });

  Either<BaseError, User> getUserInfo();

  Future<Either<BaseError, bool>> signOut();
}
