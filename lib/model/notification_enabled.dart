import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum NotificationOptions { ON, OFF }

/// Represent notification on/off setting
class NotificationSetting extends SettingSelectionItem {
  NotificationOptions setting;

  NotificationSetting(this.setting);

  String getDisplayName(BuildContext context) {
    switch (setting) {
      case NotificationOptions.ON:
        return AppLocalization.of(context).onHeader;
      case NotificationOptions.OFF:
      default:
        return AppLocalization.of(context).offHeader;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
