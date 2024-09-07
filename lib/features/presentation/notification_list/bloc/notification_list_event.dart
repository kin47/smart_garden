part of 'notification_list_bloc.dart';

@freezed
class NotificationListEvent with _$NotificationListEvent {
  const factory NotificationListEvent.getNotifications({
    required int page,
  }) = _GetNotifications;

  const factory NotificationListEvent.readNotification({
    required int notificationId,
  }) = _ReadNotification;
}
