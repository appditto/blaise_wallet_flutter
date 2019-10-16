import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/settings/backup_private_key/encrypted_private_key_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';

class EncryptPrivateKeySheet extends StatefulWidget {
  _EncryptPrivateKeySheetState createState() => _EncryptPrivateKeySheetState();
}

class _EncryptPrivateKeySheetState extends State<EncryptPrivateKeySheet> {
  FocusNode passwordFocusNode;
  TextEditingController passwordController;
  FocusNode confirmPasswordFocusNode;
  TextEditingController confirmPasswordController;

  String passwordError;

  bool passwordsMatch;

  @override
  void initState() {
    super.initState();
    this.passwordsMatch = false;
    this.passwordFocusNode = FocusNode();
    this.confirmPasswordFocusNode = FocusNode();
    this.passwordController = TextEditingController();
    this.confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TapOutsideUnfocus(
        child: Column(
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
                              .encryptSheetHeader
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
                        width: double.maxFinite,
                        margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 20),
                        child: AutoSizeText(
                          AppLocalization.of(context).encryptKeyParagraph,
                          style: AppStyles.paragraph(context),
                          stepGranularity: 0.1,
                          maxLines: 3,
                          minFontSize: 8,
                        ),
                      ),
                      Expanded(
                        child: KeyboardAvoider(
                          duration: Duration(milliseconds: 0),
                          autoScroll: true,
                          focusPadding: 40,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Container for new password field
                              Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 0),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .newPasswordTextFieldHeader,
                                  style: this.passwordsMatch ? AppStyles.paragraphMediumPrimary(context) : AppStyles.paragraphMedium(context),
                                  maxLines: 1,
                                  passwordField: true,
                                  focusNode: passwordFocusNode,
                                  controller: passwordController,
                                  onChanged: (String newText) {
                                    if (passwordError != null) {
                                      setState(() {
                                        passwordError = null;
                                      });
                                    }
                                    if (confirmPasswordController.text ==
                                        passwordController.text) {
                                      if (mounted) {
                                        setState(() {
                                          passwordsMatch = true;
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        setState(() {
                                          passwordsMatch = false;
                                        });
                                      }
                                    }
                                  },
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (text) {
                                    confirmPasswordFocusNode.requestFocus();
                                  },
                                ),
                              ),
                              // Container for confirm password field
                              Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 30, 30, 40),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .confirmPasswordTextFieldHeader,
                                  style: this.passwordsMatch ? AppStyles.paragraphMediumPrimary(context) : AppStyles.paragraphMedium(context),
                                  maxLines: 1,
                                  passwordField: true,
                                  focusNode: confirmPasswordFocusNode,
                                  controller: confirmPasswordController,
                                  onChanged: (String newText) {
                                    if (passwordError != null) {
                                      setState(() {
                                        passwordError = null;
                                      });
                                    }
                                    if (confirmPasswordController.text ==
                                        passwordController.text) {
                                      if (mounted) {
                                        setState(() {
                                          passwordsMatch = true;
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        setState(() {
                                          passwordsMatch = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                              // Error text
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 30, end: 30, top: 4, bottom: 40),
                                child: AutoSizeText(
                                  passwordError == null ? "" : passwordError,
                                  style: AppStyles.paragraphPrimary(context),
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // "Encrypt" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.Primary,
                      text: AppLocalization.of(context).encryptButton,
                      buttonTop: true,
                      onPressed: () {
                        validatePasswordMatchAndEncrypt();
                      },
                    ),
                  ],
                ),
                // "Close" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: AppLocalization.of(context).closeButton,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  void validatePasswordMatchAndEncrypt() {
    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        passwordError = AppLocalization.of(context).noMatchPasswordError;
      });
    } else if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = AppLocalization.of(context).emptyPasswordError;
      });
    } else {
      sl.get<Vault>().getPrivateKey().then((pkStr) {
        PrivateKey pk =
            PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(pkStr));
        String encrypted = PDUtil.byteToHex(
            PrivateKeyCrypt.encrypt(pk, passwordController.text));
        Navigator.of(context).pop();
        AppSheets.showBottomSheet(
            context: context,
            widget: EncryptedPrivateKeySheet(encryptedKey: encrypted));
      });
    }
  }
}
