import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/datasource/remote/diagnosis_service/diagnosis_service.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/domain/events/event_bus_event.dart';
import 'package:smart_garden/features/domain/repository/diagnosis_repository.dart';

@Injectable(as: DiagnosisRepository)
class DiagnosisRepositoryImpl implements DiagnosisRepository {
  final DiagnosisService _service;

  DiagnosisRepositoryImpl(this._service);

  @override
  Future<Either<BaseError, List<DiagnosisEntity>>> getDiagnosisHistory({
    required PaginationRequest request,
  }) async {
    try {
      final res = await _service.getDiagnosisHistory(request: request);
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(res.data!.map((e) => DiagnosisEntity.fromModel(e)).toList());
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }

  @override
  Future<Either<BaseError, DiagnosisEntity>> predictDisease({
    required File image,
  }) async {
    try {
      final res = await _service.predictDisease(
        image: image,
        onSendProgress: (sent, total) {
          double percentage = (sent / total * 100);
          print(
              'sent: $sent, total: $total, percentage: ${percentage.toStringAsFixed(2)}%');
          if (percentage >= 100) percentage = 100;
          getIt<EventBus>().fire(UploadFileEvent(percentage));
        },
      );
      if (res.data == null) {
        return left(BaseError.httpUnknownError('error_system'.tr()));
      }
      return right(DiagnosisEntity.fromModel(res.data!));
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
