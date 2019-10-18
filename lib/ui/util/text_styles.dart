import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:flutter/material.dart';

class AppStyles {
  // For snackbar/Toast text
  static TextStyle snackbar(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.backgroundPrimary);
  }

  // For headers
  static TextStyle header(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.largest,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.textLight);
  }

  // For small headers
  static TextStyle headerSmall(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w500,
        color: StateContainer.of(context).curTheme.primary);
  }

  static TextStyle headerSmallBold(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.primary);
  }
  static TextStyle headerSmallBoldSuccess(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.medium,
        fontWeight: FontWeight.w700,
        color: StateContainer.of(context).curTheme.success);
  }

  // For paragraphs
  static TextStyle paragraph(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w400);
  }

  // For paragraphs
  static TextStyle paragraphSuccess(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.success,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w400);
  }

  static TextStyle paragraphMedium(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  static TextStyle paragraphMediumPrimary(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  static TextStyle paragraphMediumSuccess(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.success,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  // For paragraphs
  static TextStyle paragraphPrimary(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  // For paragraphs
  static TextStyle primarySmall600(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: AppFontSizes.small,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  static TextStyle primarySmallest400(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w400);
  }

  static TextStyle primarySmallest500(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  static TextStyle primarySmallest600(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  static TextStyle dangerSmallest600(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.danger,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  static TextStyle paragraphDanger(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.danger,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  static TextStyle balanceMedium(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 18.0,
        fontWeight: FontWeight.w700);
  }

  static TextStyle balanceSmall(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
  }

  static TextStyle balanceSmallSuccess(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.success,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
  }

  static TextStyle balanceSmallTextDark(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
  }

  static TextStyle balanceSmallSecondary(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.secondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
  }

  static TextStyle paragraphBig(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 16.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  static TextStyle paragraphBigDisabled(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark30,
        fontSize: 16.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  static TextStyle paragraphTextLightSmall(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w300);
  }

  static TextStyle textLightSmall600(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 14.0,
        fontWeight: FontWeight.w600);
  }

  static TextStyle paragraphTextLightSmallSemiBold(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  // Modal header
  static TextStyle snackBar(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0,
        fontWeight: FontWeight.w700);
  }

  // Modal header
  static TextStyle modalHeader(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 18.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  // Settings item header
  static TextStyle settingsItemHeader(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  static TextStyle settingsItemHeaderDisabled(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark60,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  // Settings item subheader
  static TextStyle settingsItemSubHeader(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w400);
  }

  static TextStyle settingsItemSubHeaderDisabled(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark60,
        fontSize: 12.0,
        height: 1.3,
        fontWeight: FontWeight.w400);
  }

  // Date on operations list items
  static TextStyle operationDate(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark50,
        fontSize: 12.0,
        fontWeight: FontWeight.w400);
  }

  // Operation type
  static TextStyle operationType(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 13.0,
        fontWeight: FontWeight.w600);
  }

  // Settings header
  static TextStyle settingsHeader(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 16.0,
        fontWeight: FontWeight.w700);
  }

  static TextStyle iconFontPrimaryMedium(BuildContext context) {
    return TextStyle(
        fontFamily: 'AppIcons',
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 16.0);
  }

  static TextStyle iconFontSuccessMedium(BuildContext context) {
    return TextStyle(
        fontFamily: 'AppIcons',
        color: StateContainer.of(context).curTheme.success,
        fontSize: 16.0);
  }

  static TextStyle iconFontPrimarySmall(BuildContext context) {
    return TextStyle(
        fontFamily: 'AppIcons',
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0);
  }

  static TextStyle iconFontSuccessSmall(BuildContext context) {
    return TextStyle(
        fontFamily: 'AppIcons',
        color: StateContainer.of(context).curTheme.success,
        fontSize: 14.0);
  }

  static TextStyle emptySpaceSmallest(BuildContext context) {
    return TextStyle(fontSize: 12);
  }

  static TextStyle emptySpaceTiny(BuildContext context) {
    return TextStyle(fontSize: 10);
  }

  static TextStyle accountsItemName(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  static TextStyle accountsItemNumber(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark60,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w500);
  }

  // Contacts item name
  static TextStyle contactsItemName(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  // Contacts item name primary
  static TextStyle contactsItemNamePrimary(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  // Contacts item name primary
  static TextStyle contactsItemNameSuccess(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.success,
        fontSize: 14.0,
        height: 1.3,
        fontWeight: FontWeight.w700);
  }

  // Contacts item address
  static TextStyle contactsItemAddress(BuildContext context) {
    return TextStyle(
        fontFamily: 'SourceCodePro',
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);
  }

  // Contacts item address
  static TextStyle monoTextDarkSmall400(BuildContext context) {
    return TextStyle(
        fontFamily: 'SourceCodePro',
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        fontWeight: FontWeight.w400);
  }

  static TextStyle contactsItemAddressPrimary(BuildContext context) {
    return TextStyle(
        fontFamily: 'Metropolis',
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 16.0,
        fontWeight: FontWeight.w400);
  }

  // For text field labels
  static TextStyle textFieldLabel(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.primary,
        fontFamily: 'Metropolis',
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: 16.0,
        height: 1.3,
        fontWeight: FontWeight.w600);
  }

  static TextStyle textFieldLabelSuccess(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.success,
        fontFamily: 'Metropolis',
        fontFamilyFallback: ["RobotoRegular"],
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

  // For neutral Private Key
  static TextStyle privateKeyTextDark(BuildContext context) {
    return TextStyle(
        color: StateContainer.of(context).curTheme.textDark,
        fontSize: 14.0,
        height: 1,
        fontWeight: FontWeight.w500,
        fontFamily: 'SourceCodePro');
  }

  // For neutral Private Key
  static TextStyle privateKeyTextDarkFaded(BuildContext context) {
    return TextStyle(
      fontFamily: 'SourceCodePro',
      color: StateContainer.of(context).curTheme.textDark.withOpacity(0.5),
      fontSize: 14.0,
      height: 1,
      fontWeight: FontWeight.w500,
    );
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
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.textLight,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  // Outline Button Text
  static TextStyle buttonPrimaryOutline(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  static TextStyle buttonSuccessOutline(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.success,
        fontSize: 18,
        fontWeight: FontWeight.w700);
  }

  // Danger Button Text
  static TextStyle buttonDanger(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      color: StateContainer.of(context).curTheme.textLight,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );
  }

  // Danger Outline Button Text
  static TextStyle buttonDangerOutline(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      color: StateContainer.of(context).curTheme.danger,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      height: 1.3,
    );
  }

  // Bg Colored Mini Button Text
  static TextStyle buttonMiniBg(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.primary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  // Success Colored Mini Button Text
  static TextStyle buttonMiniSuccess(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        color: StateContainer.of(context).curTheme.backgroundPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w600);
  }

  // For header pascal icon
  static TextStyle iconFontTextLightPascal(BuildContext context) {
    return TextStyle(
      fontSize: 28,
      color: StateContainer.of(context).curTheme.textLight,
      fontFamily: 'AppIcons',
    );
  }

  // For pascal icon on the account card balance
  static TextStyle iconFontPrimaryBalanceMediumPascal(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      color: StateContainer.of(context).curTheme.primary,
      fontFamily: 'AppIcons',
    );
  }

  // For pascal icon on the operation items
  static TextStyle iconFontPrimaryBalanceSmallPascal(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: StateContainer.of(context).curTheme.primary,
      fontFamily: 'AppIcons',
    );
  }

  static TextStyle iconFontSuccessBalanceSmallPascal(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: StateContainer.of(context).curTheme.success,
      fontFamily: 'AppIcons',
    );
  }

  static TextStyle iconFontTextDarkBalanceSmallPascal(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: StateContainer.of(context).curTheme.textDark,
      fontFamily: 'AppIcons',
    );
  }

  static TextStyle iconFontSecondarySmallPascal(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: StateContainer.of(context).curTheme.secondary,
      fontFamily: 'AppIcons',
    );
  }

  // For chat bubble icon
  static TextStyle iconFontPrimaryBalanceSmallest(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      color: StateContainer.of(context).curTheme.primary50,
      fontFamily: 'AppIcons',
    );
  }

  static TextStyle iconFontTextDarkBalanceSmallest(BuildContext context) {
    return TextStyle(
      fontSize: 12,
      color: StateContainer.of(context).curTheme.textDark50,
      fontFamily: 'AppIcons',
    );
  }

  // Account Card Name
  static TextStyle accountCardName(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: 14,
      color: StateContainer.of(context).curTheme.textLight,
      fontWeight: FontWeight.w700,
    );
  }

  // Account Card Address
  static TextStyle accountCardAddress(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      color: StateContainer.of(context).curTheme.textLight,
      fontFamily: 'SourceCodePro',
    );
  }

  // PIN Description
  static TextStyle pinDescription(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.small,
      color: StateContainer.of(context).curTheme.textLight,
    );
  }

  // PIN Description
  static TextStyle pinNumberPad(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.larger,
      color: StateContainer.of(context).curTheme.primary,
      fontWeight: FontWeight.w700,
    );
  }

  // Text Dark Small 400
  static TextStyle textDarkSmall400(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.small,
      color: StateContainer.of(context).curTheme.textDark,
      fontWeight: FontWeight.w400,
    );
  }

  // Text Dark Large 400
  static TextStyle textDarkLarge700(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.large,
      color: StateContainer.of(context).curTheme.textDark,
      fontWeight: FontWeight.w700,
    );
  }

  // Text Light Small 400
  static TextStyle textLightSmall400(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.small,
      color: StateContainer.of(context).curTheme.textLight,
      fontWeight: FontWeight.w400,
    );
  }

  // Text Light Large 400
  static TextStyle textLightLarge700(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.large,
      color: StateContainer.of(context).curTheme.textLight,
      fontWeight: FontWeight.w700,
    );
  }

  // Text Light Small 700
  static TextStyle textLightSmall700(BuildContext context) {
    return TextStyle(
      fontFamily: "Metropolis",
      fontFamilyFallback: ["RobotoRegular"],
      fontSize: AppFontSizes.small,
      color: StateContainer.of(context).curTheme.textLight,
      fontWeight: FontWeight.w700,
    );
  }

  // Version info in settings
  static TextStyle textStyleVersion(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w100,
        color: StateContainer.of(context).curTheme.textDark60);
  }

  static TextStyle textStyleVersionUnderline(BuildContext context) {
    return TextStyle(
        fontFamily: "Metropolis",
        fontFamilyFallback: ["RobotoRegular"],
        fontSize: AppFontSizes.small,
        fontWeight: FontWeight.w100,
        color: StateContainer.of(context).curTheme.textDark60,
        decoration: TextDecoration.underline);
  }
}

class AppFontSizes {
  static const smallest = 12.0;
  static const small = 14.0;
  static const medium = 16.0;
  static const large = 18.0;
  static const larger = 24.0;
  static const largest = 28.0;
}
