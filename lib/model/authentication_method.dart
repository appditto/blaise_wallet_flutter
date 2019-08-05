import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/setting_item.dart';
import 'package:flutter/material.dart';

enum AuthMethod { PIN, BIOMETRICS }

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthMethod method;

  AuthenticationMethod(this.method);

  String getDisplayName(BuildContext context) {
    switch (method) {
      case AuthMethod.BIOMETRICS:
        return AppLocalization.of(context).authenticationBiometricsHeader;
      case AuthMethod.PIN:
        return AppLocalization.of(context).authenticationPINHeader;
      default:
        return AppLocalization.of(context).authenticationPINHeader;
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
