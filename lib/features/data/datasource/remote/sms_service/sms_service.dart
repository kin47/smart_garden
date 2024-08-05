import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'sms_service.g.dart';

@RestApi()
@Injectable()
abstract class SmsService {
  @factoryMethod
  factory SmsService(Dio dio) = _SmsService;

  @POST("/send-sms")
  Future<void> sendSmsMessage({
    @Header("Content-Type") String contentType = "multipart/form-data",
    @Body() required FormData request,
  });
}
