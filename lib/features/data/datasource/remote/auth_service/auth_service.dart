import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/user_model/user_model.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';
import 'package:smart_garden/features/data/request/resend_email_request/resend_email_request.dart';
import 'package:smart_garden/features/data/response/login_response/login_response.dart';
import 'package:smart_garden/features/data/response/logout_response/logout_response.dart';
import 'package:smart_garden/features/data/response/register_response/register_response.dart';

part 'auth_service.g.dart';

@RestApi()
@Injectable()
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST(EndpointConstants.login)
  Future<LoginResponse> login({
    @Body() required LoginRequest request,
  });

  @POST(EndpointConstants.register)
  Future<RegisterResponse> register({
    @Body() required RegisterRequest request,
  });

  @POST(EndpointConstants.logout)
  Future<LogoutResponse> logout();

  @GET(EndpointConstants.me)
  Future<BaseData<UserModel>> getUserInfo();

  @POST(EndpointConstants.resendEmailVerification)
  Future<BaseData> resendEmailVerification({
    @Body() required ResendEmailRequest request,
  });
}
