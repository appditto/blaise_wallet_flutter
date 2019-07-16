import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum LockTimeoutOption { ZERO, ONE, FIVE, FIFTEEN, THIRTY, SIXTY }

/// Represent auto-lock delay when requiring auth to open
class LockTimeoutSetting extends SettingSelectionItem {
  LockTimeoutOption setting;

  LockTimeoutSetting(this.setting);

  String getDisplayName(BuildContext context) {
    switch (setting) {
      case LockTimeoutOption.ZERO:
        return "Instantly";
      case LockTimeoutOption.ONE:
        return "After 1 minute";
      case LockTimeoutOption.FIVE:
        return "After 5 minutes";
      case LockTimeoutOption.FIFTEEN:
        return "After 15 minutes";
      case LockTimeoutOption.THIRTY:
        return "After 30 minutes";
      case LockTimeoutOption.SIXTY:
        return "After 60 minutes";
      default:
        return "After 1 minute";
    }
  }

  Duration getDuration() {
    switch (setting) {
      case LockTimeoutOption.ZERO:
        return Duration(seconds:3);
      case LockTimeoutOption.ONE:
        return Duration(minutes:1);
      case LockTimeoutOption.FIVE:
        return Duration(minutes: 5);
      case LockTimeoutOption.FIFTEEN:
        return Duration(minutes: 15);
      case LockTimeoutOption.THIRTY:
        return Duration(minutes: 30);
      case LockTimeoutOption.SIXTY:
        return Duration(minutes:1);
      default:
        return Duration(minutes:1);
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}