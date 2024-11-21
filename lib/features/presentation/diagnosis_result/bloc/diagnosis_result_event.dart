part of 'diagnosis_result_bloc.dart';

@freezed
class DiagnosisResultEvent with _$DiagnosisResultEvent {
  const factory DiagnosisResultEvent.getData({
    required int id,
  }) = _GetData;
}
