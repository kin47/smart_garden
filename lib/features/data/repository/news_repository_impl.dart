import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/news_entity.dart';
import 'package:smart_garden/features/domain/repository/news_repository.dart';

@Injectable(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  @override
  Future<Either<BaseError, List<NewsEntity>>> getNews({
    required PaginationRequest request,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      return right(
        [
          NewsEntity(
            title: '10 tips trồng cây cà chua hiệu quả',
            content: '',
            thumbnail: 'https://cdn.tgdd.vn/Files/2019/11/26/1222276/3-cach-trong-ca-chua-triu-qua-bang-vat-dung-de-lam-tai-nha-202201071034175040.jpg',
            publishedAt: DateTime.now(),
          ),
          NewsEntity(
            title: 'Chiến lược thực hiện khi phát hiện cây bị bệnh',
            content: '',
            thumbnail: 'https://funix.edu.vn/wp-content/uploads/2023/10/funix-AI-phat-hien-benh-cay-trong.jpg',
            publishedAt: DateTime(2023, 10, 9, 10, 37),
          ),
          NewsEntity(
            title: 'Top 10 loại cây dễ trồng',
            content: '',
            thumbnail: 'https://cdn.tgdd.vn/Files/2019/11/26/1222276/3-cach-trong-ca-chua-triu-qua-bang-vat-dung-de-lam-tai-nha-202201071034175040.jpg',
            publishedAt: DateTime(2023, 10, 8, 10, 37),
          ),
          NewsEntity(
            title: 'Chiến lược thực hiện khi phát hiện cây bị bệnh',
            content: '',
            thumbnail: 'https://funix.edu.vn/wp-content/uploads/2023/10/funix-AI-phat-hien-benh-cay-trong.jpg',
            publishedAt: DateTime(2023, 10, 7, 10, 37),
          ),
        ]
      );
    } on DioException catch (e) {
      return left(e.baseError);
    }
  }
}
