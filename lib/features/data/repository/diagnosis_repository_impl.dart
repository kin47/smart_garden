import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/entity/diagnosis_entity.dart';
import 'package:smart_garden/features/domain/repository/diagnosis_repository.dart';

@Injectable(as: DiagnosisRepository)
class DiagnosisRepositoryImpl implements DiagnosisRepository {
  @override
  Future<Either<BaseError, List<DiagnosisEntity>>> getDiagnosisHistory({
    required int page,
  }) async {
    try {
      // final res = await _service.getStores();
      await Future.delayed(Duration(milliseconds: 1500));
      return right([
        DiagnosisEntity(
          id: 3,
          plant: "Cây khoai tây",
          disease: "Khoẻ mạnh",
          date: DateTime(2024, 8, 12),
          imageUrl: "https://banner2.cleanpng.com/20180323/wde/kisspng-mashed-potato-garden-amflora-vegetable-potato-5ab50f87f10452.0598114215218154319872.jpg",
        ),
        DiagnosisEntity(
          id: 1,
          plant: "Cây cà chua",
          disease: "Bệnh đốm lá cà chua",
          date: DateTime(2024, 8, 10),
          imageUrl: "https://img.freepik.com/premium-photo/fresh-tomato-plants-white-background_610532-324.jpg",
        ),
        DiagnosisEntity(
          id: 2,
          plant: "Cây cà chua",
          disease: "Khoẻ mạnh",
          date: DateTime(2021, 7, 4),
          imageUrl: "https://img.freepik.com/premium-photo/fresh-tomato-plants-white-background_610532-324.jpg",
        ),
      ]);
    } on DioException catch(e) {
      return left(e.baseError);
    }
  }
}
