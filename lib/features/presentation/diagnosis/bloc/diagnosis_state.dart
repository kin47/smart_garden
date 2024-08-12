part of 'diagnosis_bloc.dart';

@CopyWith()
class DiagnosisState extends BaseBlocState {
  final DiagnosisTab activeTab;

  const DiagnosisState({
    required super.status,
    super.message,
    required this.activeTab,
  });

  factory DiagnosisState.init() {
    return const DiagnosisState(
      status: BaseStateStatus.init,
      activeTab: DiagnosisTab.imageInput,
    );
  }

  @override
  List get props => [
    status,
    message,
    activeTab,
  ];
}
