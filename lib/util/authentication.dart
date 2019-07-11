import 'dart:io';
import 'package:blaise_wallet_flutter/model/authentication_method.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/widgets/pin_screen.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthUtil {
  ///
  /// hasBiometrics()
  /// 
  /// @returns [true] if device has fingerprint/faceID available and registered, [false] otherwise
  Future<bool> hasBiometrics() async {
    LocalAuthentication localAuth = new LocalAuthentication();
    bool canCheck = await localAuth.canCheckBiometrics;
    if (canCheck) {
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
      if (Platform.isIOS && availableBiometrics.contains(BiometricType.face)) {
        return true;
      } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
        return true;
      }
    }
    return false;
  }

  ///
  /// authenticateWithBiometrics()
  /// 
  /// @param [message] Message shown to user in FaceID/TouchID popup
  /// @returns [true] if successfully authenticated, [false] otherwise
  Future<bool> authenticateWithBiometrics(String message) async {
    bool hasBiometricsEnrolled = await hasBiometrics();
    if (hasBiometricsEnrolled) {
      LocalAuthentication localAuth = new LocalAuthentication();
      return await localAuth.authenticateWithBiometrics(
        localizedReason: message,
        useErrorDialogs: false
      );
    }
    return false;
  }

  ///
  /// authenticate() - Authenticate with either PIN or Biometrics depending on nwhat's available
  /// 
  /// @param [message] Message shown to user in FaceID/TouchID popup
  /// @param [onSuccess] Callback for when authentication is success
  Future<void> authenticate(BuildContext context, {@required String message, @required Function onSuccess}) async {
    if (await hasBiometrics() && (await sl.get<SharedPrefsUtil>().getAuthMethod()).method == AuthMethod.BIOMETRICS) {
      if (await authenticateWithBiometrics(message)) {
        onSuccess();
      }
    } else {
      String expectedPin = await sl.get<Vault>().getPin();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return PinScreen(
              type: PinOverlayType.ENTER_PIN,
              expectedPin: expectedPin,
              description: message,
              onSuccess: (pin) {
                Navigator.of(context).pop();
                onSuccess();
              }
            );
          }
        )
      );
    }
  }
}