import 'package:dartz/dartz.dart';
import 'package:smart_garden/base/network/errors/error.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/domain/entity/news_entity.dart';

abstract class NewsRepository {
  Future<Either<BaseError, List<NewsEntity>>> getNews({
    required PaginationRequest request,
  });
}
