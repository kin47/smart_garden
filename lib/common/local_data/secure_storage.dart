import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
class SecureStorage {
  final FlutterSecureStorage _storage;

  SecureStorage({required FlutterSecureStorage storage}) : _storage = storage;

  Future<void> save(
      String key,
      dynamic value, {
        bool needEncrypt = true,
      }) async {
    if (Platform.isIOS && needEncrypt) {
      await _storage.write(
        key: key,
        value: value.toString(),
      );
    } else {
      await _storage.write(key: key, value: value.toString());
    }
  }

  Future<String?> get(String key, {bool needDecrypt = true}) async {
    final result = await _storage.read(
      key: key,
    );
    return result;
  }

  Future<void> deleteItem(String key) async {
    await _storage.delete(key: key);
  }

  //deleteAll
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}