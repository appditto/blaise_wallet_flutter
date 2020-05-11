import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableLanguage {
  DEFAULT,
  ENGLISH,
  ARABIC,
  CATALAN,
  CHINESE_SIMPLIFIED,
  GERMAN,
  SPANISH,
  TURKISH
}

/// Represent the available languages our app supports
class LanguageSetting extends SettingSelectionItem {
  AvailableLanguage language;

  LanguageSetting(this.language);

  String getDisplayName(BuildContext context) {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return "English (en)";
      case AvailableLanguage.CATALAN:
        return "Català (ca)";        
      case AvailableLanguage.ARABIC:
        return "العَرَبِيَّة‎ (ar)";
      case AvailableLanguage.CHINESE_SIMPLIFIED:
        return "简体字 (zh-Hans)";
      case AvailableLanguage.GERMAN:
        return "Deutsch (de)";
      case AvailableLanguage.SPANISH:
        return "Español (es)";
      case AvailableLanguage.TURKISH:
        return "Türkçe (tr)";
      default:
        return AppLocalization.of(context).systemDefaultHeader;
    }
  }

  String getLocaleString() {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return "en";
      case AvailableLanguage.ARABIC:
        return "ar";
      case AvailableLanguage.CATALAN:
        return "ca";        
      case AvailableLanguage.CHINESE_SIMPLIFIED:
        return "zh-Hans";
      case AvailableLanguage.GERMAN:
        return "de";
      case AvailableLanguage.SPANISH:
        return "es";
      case AvailableLanguage.TURKISH:
        return "tr";
      default:
        return "DEFAULT";
    }
  }

  Locale getLocale() {
    String localeStr = getLocaleString();
    if (localeStr == 'DEFAULT') {
      return Locale('en');
    } else if (localeStr == 'zh-Hans' || localeStr == 'zh-Hant') {
      return Locale.fromSubtags(languageCode: 'zh', scriptCode: localeStr.split('-')[1]);
    }
    return Locale(localeStr);
  }

  // For saving to shared prefs
  String getId() {
    return language.toString();
  }
}