import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:blaise_wallet_flutter/constants.dart';
import 'package:blaise_wallet_flutter/model/authentication_method.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/model/available_languages.dart';
import 'package:blaise_wallet_flutter/model/available_themes.dart';
import 'package:blaise_wallet_flutter/model/lock_timeout.dart';
import 'package:intl/intl.dart';
import 'package:pascaldart/pascaldart.dart';
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
  // Lock screen
  static const String lock_app = 'app_lock_screen';
  static const String app_lock_timeout = 'app_lock_timeout';
  // Using biometrics
  static const String auth_method = 'blaise_auth_method';
  // Donation contact has been added
  static const String firstcontact_added = 'blaise_first_c_added';
  // Caching price API response
  static const String price_api_cache = 'price_api_cache_v1';
  // Local currency
  static const String cur_currency = 'blaise_currency_pref';
  // Language setting
  static const String cur_language = 'blaise_lang_pref';
  // UUID for our WS subscription
  static const String app_uuid_key = 'blaise_app_uuid';
  // Push notifications
  static const String notification_enabled = 'blaise_notification_on';
  // Freepasa account before confirmation
  static const String freepasa_account_pending = 'blaise_fpasa_pending_acct';
  // For certain keystore incompatible androids
  static const String use_legacy_storage = 'blaise_legacy_storage';

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

  Future<void> setLock(bool value) async {
    return await set(lock_app, value);
  }

  Future<bool> getLock() async {
    return await get(lock_app, defaultValue: false);
  }

  Future<void> setLockTimeout(LockTimeoutSetting setting) async {
   return await set(app_lock_timeout, setting.getIndex());
  }

  Future<LockTimeoutSetting> getLockTimeout() async {
    return LockTimeoutSetting(LockTimeoutOption.values[await get(app_lock_timeout, defaultValue: LockTimeoutOption.ONE.index)]);
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

  Future<void> setFirstContactAdded(bool value) async {
    return await set(firstcontact_added, value);
  }

  Future<bool> getFirstContactAdded() async {
    return await get(firstcontact_added, defaultValue: false);
  }

  Future<String> getPriceAPICache() async {
    return await get(price_api_cache, defaultValue: null);
  }

  Future<void> setPriceAPICache(String data) async {
    await set(price_api_cache, data);
  }

  Future<void> setCurrency(AvailableCurrency currency) async {
   return await set(cur_currency, currency.getIndex());
  }

  Future<AvailableCurrency> getCurrency(Locale deviceLocale) async {
    return AvailableCurrency(AvailableCurrencyEnum.values[await get(cur_currency, defaultValue: AvailableCurrency.getBestForLocale(deviceLocale).currency.index)]);
  }

  Future<void> setLanguage(LanguageSetting language) async {
   return await set(cur_language, language.getId());
  }

  Future<LanguageSetting> getLanguage() async {
    String langEnumStr = await get(cur_language, defaultValue: AvailableLanguage.DEFAULT.toString());
    AvailableLanguage lang;
    for (AvailableLanguage aLang in AvailableLanguage.values) {
      if (aLang.toString() == langEnumStr) {
        lang = aLang;
        break;
      }
    }
    return LanguageSetting(lang);
  }


  Future<void> setUuid(String uuid) async {
    return await set(app_uuid_key, uuid);
  }

  Future<String> getUuid() async {
    return await get(app_uuid_key);
  }

  Future<void> setNotificationsOn(bool value) async {
    return await set(notification_enabled, value);
  }

  Future<bool> getNotificationsOn() async {
    // Notifications off by default on iOS, 
    bool defaultValue = Platform.isIOS ? false : true;
    return await get(notification_enabled, defaultValue: defaultValue);
  }

  /// If notifications have been set by user/app
  Future<bool> getNotificationsSet() async {
    return await get(notification_enabled, defaultValue: null) == null ? false : true;
  }

  Future<AccountNumber> getFreepasaAccount() async {
    int acct = await getWithExpiry(freepasa_account_pending);
    return acct == null ? null : AccountNumber.fromInt(acct);
  }

  Future<void> setFreepasaAccount(AccountNumber account) async {
    await setWithExpiry(freepasa_account_pending, account.account, 2000);
  }

  Future<bool> useLegacyStorage() async {
    return await get(use_legacy_storage, defaultValue: false);
  }

  Future<void> setUseLegacyStorage() async {
    await set(use_legacy_storage, true);
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
      await prefs.remove(app_lock_timeout);
      await prefs.remove(lock_app);
      await prefs.remove(cur_currency);
      await prefs.remove(app_uuid_key);
      await prefs.remove(use_legacy_storage);
    }
  }
}
