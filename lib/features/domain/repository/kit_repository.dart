import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/control_kit_request/control_kit_request.dart';
import 'package:smart_garden/features/domain/entity/kit_entity.dart';

abstract class KitRepository {
  Future<Either<BaseError, KitEntity>> getKitDetail({
    required int kitId,
  });

  Future<Either<BaseError, bool>> controlKit({
    required int kitId,
    required ControlKitRequest request,
  });
}
