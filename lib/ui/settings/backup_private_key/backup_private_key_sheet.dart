import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/settings/backup_private_key/encrypt_private_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/backup_private_key/unencrypted_private_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/pin_screen.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/util/authentication.dart';
import 'package:blaise_wallet_flutter/util/haptic_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';

class BackupPrivateKeySheet extends StatefulWidget {
  _BackupPrivateKeySheetState createState() => _BackupPrivateKeySheetState();
}

class _BackupPrivateKeySheetState extends State<BackupPrivateKeySheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: StateContainer.of(context).curTheme.backgroundPrimary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: <Widget>[
                // Sheet header
                Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    gradient:
                        StateContainer.of(context).curTheme.gradientPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Close Button
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 5, end: 10),
                        height: 50,
                        width: 50,
                        child: FlatButton(
                            highlightColor:
                                StateContainer.of(context).curTheme.textLight15,
                            splashColor:
                                StateContainer.of(context).curTheme.textLight30,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Icon(AppIcons.close,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .textLight,
                                size: 20)),
                      ),
                      // Header
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          toUppercase(AppLocalization.of(context)
                              .privateKeySheetHeader
                              ,context),
                          style: AppStyles.header(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // Sized Box
                      SizedBox(
                        height: 50,
                        width: 65,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Paragraph
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 0),
                        child: AutoSizeText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppLocalization.of(context)
                                        .backupKeyFirstParagraph +
                                    "\n\n",
                                style: AppStyles.paragraph(context),
                              ),
                              TextSpan(
                                text: AppLocalization.of(context)
                                        .backupKeySecondParagraph +
                                    "\n\n",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text: AppLocalization.of(context)
                                        .backupKeyThirdParagraph +
                                    "\n\n",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                              TextSpan(
                                text: AppLocalization.of(context)
                                    .backupKeyFourthParagraph,
                                style: AppStyles.paragraph(context),
                              ),
                            ],
                          ),
                          stepGranularity: 0.5,
                          maxLines: 14,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                //"Encrypted Key" and "Unencrypted Key" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: AppLocalization.of(context).encryptedKeyButton,
                      buttonTop: true,
                      onPressed: () async {
                        await authenticate(true);
                      },
                    ),
                  ],
                ),
                // "Close" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: AppLocalization.of(context).unencryptedKeyButton,
                      onPressed: () async {
                        await authenticate(false);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _authenticateBiometrics(AuthUtil authUtil, String message, bool encrypted) async {
    bool authenticated = await authUtil.authenticateWithBiometrics(message);
    if (authenticated) {
      HapticUtil.fingerprintSucess();
      Navigator.of(context).pop();
      if (encrypted) {
        AppSheets.showBottomSheet(
            context: context, widget: EncryptPrivateKeySheet());
      } else {
        AppSheets.showBottomSheet(
            context: context, widget: UnencryptedPrivateKeySheet());
      }
    }    
  }

  Future<void> _authenticatePin(bool encrypted, String message) async {
    String expectedPin = await sl.get<Vault>().getPin();
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return PinScreen(
          type: PinOverlayType.ENTER_PIN,
          onSuccess: (pin) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            if (encrypted) {
              AppSheets.showBottomSheet(
                  context: context, widget: EncryptPrivateKeySheet());
            } else {
              AppSheets.showBottomSheet(
                  context: context, widget: UnencryptedPrivateKeySheet());
            }
          },
          expectedPin: expectedPin,
          description: message,
        );
      },
    ));    
  }

  Future<void> authenticate(bool encrypted) async {
    String message = AppLocalization.of(context).authenticateToBackUpParagraph;
    // Authenticate
    AuthUtil authUtil = AuthUtil();
    if (await authUtil.useBiometrics()) {
      // Biometric auth
      try {
        await _authenticateBiometrics(authUtil, message, encrypted);
      } catch (e) {
        await _authenticatePin(encrypted, message);
      }
    } else {
      await _authenticatePin(encrypted, message);
    }
  }
}
