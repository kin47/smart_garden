import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/base/bloc/base_bloc.dart';
import 'package:smart_garden/base/bloc/base_bloc_state.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:smart_garden/base/network/errors/extension.dart';
import 'package:smart_garden/common/extensions/string_extension.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';
import 'package:smart_garden/features/domain/enum/role_type.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';
import 'package:smart_garden/features/domain/repository/user_repository.dart';

part 'register_event.dart';

part 'register_state.dart';

part 'register_bloc.freezed.dart';

part 'register_bloc.g.dart';

@injectable
class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc(
    this._authRepository,
    this._userRepository,
  ) : super(RegisterState.init()) {
    on<RegisterEvent>((event, emit) async {
      await event.when(
        onInputEmail: (email) => onInputEmail(emit, email),
        onInputPassword: (password) => onInputPassword(emit, password),
        onInputPhoneNumber: (phoneNumber) =>
            onInputPhoneNumber(emit, phoneNumber),
        onPasswordVisibilityChanged: (isVisible) =>
            onPasswordVisibilityChanged(emit, isVisible),
        register: () => register(emit),
      );
    });
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  Future<void> onInputEmail(Emitter<RegisterState> emit, String email) async {
    emit(
      state.copyWith(
        email: email,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future<void> onInputPassword(
      Emitter<RegisterState> emit, String password) async {
    emit(
      state.copyWith(
        password: password,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future<void> onInputPhoneNumber(
      Emitter<RegisterState> emit, String phoneNumber) async {
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future<void> onPasswordVisibilityChanged(
      Emitter<RegisterState> emit, bool isVisible) async {
    emit(
      state.copyWith(
        isPasswordVisible: isVisible,
        status: BaseStateStatus.idle,
      ),
    );
  }

  Future<void> register(Emitter<RegisterState> emit) async {
    emit(
      state.copyWith(
        status: BaseStateStatus.loading,
      ),
    );

    final authRes = await Future.wait([
      _authRepository.register(
        request: RegisterRequest(
          email: state.email,
          phoneNumber: state.phoneNumber,
          password: state.password,
          roles: RoleType.user,
        ),
      ),
      _authRepository.register(
        request: RegisterRequest(
          /// create blind user account
          email: state.email.userEmail,
          phoneNumber: state.phoneNumber,
          password: state.password,
          roles: RoleType.user,
        ),
      ),
    ]);

    for (final item in authRes) {
      item.fold(
        (l) {
          emit(
            state.copyWith(
              status: BaseStateStatus.failed,
              message: l.getError,
            ),
          );
        },
        (r) {},
      );
    }

    if (authRes.every((element) => element.isRight())) {
      final userRes = await Future.wait([
        _userRepository.createUser(
          request: RegisterRequest(
            email: state.email,
            phoneNumber: state.phoneNumber,
            password: state.password,
            roles: RoleType.admin,
          ),
        ),
        _userRepository.createUser(
          request: RegisterRequest(
            /// create blind user account
            email: state.email.userEmail,
            phoneNumber: state.phoneNumber,
            password: state.password,
            roles: RoleType.user,
          ),
        ),
      ]);
      for (final item in userRes) {
        item.fold(
          (l) {
            emit(
              state.copyWith(
                status: BaseStateStatus.failed,
                message: l.getError,
              ),
            );
          },
          (r) {},
        );
      }
      if (userRes.every((element) => element.isRight())) {
        emit(
          state.copyWith(
            status: BaseStateStatus.success,
          ),
        );
      }
    }
  }
}
