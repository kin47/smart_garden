import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/common/analytic/enum/analytics_event_type.dart';

part 'analytics_params.freezed.dart';
part 'analytics_params.g.dart';

@freezed
class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent({
    required AnalyticsEventType name,
    required AnalyticsParams params,
  }) = _AnalyticsEvent;

  factory AnalyticsEvent.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsEventFromJson(json);

  factory AnalyticsEvent.informationList({
    required String information,
  }) {
    return AnalyticsEvent(
      name: AnalyticsEventType.informationList,
      params: AnalyticsParams.informationList(information: information),
    );
  }

  factory AnalyticsEvent.usefulInformation({
    String? action,
    String? url,
  }) {
    return AnalyticsEvent(
      name: AnalyticsEventType.usefulInformation,
      params: AnalyticsParams.usefulInformation(action: action, url: url),
    );
  }
}

@freezed
class AnalyticsParams with _$AnalyticsParams {
  //"お知らせ一覧
  // List thông báo"	information_list	information	"メッセージID
  // message ID"
  const factory AnalyticsParams.informationList({
    //message id
    required String information,
  }) = Information;

  //"お役立ち情報
  // Thông tin hữu ích"	useful_information	action
  // 		url
  @Assert('action==null || url ==null', 'action or url must not be null')
  const factory AnalyticsParams.usefulInformation({
    String? action,
    //url
    String? url,
  }) = UsefulInformation;

  factory AnalyticsParams.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsParamsFromJson(json);
}
