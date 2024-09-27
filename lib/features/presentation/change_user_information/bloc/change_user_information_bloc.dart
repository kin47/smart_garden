import 'dart:io';

import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';

part 'change_user_information_event.dart';

part 'change_user_information_state.dart';

part 'change_user_information_bloc.freezed.dart';

part 'change_user_information_bloc.g.dart';

@injectable
class ChangeUserInformationBloc
    extends BaseBloc<ChangeUserInformationEvent, ChangeUserInformationState> {
  ChangeUserInformationBloc(this._authRepository)
      : super(ChangeUserInformationState.init()) {
    on<ChangeUserInformationEvent>((event, emit) async {
      await event.when(
        init: (user) => _init(emit, user),
        onChangeAvatar: (avatar) => _onChangeAvatar(emit, avatar),
        onChangeCoverImage: (coverImage) =>
            _onChangeCoverImage(emit, coverImage),
        onInputName: (name) => _onInputName(emit, name),
        onInputCurrentPassword: (password) =>
            _onInputCurrentPassword(emit, password),
        onInputNewPassword: (password) => _onInputNewPassword(emit, password),
        onPasswordVisibilityChanged: (isVisible) =>
            _onPasswordVisibilityChanged(emit, isVisible),
        updateUserInfo: () => _updateUserInfo(emit),
      );
    });
  }

  final AuthRepository _authRepository;

  Future _init(
      Emitter<ChangeUserInformationState> emit, UserEntity user) async {
    emit(
      state.copyWith(
        currentName: user.name,
        newName: user.name,
        avatarUrl: user.avatar,
        coverImageUrl: user.coverImage,
      ),
    );
  }

  Future _onChangeAvatar(
      Emitter<ChangeUserInformationState> emit, XFile avatar) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        newAvatar: avatar,
      ),
    );
  }

  Future _onChangeCoverImage(
      Emitter<ChangeUserInformationState> emit, XFile coverImage) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        newCoverImage: coverImage,
      ),
    );
  }

  Future _onInputName(
      Emitter<ChangeUserInformationState> emit, String name) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        newName: name,
      ),
    );
  }

  Future _onInputCurrentPassword(
      Emitter<ChangeUserInformationState> emit, String password) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        currentPassword: password,
      ),
    );
  }

  Future _onInputNewPassword(
      Emitter<ChangeUserInformationState> emit, String password) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        newPassword: password,
      ),
    );
  }

  Future _onPasswordVisibilityChanged(
      Emitter<ChangeUserInformationState> emit, bool isVisible) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.idle,
        isPasswordVisible: isVisible,
      ),
    );
  }

  Future _updateUserInfo(Emitter<ChangeUserInformationState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final File? newAvatar =
        state.newAvatar != null ? File(state.newAvatar!.path) : null;
    final File? newCoverImage =
        state.newCoverImage != null ? File(state.newCoverImage!.path) : null;
    final response = await _authRepository.updateUserInfo(
      name: state.newName,
      currentPassword: state.currentPassword,
      newPassword: state.newPassword,
      avatar: newAvatar,
      coverImage: newCoverImage,
    );
    response.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.success,
        ),
      ),
    );
  }
}
