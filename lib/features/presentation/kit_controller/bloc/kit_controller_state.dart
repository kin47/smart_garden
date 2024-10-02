part of 'kit_controller_bloc.dart';

@CopyWith()
class KitControllerState extends BaseBlocState {
  final int kitId;
  final bool isLightOn;
  final bool isPumpOn;
  final bool autoLight;
  final bool autoPump;
  final int lightThreshold;
  final int pumpThreshold;

  const KitControllerState({
    required super.status,
    super.message,
    required this.kitId,
    required this.isLightOn,
    required this.isPumpOn,
    required this.autoLight,
    required this.autoPump,
    required this.lightThreshold,
    required this.pumpThreshold,
  });

  factory KitControllerState.init() => const KitControllerState(
        status: BaseStateStatus.init,
        kitId: 0,
        isLightOn: false,
        isPumpOn: false,
        autoLight: false,
        autoPump: false,
        lightThreshold: 0,
        pumpThreshold: 0,
      );

  @override
  List get props => [
        status,
        message,
        kitId,
        isLightOn,
        isPumpOn,
        autoLight,
        autoPump,
        lightThreshold,
        pumpThreshold,
      ];
}
