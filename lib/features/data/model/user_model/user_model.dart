import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_garden/features/domain/enum/role_type.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    String? id,
    String? email,
    String? phoneNumber,
    RoleType? roles
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
