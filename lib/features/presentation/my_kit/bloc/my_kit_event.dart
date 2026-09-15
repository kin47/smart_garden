part of 'my_kit_bloc.dart';

@freezed
abstract class MyKitEvent with _$MyKitEvent {
  const factory MyKitEvent.changeTab({
    required MyKitTab tab,
  }) = _ChangeTab;
}
