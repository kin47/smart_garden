part of 'core_bloc.dart';

@freezed
class CoreEvent with _$CoreEvent {
  const factory CoreEvent.init() = _Init;

  const factory CoreEvent.registerDeviceToken() = _RegisterDeviceToken;

  const factory CoreEvent.initializeWebSocket() = _InitializeWebSocket;

  const factory CoreEvent.changeTab(CoreTab tab) = _ChangeTab;
}
