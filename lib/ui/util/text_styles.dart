import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // For snackbar/Toast text
  static TextStyle snackbar(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.backgroundPrimary);
  }

  // For headers
  static TextStyle header(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontSize: AppFontSizes.largest,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.textLight);
  }

  // Primary Button Text
  static TextStyle buttonPrimary(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  // Outline Button Text
  static TextStyle buttonOutline(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  // Background Color Mini Button Text
  static TextStyle buttonMiniBg(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }
}

class AppFontSizes {
  static const smallest = 12.0;
  static const small = 14.0;
  static const medium = 16.0;
  static const large = 20.0;
  static const larger = 24.0;
  static const largest = 28.0;
}
