import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pascaldart/common.dart';

/// Secure store implementation that stores sensitive data
class Vault {
  static const String PRIVATEKEY_KEY = 'pascal_privatekey';
  static const String PIN_KEY = 'blaise_pin';

  FlutterSecureStorage _secureStorage;
  PrivateKeyCoder _privateKeyCoder;


  Vault() {
    this._secureStorage = FlutterSecureStorage();
    this._privateKeyCoder = PrivateKeyCoder();
  }

  // Generic write/read
  Future<String> _write(String key, String value) async {
    await _secureStorage.write(key:key, value:value);
    return value;
  }

  Future<String> _read(String key, {String defaultValue}) async {
    return await _secureStorage.read(key:key) ?? defaultValue;
  }

  // Private key
  Future<String> getPrivateKey() async {
    return await _read(PRIVATEKEY_KEY);
  }

  Future<String> setPrivateKey(PrivateKey privateKey) async {
    return await _write(PRIVATEKEY_KEY,  _privateKeyCoder.encodeToHex(privateKey));
  }

  // Pin
  Future<String> getPin() async {
    return await _read(PIN_KEY);
  }

  Future<String> setPin(String pin) async {
    return await _write(PIN_KEY, pin);
  }

  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }
}