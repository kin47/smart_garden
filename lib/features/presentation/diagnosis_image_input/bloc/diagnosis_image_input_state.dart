part of 'diagnosis_image_input_bloc.dart';

@CopyWith()
class DiagnosisImageInputState extends BaseBlocState {
  final File? image;
  final DiagnosisEntity? diagnosis;

  const DiagnosisImageInputState({
    required super.status,
    super.message,
    this.image,
    this.diagnosis,
  });

  factory DiagnosisImageInputState.init() => const DiagnosisImageInputState(
        status: BaseStateStatus.init,
      );

  @override
  List get props => [
    status,
    message,
    image,
    diagnosis,
  ];
}
