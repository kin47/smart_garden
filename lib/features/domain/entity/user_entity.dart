import 'package:smart_garden/features/data/model/user_model/user_model.dart';
import 'package:smart_garden/features/domain/enum/role_type.dart';

class UserEntity {
  final String id;
  final String phoneNumber;
  final String email;
  final RoleType role;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.role,
  });

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id ?? '',
      email: model.email ?? '',
      phoneNumber: model.phoneNumber ?? '',
      role: model.roles ?? RoleType.user,
    );
  }

  UserEntity copyWith({
    String? id,
    String? phoneNumber,
    String? email,
    RoleType? role,
  }) {
    return UserEntity(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}