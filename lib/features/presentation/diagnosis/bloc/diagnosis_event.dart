part of 'diagnosis_bloc.dart';

@freezed
abstract class DiagnosisEvent with _$DiagnosisEvent {
  const factory DiagnosisEvent.changeTab({
    required DiagnosisTab tabType,
  }) = _DiagnosisChangeTab;
}
