part of 'diagnosis_bloc.dart';

@freezed
class DiagnosisEvent with _$DiagnosisEvent {
  const factory DiagnosisEvent.changeTab({
    required DiagnosisTab tabType,
  }) = _DiagnosisChangeTab;
}
