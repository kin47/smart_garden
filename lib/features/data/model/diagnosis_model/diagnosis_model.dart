import 'package:freezed_annotation/freezed_annotation.dart';

part 'diagnosis_model.freezed.dart';

part 'diagnosis_model.g.dart';

@freezed
class DiagnosisModel with _$DiagnosisModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DiagnosisModel({
    int? id,
    String? image,
    String? plant,
    String? treatment,
    String? disease,
    DateTime? sendAt,
    String? reference,
  }) = _DiagnosisModel;

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisModelFromJson(json);
}
