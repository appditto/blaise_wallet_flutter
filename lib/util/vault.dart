import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/util/salsa20crypt.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pascaldart/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Secure store implementation that stores sensitive data
class Vault {
  static const String PRIVATEKEY_KEY = 'pascal_privatekey';
  static const String PIN_KEY = 'blaise_pin';

  FlutterSecureStorage _secureStorage;
  PrivateKeyCoder _privateKeyCoder;

  Future<bool> legacy() async {
    return await sl.get<SharedPrefsUtil>().useLegacyStorage();
  }

  Vault() {
    this._secureStorage = FlutterSecureStorage();
    this._privateKeyCoder = PrivateKeyCoder();
  }

  // Generic write/read
  Future<String> _write(String key, String value) async {
    if (await legacy()) {
      await setEncrypted(key, value);
    } else {
      await _secureStorage.write(key:key, value:value);
    }
    return value;
  }

  Future<String> _read(String key, {String defaultValue}) async {
    if (await legacy()) {
      return await getEncrypted(key);
    }
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
    if (await legacy()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(PIN_KEY);
      await prefs.remove(PRIVATEKEY_KEY);
      return;
    }
    await _secureStorage.deleteAll();
  }

  // For encrypted data
  Future<void> setEncrypted(String key, String value) async {
    String secret = await getSecret();
    if (secret == null) return null;
    // Decrypt and return
    Salsa20Crypt encrypter = Salsa20Crypt(secret.substring(0, secret.length - 8), secret.substring(secret.length - 8));
    // Encrypt and save
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, encrypter.encrypt(value));
  }

  Future<String> getEncrypted(String key) async {
    String secret = await getSecret();
    if (secret == null) return null;
    // Decrypt and return
    Salsa20Crypt encrypter = Salsa20Crypt(secret.substring(0, secret.length - 8), secret.substring(secret.length - 8));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encrypted = prefs.get(key);
    if (encrypted == null) return null;
    return encrypter.decrypt(encrypted);
  }

  static const _channel = const MethodChannel('fappchannel');

  static Future<String> getSecret() async {
    return await _channel.invokeMethod('getSecret');
  }
}