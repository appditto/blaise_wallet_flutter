import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableLanguage {
  DEFAULT,
  ENGLISH,
  CHINESE_SIMPLIFIED,
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
      case AvailableLanguage.CHINESE_SIMPLIFIED:
        return "简体字 (zh-Hans)";
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
      case AvailableLanguage.CHINESE_SIMPLIFIED:
        return "zh-Hans";
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