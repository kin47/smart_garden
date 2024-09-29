part of 'kit_environment_bloc.dart';

@CopyWith()
class KitEnvironmentState extends BaseBlocState {
  final double? temperature;
  final double? humidity;
  final double? light;
  final double? soilMoisture;

  const KitEnvironmentState({
    required super.status,
    super.message,
    this.temperature,
    this.humidity,
    this.light,
    this.soilMoisture,
  });

  factory KitEnvironmentState.init() => const KitEnvironmentState(
    status: BaseStateStatus.init,
  );

  @override
  List get props => [
    status,
    message,
    temperature,
    humidity,
    light,
    soilMoisture,
  ];
}
