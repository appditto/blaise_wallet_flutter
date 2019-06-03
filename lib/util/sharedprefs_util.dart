import 'package:shared_preferences/shared_preferences.dart';

/// Singleton wrapper for shared preferences
class SharedPrefsUtil {
  // Keys
  static const String first_launch_key = 'pasc_first_launch';
  static const String privkey_backed_up_key = 'pasc_privkey_backedup';

  // For plain-text data
  Future<void> set(String key, value) async {
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

  // For logging out
  Future<void> deleteAll({bool firstLaunch = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (firstLaunch) {
      await prefs.clear();
    } else {
      await prefs.remove(privkey_backed_up_key);
    }
  }
}