import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:blaise_wallet_flutter/themes.dart';
import 'package:flutter/material.dart';

enum ThemeOptions { LIGHT, DARK, COPPER }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeOptions theme;

  ThemeSetting(this.theme);

  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.DARK:
        return AppLocalization.of(context).themeDarkHeader;
      case ThemeOptions.COPPER:
        return AppLocalization.of(context).themeCopperHeader;
      case ThemeOptions.LIGHT:
      default:
        return AppLocalization.of(context).themeLightHeader;
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.COPPER:
        return BlaiseCopperTheme();
      case ThemeOptions.DARK:
        return BlaiseDarkTheme();
      case ThemeOptions.LIGHT:
      default:
        return BlaiseLightTheme();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return theme.index;
  }
}
