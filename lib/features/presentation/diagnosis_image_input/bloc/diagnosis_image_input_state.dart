part of 'diagnosis_image_input_bloc.dart';

@CopyWith()
class DiagnosisImageInputState extends BaseBlocState {
  const DiagnosisImageInputState({
    required super.status,
    super.message,
  });

  factory DiagnosisImageInputState.init() => const DiagnosisImageInputState(
        status: BaseStateStatus.init,
      );

  @override
  List get props => [
    status,
    message,
  ];
}
