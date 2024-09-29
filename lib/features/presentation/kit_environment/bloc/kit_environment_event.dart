part of 'kit_environment_bloc.dart';

@freezed
class KitEnvironmentEvent with _$KitEnvironmentEvent {
  const factory KitEnvironmentEvent.updateData({
    double? temperature,
    double? humidity,
    double? light,
    double? soilMoisture,
  }) = _UpdateData;
}
