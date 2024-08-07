part of 'core_bloc.dart';

@freezed
class CoreEvent with _$CoreEvent {
  const factory CoreEvent.init() = _Init;

  const factory CoreEvent.changeTab(CoreTab tab) = _ChangeTab;
}
