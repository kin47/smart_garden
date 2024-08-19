import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/store_model/store_model.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';

part 'store_service.g.dart';

@RestApi()
@Injectable()
abstract class StoreService {
  @factoryMethod
  factory StoreService(Dio dio) = _StoreService;

  @GET(EndpointConstants.store)
  Future<BaseListData<StoreModel>> getStores({
    @Queries() required PaginationRequest request,
  });
}
