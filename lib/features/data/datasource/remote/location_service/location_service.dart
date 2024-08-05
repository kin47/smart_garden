import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_garden/features/data/model/location_model/location_model.dart';

@Injectable()
class LocationService {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Future<bool> sendLocation({
    required String userEmail,
    required DateTime time,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await _firebase
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (res.docs.isEmpty) {
        throw Exception('User not found');
      }
      await _firebase
          .collection('users')
          .doc(res.docs[0].id)
          .collection('locations')
          .add({
        'latitude': latitude,
        'longitude': longitude,
        'time': time,
      });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<LocationModel> getBlindPersonLocation({
    required String userEmail,
  }) async {
    try {
      final user = await _firebase
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();
      if (user.docs.isEmpty) {
        throw Exception('User not found');
      }
      final snapshots = await _firebase
          .collection('users')
          .doc(user.docs[0].id)
          .collection('locations')
          .orderBy('time', descending: true)
          .get();
      final data = snapshots.docs.first.data();
      return LocationModel(
        latitude: data['latitude'] as double,
        longitude: data['longitude'] as double,
        time: (data['time'] as Timestamp).toDate(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
