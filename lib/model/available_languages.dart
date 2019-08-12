import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AvailableLanguage {
  DEFAULT,
  ENGLISH
}

/// Represent the available languages our app supports
class LanguageSetting extends SettingSelectionItem {
  AvailableLanguage language;

  LanguageSetting(this.language);

  String getDisplayName(BuildContext context) {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return "English (en)";
      default:
        return AppLocalization.of(context).systemDefaultHeader;
    }
  }

  String getLocaleString() {
    switch (language) {
      case AvailableLanguage.ENGLISH:
        return "en";
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