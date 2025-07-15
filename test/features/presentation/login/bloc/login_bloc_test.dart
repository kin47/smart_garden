import 'package:flutter_test/flutter_test.dart';
import 'package:smart_garden/features/presentation/login/bloc/login_bloc.dart';
import 'package:smart_garden/features/domain/repository/auth_repository.dart';
import 'package:smart_garden/common/local_data/secure_storage.dart';
import 'package:smart_garden/common/local_data/shared_pref.dart';
import 'package:smart_garden/base/bloc/bloc_status.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:get_it/get_it.dart';
import 'login_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<SecureStorage>(),
  MockSpec<LocalStorage>(),
])
void main() {
  final sl = GetIt.instance;
  late MockAuthRepository authRepository;
  late MockSecureStorage secureStorage;
  late MockLocalStorage localStorage;
  late LoginBloc loginBloc;

  setUp(() {
    authRepository = MockAuthRepository();
    secureStorage = MockSecureStorage();
    localStorage = MockLocalStorage();

    sl.registerSingleton<AuthRepository>(authRepository);
    sl.registerSingleton<SecureStorage>(secureStorage);
    sl.registerSingleton<LocalStorage>(localStorage);

    loginBloc = LoginBloc(authRepository);
  });

  tearDown(() async {
    await loginBloc.close();
    sl.reset();
  });

  test('initial state is LoginState.init()', () {
    expect(loginBloc.state, LoginState.init());
  });

  blocTest<LoginBloc, LoginState>(
    'emits updated username when onInputUsername is added',
    build: () => loginBloc,
    act: (bloc) => bloc.add(LoginEvent.onInputUsername(username: 'testuser')),
    expect: () => [
      loginBloc.state.copyWith(username: 'testuser', status: BaseStateStatus.idle),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'emits updated password when onInputPassword is added',
    build: () => loginBloc,
    act: (bloc) => bloc.add(LoginEvent.onInputPassword(password: 'password123')),
    expect: () => [
      loginBloc.state.copyWith(password: 'password123', status: BaseStateStatus.idle),
    ],
  );

  blocTest<LoginBloc, LoginState>(
    'emits updated isPasswordVisible when onPasswordVisibilityChanged is added',
    build: () => loginBloc,
    act: (bloc) => bloc.add(LoginEvent.onPasswordVisibilityChanged(isVisible: true)),
    expect: () => [
      loginBloc.state.copyWith(isPasswordVisible: true, status: BaseStateStatus.idle),
    ],
  );

  // Add more tests for login and resendEmail as needed, mocking the repository responses.
}
