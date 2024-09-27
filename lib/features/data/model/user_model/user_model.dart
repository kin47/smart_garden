import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory UserModel({
    int? id,
    String? email,
    String? name,
    String? phoneNumber,
    String? avatar,
    String? coverImage,
    bool? isAdmin,
    bool? canPredictDisease,
    bool? canReceiveNoti,
    bool? isVerified,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
