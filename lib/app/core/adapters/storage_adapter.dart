import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';

import '../constants.dart';
import '../data/dtos/credential_dto.dart';

abstract class BoxNames {
  static const auth = "authBox";
}

class StorageAdapter {
  StorageAdapter({
    required Box authBox,
  }) : _authBox = authBox;

  static late final StorageAdapter _instance;
  late final Box _authBox;

  factory StorageAdapter.getInstance() {
    return _instance;
  }

  static Future<void> init() async {
    const secureStorage = FlutterSecureStorage();
    var key = await secureStorage.read(
      key: storageKey,
    );
    if (key == null) {
      final secureKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: storageKey,
        value: base64Url.encode(secureKey),
      );
      key = await secureStorage.read(
        key: storageKey,
      );
    }
    await Hive.initFlutter();
    final authBox = await Hive.openBox(
      BoxNames.auth,
      encryptionCipher: HiveAesCipher(base64Url.decode(key!)),
    );

    _instance = StorageAdapter(
      authBox: authBox,
    );
  }

  Future<void> saveAuthData({
    required String identifier,
    required String password,
  }) async {
    final credential = CredentialDto(
      identifier: identifier,
      password: password,
    );
    await _authBox.put(
      BoxNames.auth,
      jsonEncode(
        credential.toMap(),
      ),
    );
  }

  Future<CredentialDto?> getAuthData() async {
    final data = _authBox.get(
      BoxNames.auth,
    );
    if (data == null) {
      return null;
    }
    final decodedData = jsonDecode(data);
    return CredentialDto(
      identifier: decodedData["identifier"],
      password: decodedData["password"],
    );
  }

  Future<void> deleteAuthData() async {
    await _authBox.delete(
      BoxNames.auth,
    );
  }
}
