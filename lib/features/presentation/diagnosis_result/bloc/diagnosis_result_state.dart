part of 'diagnosis_result_bloc.dart';

@CopyWith()
class DiagnosisResultState extends BaseBlocState {
  final DiagnosisEntity? diagnosis;

  const DiagnosisResultState({
    required super.status,
    super.message,
    this.diagnosis,
  });

  factory DiagnosisResultState.init() {
    return const DiagnosisResultState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
    diagnosis,
  ];
}
