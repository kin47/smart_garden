part of 'diagnosis_history_bloc.dart';

@freezed
abstract class DiagnosisHistoryEvent with _$DiagnosisHistoryEvent {
  const factory DiagnosisHistoryEvent.getData({
    required int page,
  }) = _GetData;
}
