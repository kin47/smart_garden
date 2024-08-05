import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/extensions/string_extension.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/enum/role_type.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';
import 'package:smart_garden/features/domain/repository/user_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

part 'login_bloc.g.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(
    this._authRepository,
    this._userRepository,
  ) : super(LoginState.init()) {
    on<LoginEvent>((event, emit) async {
      await event.when(
        onInputUsername: (username) => onInputUsername(emit, username),
        onInputPassword: (password) => onInputPassword(emit, password),
        onPasswordVisibilityChanged: (isVisible) =>
            onPasswordVisibilityChanged(emit, isVisible),
        login: () => login(emit),
      );
    });
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> onInputUsername(
      Emitter<LoginState> emit, String username) async {
    emit(
      state.copyWith(
        username: username,
        status: BaseStateStatus.idle,
        actionState: LoginActionState.idle,
      ),
    );
  }

  Future<void> onInputPassword(
      Emitter<LoginState> emit, String password) async {
    emit(
      state.copyWith(
        password: password,
        status: BaseStateStatus.idle,
        actionState: LoginActionState.idle,
      ),
    );
  }

  Future<void> onPasswordVisibilityChanged(
      Emitter<LoginState> emit, bool isVisible) async {
    emit(
      state.copyWith(
        isPasswordVisible: isVisible,
        status: BaseStateStatus.idle,
        actionState: LoginActionState.idle,
      ),
    );
  }

  Future login(Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
        actionState: LoginActionState.idle,
      ),
    );

    final authRes = await _authRepository.signInWithEmailAndPassword(
      request: LoginRequest(
        email: state.username,
        password: state.password,
      ),
    );

    await authRes.fold((l) async {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          actionState: LoginActionState.loginError,
          message: l.getError,
        ),
      );
    }, (r) async {
      final userRes = await _userRepository.getUserInfo(email: state.username);
      userRes.fold((l) {
        emit(
          state.copyWith(
            status: BaseStateStatus.failed,
            actionState: LoginActionState.loginError,
            message: l.getError,
          ),
        );
      }, (r) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
            actionState: r.role == RoleType.admin
                ? LoginActionState.goToAdminHome
                : LoginActionState.goToUserHome,
            user: r,
          ),
        );
      });
    });
  }
}
