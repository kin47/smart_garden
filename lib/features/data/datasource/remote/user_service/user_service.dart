import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/features/data/model/user_model/user_model.dart';
import 'package:smart_garden/features/data/request/register_request/register_request.dart';

@Injectable()
class UserService {
  final FirebaseFirestore _firebaseAuth = FirebaseFirestore.instance;

  Future<bool> createUser({
    required RegisterRequest request,
  }) async {
    try {
      await _firebaseAuth.collection('users').add({
        'email': request.email,
        'password': request.password,
        'phoneNumber': request.phoneNumber,
        'roles': request.roles.value,
      });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserInfo({
    required String email,
  }) async {
    final res = await _firebaseAuth.collection('users').where('email', isEqualTo: email).get();
    if (res.docs.isNotEmpty) {
      return UserModel.fromJson(res.docs.first.data());
    } else {
      throw Exception('User not found');
    }
  }
}
