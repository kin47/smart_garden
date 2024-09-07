part of 'notification_list_bloc.dart';

@CopyWith()
class NotificationListState extends BaseBlocState {
  const NotificationListState({
    required super.status,
    super.message,
  });

  factory NotificationListState.init() => const NotificationListState(
    status: BaseStateStatus.init,
  );

  @override
  List get props => [
    status,
    message,
  ];
}
