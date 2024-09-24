import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';

abstract class DiagnosisRepository {
  Future<Either<BaseError, List<DiagnosisEntity>>> getDiagnosisHistory({
    required PaginationRequest request,
  });

  Future<Either<BaseError, DiagnosisEntity>> predictDisease({
    required File image,
  });
}