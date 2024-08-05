import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    final res = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return res;
  }

  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    final res = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return res;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
