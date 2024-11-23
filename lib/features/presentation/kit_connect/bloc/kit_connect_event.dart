part of 'kit_connect_bloc.dart';

@freezed
class KitConnectEvent with _$KitConnectEvent {
  const factory KitConnectEvent.init({
    required int kitId,
  }) = _Init;

  const factory KitConnectEvent.onPasswordVisibilityChanged({
    required bool isVisible,
  }) = _OnPasswordVisibilityChanged;

  const factory KitConnectEvent.connect({
    required String password,
  }) = _Connect;
}
