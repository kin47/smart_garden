import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/request/device_token_request/device_token_request.dart';

part 'device_token_service.g.dart';

@RestApi()
@Injectable()
abstract class DeviceTokenService {
  @factoryMethod
  factory DeviceTokenService(Dio dio) = _DeviceTokenService;

  @POST(EndpointConstants.deviceToken)
  Future<BaseData> registerDeviceToken({
    @Body() required DeviceTokenRequest request,
  });

  @DELETE(EndpointConstants.deviceToken)
  Future<BaseData> deleteDeviceToken({
    @Body() required DeviceTokenRequest request,
  });
}
