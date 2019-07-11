import 'dart:convert';

import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/model/authentication_method.dart';
import 'package:blaise_wallet_flutter/model/available_themes.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Singleton wrapper for shared preferences
class SharedPrefsUtil {
  // Keys
  static const String first_launch_key = 'pasc_first_launch';
  static const String privkey_backed_up_key = 'pasc_privkey_backedup';
  static const String rpc_url_key = 'pasc_rpc_url';
  static const String cur_theme = 'blaise_cur_theme_key';
  // For maximum pin attempts
  static const String pin_attempts = 'blaise_pin_attempts';
  static const String pin_lock_until = 'blaise_lock_duraton';
  // Using biometrics
  static const String auth_method = 'blaise_auth_method';

  // For plain-text data
  Future<void> set(String key, dynamic value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (value is bool) {
      sharedPreferences.setBool(key, value);
    } else if (value is String) {
      sharedPreferences.setString(key, value);
    } else if (value is double) {
      sharedPreferences.setDouble(key, value);
    } else if (value is int) {
      sharedPreferences.setInt(key, value);
    }
  }

  Future<dynamic> get(String key, {dynamic defaultValue}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.get(key) ?? defaultValue;
  }

  /// Set a key with an expiry, expiry is in seconds
  Future<void> setWithExpiry(String key, dynamic value, int expiry) async {
    DateTime now = DateTime.now().toUtc();
    DateTime expired = now.add(Duration(seconds: expiry));
    Map<String, dynamic> msg = {
      'data':value,
      'expiry':expired.millisecondsSinceEpoch
    };
    String serialized = json.encode(msg);
    await set(key, serialized);
  }

  /// Get a key that has an expiry
  Future<dynamic> getWithExpiry(String key) async {
    String val = await get(key, defaultValue: null);
    if (val == null) {
      return null;
    }
    Map<String, dynamic> msg = json.decode(val);
    DateTime expired = DateTime.fromMillisecondsSinceEpoch(msg['expiry']);
    if (DateTime.now().toUtc().difference(expired).inMinutes > 0) {
      await remove(key);
      return null;
    }
    return msg['data'];
  }

  Future<void> remove(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(key);
  }

  // Key-specific helpers
  Future<void> setPrivateKeyBackedUp(bool value) async {
    return await set(privkey_backed_up_key, value);
  }

  Future<bool> getPrivateKeyBackedUp() async {
    return await get(privkey_backed_up_key, defaultValue: false);
  }

  Future<void> setFirstLaunch() async {
    return await set(first_launch_key, false);
  }

  Future<bool> getFirstLaunch() async {
    return await get(first_launch_key, defaultValue: true);
  }

  Future<void> setRpcUrl(String rpcUrl) async {
    return await set(rpc_url_key, rpcUrl);
  }

  Future<void> resetRpcUrl() async {
    return await remove(rpc_url_key);
  }

  Future<String> getRpcUrl() async {
    return await get(rpc_url_key,
        defaultValue: AppConstants.DEFAULT_RPC_HTTP_URL);
  }

  Future<void> setTheme(ThemeSetting theme) async {
   return await set(cur_theme, theme.getIndex());
  }

  Future<ThemeSetting> getTheme() async {
    return ThemeSetting(ThemeOptions.values[await get(cur_theme, defaultValue: ThemeOptions.LIGHT.index)]);
  }

// Locking out when max pin attempts exceeded
  Future<int> getLockAttempts() async {
    return await get(pin_attempts, defaultValue: 0);
  }

  Future<void> incrementLockAttempts() async {
    await set(pin_attempts, await getLockAttempts() + 1);
  }

  Future<void> resetLockAttempts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(pin_attempts);
    await prefs.remove(pin_lock_until);
  }

  Future<bool> shouldLock() async {
    if (await get(pin_lock_until) != null || await getLockAttempts() >= 5) {
      return true;
    }
    return false;
  }

  Future<void> updateLockDate() async {
    int attempts = await getLockAttempts();
    if (attempts >= 20) {
      // 4+ failed attempts
      await set(pin_lock_until, DateFormat.yMd().add_jms().format(DateTime.now().toUtc().add(Duration(hours: 24))));
    } else if (attempts >= 15) {
      // 3 failed attempts
      await set(pin_lock_until, DateFormat.yMd().add_jms().format(DateTime.now().toUtc().add(Duration(minutes: 15))));
    } else if (attempts >= 10) {
      // 2 failed attempts
      await set(pin_lock_until, DateFormat.yMd().add_jms().format(DateTime.now().toUtc().add(Duration(minutes: 5))));
    } else if (attempts >= 5) {
      await set(pin_lock_until, DateFormat.yMd().add_jms().format(DateTime.now().toUtc().add(Duration(minutes: 1))));
    }
  }

  Future<DateTime> getLockDate() async {
    String lockDateStr = await get(pin_lock_until);
    if (lockDateStr == null) {
      return null;
    }
    return DateFormat.yMd().add_jms().parseUtc(lockDateStr);
  }

  Future<void> setAuthMethod(AuthenticationMethod method) async {
   return await set(auth_method, method.getIndex());
  }

  Future<AuthenticationMethod> getAuthMethod() async {
    return AuthenticationMethod(AuthMethod.values[await get(auth_method, defaultValue: AuthMethod.BIOMETRICS.index)]);
  }

  // For logging out
  Future<void> deleteAll({bool firstLaunch = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (firstLaunch) {
      await prefs.clear();
    } else {
      await prefs.remove(privkey_backed_up_key);
      await prefs.remove(rpc_url_key);
      await prefs.remove(pin_attempts);
      await prefs.remove(pin_lock_until);
      await prefs.remove(auth_method);
    }
  }
}
