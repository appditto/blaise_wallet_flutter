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
        fontSize: AppFontSizes.largest,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.textLight);
  }

  // For paragraphs
  static TextStyle paragraph(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w400);
  }
  static TextStyle paragraphBig(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 16.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }
  static TextStyle paragraphTextLightSmall(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w300);
  }
  static TextStyle paragraphTextLightSmallSemiBold(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  // For text field labels
  static TextStyle textFieldLabel(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Metropolis',
        fontSize: 16.0,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  // For primary Private Key
  static TextStyle privateKeyPrimary(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0,
        height: 1,
        fontWeight: FontWeight.w500,
        fontFamily: 'SourceCodePro');
  }

  // For success Private Key
  static TextStyle privateKeySuccess(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.success,
        fontSize: 14.0,
        height: 1,
        fontWeight: FontWeight.w500,
        fontFamily: 'SourceCodePro');
  }

  // Primary Button Text
  static TextStyle buttonPrimary(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  // Outline Button Text
  static TextStyle buttonPrimaryOutline(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  // Bg Colored Mini Button Text
  static TextStyle buttonMiniBg(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  // Success Colored Mini Button Text
  static TextStyle buttonMiniSuccess(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.backgroundPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }
  // For header pascal icon
  static TextStyle iconFontTextLightPascal(BuildContext context) {
    return TextStyle(
        fontSize: 20,
        color: StateContainer.of(context).curTheme.textLight,
        fontFamily: 'AppIcons',
    );
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
