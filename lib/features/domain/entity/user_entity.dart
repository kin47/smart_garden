import 'package:smart_garden/features/data/model/user_model/user_model.dart';

class UserEntity {
  final int id;
  final String email;
  final String name;
  final String phoneNumber;
  final String? avatar;
  final String? coverImage;
  final bool isAdmin;
  final bool canPredictDisease;
  final bool canReceiveNoti;
  final bool isVerified;
  final int? kitId;

  const UserEntity({
    required this.id,
    required this.phoneNumber,
    required this.email,
    required this.name,
    this.avatar,
    this.coverImage,
    this.isAdmin = false,
    this.canPredictDisease = false,
    this.canReceiveNoti = false,
    this.isVerified = false,
    this.kitId,
  });

  factory UserEntity.fromModel(UserModel model) {
    return UserEntity(
      id: model.id ?? 0,
      email: model.email ?? '',
      name: model.name ?? '',
      phoneNumber: model.phoneNumber ?? '',
      avatar: model.avatar,
      coverImage: model.coverImage,
      isAdmin: model.isAdmin ?? false,
      canPredictDisease: model.canPredictDisease ?? false,
      canReceiveNoti: model.canReceiveNoti ?? false,
      isVerified: model.isVerified ?? false,
      kitId: model.kitId,
    );
  }
}