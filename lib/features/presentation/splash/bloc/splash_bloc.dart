import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/enum/role_type.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';
import 'package:smart_garden/features/domain/repository/user_repository.dart';

part 'splash_event.dart';

part 'splash_state.dart';

part 'splash_bloc.freezed.dart';

part 'splash_bloc.g.dart';

@injectable
class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc(
    this._authRepository,
    this._userRepository,
  ) : super(SplashState.init()) {
    on<SplashEvent>((event, emit) async {
      await event.when(
        init: () => init(emit),
      );
    });
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future init(Emitter<SplashState> emit) async {
    final user = _authRepository.getUserInfo();
    await user.fold(
      (l) async {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            actionState: SplashActionState.goToLogin,
          ),
        );
      },
      (r) async {
        final userRes = await _userRepository.getUserInfo(email: r.email ?? '');
        userRes.fold(
          (l) {
            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                actionState: SplashActionState.goToLogin,
              ),
            );
          },
          (r) {
            emit(
              state.copyWith(
                status: BaseStateStatus.success,
                actionState: r.role == RoleType.admin
                    ? SplashActionState.goToAdminHome
                    : SplashActionState.goToUserHome,
                user: r,
              ),
            );
          },
        );
      },
    );
  }
}
