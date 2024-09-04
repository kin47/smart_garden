part of 'kit_environment_bloc.dart';

@CopyWith()
class KitEnvironmentState extends BaseBlocState {
  final double temperature;
  final double humidity;
  final double light;
  final double soilMoisture;

  const KitEnvironmentState({
    required super.status,
    super.message,
    required this.temperature,
    required this.humidity,
    required this.light,
    required this.soilMoisture,
  });

  factory KitEnvironmentState.init() => const KitEnvironmentState(
    status: BaseStateStatus.init,
    temperature: 0,
    humidity: 0,
    light: 0,
    soilMoisture: 0,
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
