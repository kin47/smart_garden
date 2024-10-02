import 'package:freezed_annotation/freezed_annotation.dart';
part 'jwt_model.freezed.dart';
part 'jwt_model.g.dart';

@freezed
class JWTModel with _$JWTModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory JWTModel({
    int? userId,
    String? email,
    String? name,
    String? phoneNumber,
    bool? isAdmin,
    int? kitId,
    double? expiredAt,
  }) = _JWTModel;

  factory JWTModel.fromJson(Map<String, dynamic> json) => _$JWTModelFromJson(json);
}