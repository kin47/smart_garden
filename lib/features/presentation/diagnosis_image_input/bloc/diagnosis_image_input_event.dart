part of 'diagnosis_image_input_bloc.dart';

@freezed
class DiagnosisImageInputEvent with _$DiagnosisImageInputEvent {
  const factory DiagnosisImageInputEvent.uploadImage({
    required XFile image,
  }) = _UploadImage;
}
