import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:blaise_wallet_flutter/themes.dart';
import 'package:flutter/material.dart';

enum ThemeOptions { LIGHT, COPPER }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeOptions theme;

  ThemeSetting(this.theme);

  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.COPPER:
        return "Copper";
      case ThemeOptions.LIGHT:
      default:
        return "Light";
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.COPPER:
        return BlaiseCopperTheme();
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