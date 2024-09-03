part of 'kit_controller_bloc.dart';

@freezed
class KitControllerEvent with _$KitControllerEvent {
  const factory KitControllerEvent.init() = _Init;

  const factory KitControllerEvent.toggleLightManual({
    required bool isLightOn,
  }) = _ToggleLightManual;

  const factory KitControllerEvent.togglePumpManual({
    required bool isPumpOn,
  }) = _TogglePumpManual;

  const factory KitControllerEvent.toggleAutoLight({
    required bool autoLight,
  }) = _ToggleAutoLight;

  const factory KitControllerEvent.toggleAutoPump({
    required bool autoPump,
  }) = _ToggleAutoPump;

  const factory KitControllerEvent.changeLightThreshold({
    required int lightThreshold,
  }) = _ChangeLightThreshold;

  const factory KitControllerEvent.changePumpThreshold({
    required int pumpThreshold,
  }) = _ChangePumpThreshold;
}
