import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/constants/auth_constants.dart';
import 'package:smart_garden/common/index.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/common/utils/functions/jwt_decode.dart';
import 'package:smart_garden/di/di_setup.dart';
import 'package:smart_garden/features/data/request/login_request/login_request.dart';
import 'package:smart_garden/features/domain/entity/user_entity.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

part 'login_bloc.g.dart';

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._authRepository) : super(LoginState.init()) {
    on<LoginEvent>((event, emit) async {
      await event.when(
        onInputUsername: (username) => onInputUsername(emit, username),
        onInputPassword: (password) => onInputPassword(emit, password),
        onPasswordVisibilityChanged: (isVisible) =>
            onPasswordVisibilityChanged(emit, isVisible),
        login: () => login(emit),
        resendEmail: () => resendEmail(emit),
      );
    });
  }

  final AuthRepository _authRepository;

  Future<void> onInputUsername(
      Emitter<LoginState> emit, String username) async {
    emit(
      state.copyWith(
        username: username,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future<void> onInputPassword(
      Emitter<LoginState> emit, String password) async {
    emit(
      state.copyWith(
        password: password,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future<void> onPasswordVisibilityChanged(
      Emitter<LoginState> emit, bool isVisible) async {
    emit(
      state.copyWith(
        isPasswordVisible: isVisible,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future login(Emitter<LoginState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));

    final result = await _authRepository.login(
      request: LoginRequest(
        email: state.username,
        password: state.password,
      ),
    );

    await result.fold((l) async {
      emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      );
    }, (r) async {
      await getIt<SecureStorage>().save(AuthConstants.token, r.accessToken);
      final jwtModel = JwtDecoder.tryDecode(r.accessToken ?? '');
      if (jwtModel != null) {
        await getIt<LocalStorage>().save(KitConstants.kitId, jwtModel.kitId);
      }
      emit(
        state.copyWith(
          status: BaseStateStatus.success,
        ),
      );
    });
  }

  Future resendEmail(Emitter<LoginState> emit) async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    final result = await _authRepository.resendEmailVerification(
      email: state.username,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          status: BaseStateStatus.failed,
          message: l.getError,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: BaseStateStatus.showPopUp,
        ),
      ),
    );
  }
}
