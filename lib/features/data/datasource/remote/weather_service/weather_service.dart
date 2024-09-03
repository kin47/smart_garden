import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/weather_model/weather_model.dart';
import 'package:smart_garden/features/data/request/weather_request/weather_request.dart';

part 'weather_service.g.dart';

@RestApi()
@Injectable()
abstract class WeatherService {
  @factoryMethod
  factory WeatherService(@Named('weatherDio') Dio dio) = _WeatherService;

  @GET(EndpointConstants.weather)
  Future<WeatherModel> getWeather({
    @Queries() required WeatherRequest request,
  });
}
