import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

part 'profile_bloc.freezed.dart';

part 'profile_bloc.g.dart';

@injectable
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.authRepository) : super(ProfileState.init()) {
    on<ProfileEvent>((event, emit) async {
      await event.when(
        init: () => init(emit),
        logout: () => logout(emit),
      );
    });
  }

  final AuthRepository authRepository;

  Future init(Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final res = await authRepository.getUserInfo();
    res.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.idle,
          user: r,
        ),
      ),
    );
  }

  Future logout(Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final res = await authRepository.logout();
    res.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.logout,
        ),
      ),
    );
  }
}
