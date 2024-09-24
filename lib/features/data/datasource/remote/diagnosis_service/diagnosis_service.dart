import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/diagnosis_model/diagnosis_model.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';

part 'diagnosis_service.g.dart';

@RestApi()
@Injectable()
abstract class DiagnosisService {
  @factoryMethod
  factory DiagnosisService(Dio dio) = _DiagnosisService;

  @MultiPart()
  @POST(EndpointConstants.predictDisease)
  Future<BaseData<DiagnosisModel>> predictDisease({
    @Part() required File image,
    @SendProgress() ProgressCallback? onSendProgress
  });

  @GET(EndpointConstants.predictHistory)
  Future<BaseListData<DiagnosisModel>> getDiagnosisHistory({
    @Queries() required PaginationRequest request,
  });
}
