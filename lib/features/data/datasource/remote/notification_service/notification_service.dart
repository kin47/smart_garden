import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:smart_garden/base/network/models/base_data.dart';
import 'package:smart_garden/common/constants/endpoint_constants.dart';
import 'package:smart_garden/features/data/model/notification_model/notification_model.dart';
import 'package:smart_garden/features/data/request/pagination_request/pagination_request.dart';

part 'notification_service.g.dart';

@RestApi()
@Injectable()
abstract class NotificationService {
  @factoryMethod
  factory NotificationService(Dio dio) = _NotificationService;

  @GET(EndpointConstants.notification)
  Future<BaseListData<NotificationModel>> getNotifications({
    @Queries() required PaginationRequest request,
  });

  @PUT(EndpointConstants.markAsRead)
  Future<BaseData> markAsRead({
    @Path('notification_id') required String notificationId,
  });
}
