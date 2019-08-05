import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum UnlockOption { YES, NO }

/// Represent authenticate to open setting
class UnlockSetting extends SettingSelectionItem {
  UnlockOption setting;

  UnlockSetting(this.setting);

  String getDisplayName(BuildContext context) {
    switch (setting) {
      case UnlockOption.YES:
        return AppLocalization.of(context).yesHeader;
      case UnlockOption.NO:
      default:
        return AppLocalization.of(context).noHeader;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}