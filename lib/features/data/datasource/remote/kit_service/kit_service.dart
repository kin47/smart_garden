import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/kit_model/kit_model.dart';
import 'package:smart_garden/features/data/request/control_kit_request/control_kit_request.dart';

part 'kit_service.g.dart';

@RestApi()
@Injectable()
abstract class KitService {
  @factoryMethod
  factory KitService(Dio dio) = _KitService;

  @GET(EndpointConstants.kitDetail)
  Future<BaseData<KitModel>> getKits({
    @Path('kit_id') required int kitId,
  });

  @POST(EndpointConstants.controlKit)
  Future<BaseData> controlKit({
    @Path('kit_id') required int kitId,
    @Body() required ControlKitRequest request,
  });
}
