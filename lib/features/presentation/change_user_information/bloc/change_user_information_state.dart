part of 'change_user_information_bloc.dart';

@CopyWith()
class ChangeUserInformationState extends BaseBlocState {
  final String currentName;
  final String newName;
  final String currentPassword;
  final String newPassword;
  final String? avatarUrl;
  final String? coverImageUrl;
  final XFile? newCoverImage;
  final XFile? newAvatar;
  final bool isPasswordVisible;

  const ChangeUserInformationState({
    required super.status,
    super.message,
    required this.currentName,
    required this.newName,
    required this.currentPassword,
    required this.newPassword,
    this.avatarUrl,
    this.coverImageUrl,
    this.newCoverImage,
    this.newAvatar,
    required this.isPasswordVisible,
  });

  factory ChangeUserInformationState.init() => const ChangeUserInformationState(
        status: BaseStateStatus.init,
        currentName: '',
        newName: '',
        currentPassword: '',
        newPassword: '',
        isPasswordVisible: false,
      );

  bool get enableSaveButton {
    if ((currentPassword.isNotEmpty && newPassword.isEmpty) ||
        (newPassword.isNotEmpty && currentPassword.isEmpty)) {
      return false;
    } else {
      return currentName != newName ||
          currentPassword.isNotEmpty ||
          newPassword.isNotEmpty ||
          newAvatar != null ||
          newCoverImage != null;
    }
  }

  @override
  List get props => [
        status,
        message,
        currentName,
        newName,
        currentPassword,
        newPassword,
        isPasswordVisible,
        avatarUrl,
        coverImageUrl,
        newCoverImage,
        newAvatar,
      ];
}
