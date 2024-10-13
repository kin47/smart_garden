import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/chat_message_model/chat_message_model.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';
import 'package:smart_garden/features/data/request/send_message_request/send_message_request.dart';

part 'chat_service.g.dart';

@RestApi()
@Injectable()
abstract class ChatService {
  @factoryMethod
  factory ChatService(Dio dio) = _ChatService;

  @GET(EndpointConstants.getChatMessages)
  Future<BaseListData<ChatMessageModel>> getChatMessages({
    @Queries() required PaginationRequest request,
  });

  @POST(EndpointConstants.sendMessage)
  Future<BaseData<ChatMessageModel>> sendMessage({
    @Body() required SendMessageRequest request,
  });
}
