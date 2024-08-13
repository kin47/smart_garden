import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/entity/store_entity.dart';
import 'package:smart_garden/features/domain/repository/store_repository.dart';

@Injectable(as: StoreRepository)
class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl();

  @override
  Future<Either<BaseError, List<StoreEntity>>> getStores({
    required int page,
  }) async {
    try {
      // final res = await _service.getStores();
      await Future.delayed(Duration(milliseconds: 1500));
      return right([
        const StoreEntity(
          id: 1,
          name: "Đại lý tổng Smart Garden",
          address: "78 Lò Đúc, quận Hai Bà Trưng, Hà Nội",
          latitude: 21.015742,
          longitude: 105.856581,
          phoneNumber: "0987654321",
        ),
        const StoreEntity(
          id: 2,
          name: "Chi nhánh Nam Từ Liêm",
          address: "Toà nhà Sông Đà, quận Nam Từ Liêm, Hà Nội",
          latitude: 21.017656,
          longitude: 105.781437,
          phoneNumber: "0987654322",
        ),
        const StoreEntity(
          id: 3,
          name: "Chi nhánh Hà Đông",
          address:
              "Học viện Công nghệ Bưu chính Viễn thông, quận Hà Đông, Hà Nội",
          latitude: 20.980924767796505,
          longitude: 105.78742917905159,
          phoneNumber: "0987654323",
        ),
      ]);
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
