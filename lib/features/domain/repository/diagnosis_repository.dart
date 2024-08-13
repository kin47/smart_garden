import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';

abstract class DiagnosisRepository {
  Future<Either<BaseError, List<DiagnosisEntity>>> getDiagnosisHistory({
    required int page,
  });
}