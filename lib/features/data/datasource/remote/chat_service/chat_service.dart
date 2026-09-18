import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/chat_message_model/chat_message_model.dart';
import 'package:smart_garden/features/data/model/conversation_model.dart';
import 'package:smart_garden/features/data/request/get_chat_messages_request/get_chat_messages_request.dart';
import 'package:smart_garden/features/data/request/send_message_request/send_message_request.dart';

part 'chat_service.g.dart';

@RestApi()
@Injectable()
abstract class ChatService {
  @factoryMethod
  factory ChatService(Dio dio) = _ChatService;

  @POST(EndpointConstants.conversations)
  Future<BaseData<ConversationModel>> createSupportConversation({
    @Body() required Map<String, dynamic> body,
  });

  @GET(EndpointConstants.getChatMessages)
  Future<BaseListData<ChatMessageModel>> getChatMessages({
    @Path('conversation_id') required int conversationId,
    @Queries() required GetChatMessagesRequest request,
  });

  @POST(EndpointConstants.sendMessage)
  Future<BaseData<ChatMessageModel>> sendMessage({
    @Path('conversation_id') required int conversationId,
    @Body() required SendMessageRequest request,
  });

  @POST(EndpointConstants.readConversation)
  Future<BaseData<dynamic>> readConversation({
    @Path('conversation_id') required int conversationId,
    @Body() required Map<String, dynamic> body,
  });
}
