part of 'diagnosis_bloc.dart';

@CopyWith()
class DiagnosisState extends BaseBlocState {
  const DiagnosisState({
    required super.status,
    super.message,
  });

  factory DiagnosisState.init() {
    return const DiagnosisState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
  ];
}
