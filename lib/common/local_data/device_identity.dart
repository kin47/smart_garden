import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:smart_garden/common/constants/other_constants.dart';
import 'package:smart_garden/common/local_data/shared_pref.dart';
import 'package:smart_garden/di/di_setup.dart';

@singleton
class DeviceIdentity {
  Future<String> getDeviceId() async {
    final storage = getIt<LocalStorage>();
    final existingId = await storage.get<String>(DeviceTokenConstants.deviceId);
    if (existingId != null && existingId.isNotEmpty) {
      return existingId;
    }

    final deviceId = _generateDeviceId();
    await storage.save(DeviceTokenConstants.deviceId, deviceId);
    return deviceId;
  }

  String _generateDeviceId() {
    final random = Random.secure();
    final values = List<int>.generate(16, (_) => random.nextInt(256));
    values[6] = (values[6] & 0x0f) | 0x40;
    values[8] = (values[8] & 0x3f) | 0x80;
    final hex = values.map((value) => value.toRadixString(16).padLeft(2, '0'));
    final id = hex.join();
    return '${id.substring(0, 8)}-${id.substring(8, 12)}-'
        '${id.substring(12, 16)}-${id.substring(16, 20)}-'
        '${id.substring(20)}';
  }
}
