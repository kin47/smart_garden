part of 'diagnosis_history_bloc.dart';

@CopyWith()
class DiagnosisHistoryState extends BaseBlocState {
  const DiagnosisHistoryState({
    required super.status,
    super.message,
  });

  factory DiagnosisHistoryState.init() {
    return const DiagnosisHistoryState(
      status: BaseStateStatus.init,
    );
  }

  @override
  List get props => [
    status,
    message,
  ];
}
