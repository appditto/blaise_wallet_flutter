import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/formatters.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/util/routes.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/pin_screen.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/user_data_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';

class IntroImportPrivateKeyPage extends StatefulWidget {
  @override
  _IntroImportPrivateKeyPageState createState() =>
      _IntroImportPrivateKeyPageState();
}

class _IntroImportPrivateKeyPageState extends State<IntroImportPrivateKeyPage> {
  FocusNode privateKeyFocusNode;
  TextEditingController privateKeyController;
  bool _showPrivateKeyError;
  bool _privateKeyValid;

  @override
  void initState() {
    super.initState();
    privateKeyFocusNode = FocusNode();
    privateKeyController = TextEditingController();
    _showPrivateKeyError = false;
    _privateKeyValid = false;
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
        body: TapOutsideUnfocus(
            child: LayoutBuilder(
          builder: (context, constraints) => Column(
            children: <Widget>[
              //A widget that holds welcome animation + paragraph
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Container for the header
                    Container(
                      padding: EdgeInsetsDirectional.only(
                        top: (MediaQuery.of(context).padding.top) +
                            (24 - (MediaQuery.of(context).padding.top) / 2),
                      ),
                      decoration: BoxDecoration(
                        gradient:
                            StateContainer.of(context).curTheme.gradientPrimary,
                      ),
                      // Row for back button and the header
                      child: Row(
                        children: <Widget>[
                          // The header
                          Container(
                            width: MediaQuery.of(context).size.width - 60,
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 24, 30, 24),
                            child: AutoSizeText(
                              AppLocalization.of(context)
                                  .importPrivateKeyHeader,
                              style: AppStyles.header(context),
                              maxLines: 1,
                              stepGranularity: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Container for the paragraph
                    Container(
                      margin: EdgeInsetsDirectional.fromSTEB(30, 30, 30, 20),
                      alignment: Alignment(-1, 0),
                      child: AutoSizeText(
                        AppLocalization.of(context).importPrivateKeyParagraph,
                        maxLines: 2,
                        stepGranularity: 0.1,
                        style: AppStyles.paragraph(context),
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
                            // Container for the text field
                            Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 10, 30, 0),
                                child: AppTextField(
                                  label: AppLocalization.of(context)
                                      .privateKeyTextFieldHeader,
                                  style: _privateKeyValid
                                      ? AppStyles.privateKeyPrimary(context)
                                      : AppStyles.privateKeyTextDark(context),
                                  focusNode: privateKeyFocusNode,
                                  controller: privateKeyController,
                                  maxLines: 1,
                                  firstButton: TextFieldButton(
                                    icon: AppIcons.paste,
                                    onPressed: () {
                                      Clipboard.getData("text/plain")
                                          .then((cdata) {
                                        if (privateKeyIsValid(cdata.text) ||
                                            privateKeyIsEncrypted(cdata.text)) {
                                          privateKeyController.text =
                                              cdata.text;
                                          onKeyTextChanged(
                                              privateKeyController.text);
                                        }
                                      });
                                    },
                                  ),
                                  secondButton: TextFieldButton(
                                    icon: AppIcons.scan,
                                    onPressed: () async {
                                      String text =
                                          await UserDataUtil.getQRData(
                                              DataType.RAW,
                                              StateContainer.of(context).curTheme.scannerTheme);
                                      if (text != null) {
                                        if (privateKeyIsValid(text) ||
                                            privateKeyIsEncrypted(text)) {
                                          privateKeyController.text = text;
                                          onKeyTextChanged(
                                              privateKeyController.text);
                                        }
                                      }
                                    },
                                  ),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter(RegExp(
                                        "[a-fA-F0-9]")), // Hex characters
                                    UpperCaseTextFormatter()
                                  ],
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  onChanged: onKeyTextChanged,
                                )),
                            // Error text
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                  start: 30, end: 30, top: 4, bottom: 40),
                              child: AutoSizeText(
                                _showPrivateKeyError
                                    ? AppLocalization.of(context)
                                        .invalidPrivateKeyError
                                    : "",
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

              // "Import" button
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.Primary,
                    text: AppLocalization.of(context).importButton,
                    buttonTop: true,
                    onPressed: () {
                      validateAndSubmit();
                    },
                  ),
                ],
              ),
              // "Go Back" button
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: AppLocalization.of(context).goBackButton,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        )));
  }

  bool privateKeyIsValid(String pkText) {
    try {
      PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(pkText));
      return true;
    } catch (e) {
      return false;
    }
  }

  bool privateKeyIsEncrypted(String pkText, {bool lengthCheck = true}) {
    int minLength = lengthCheck ? 100 : 8;
    if (pkText == null || pkText.length < minLength) {
      return false;
    }
    try {
      String salted =
          PDUtil.bytesToUtf8String(PDUtil.hexToBytes(pkText.substring(0, 16)));
      if (salted == "Salted__") {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  void onKeyTextChanged(String newText) {
    if (privateKeyIsValid(newText)) {
      setState(() {
        _privateKeyValid = true;
        _showPrivateKeyError = false;
      });
    } else {
      setState(() {
        _privateKeyValid = false;
        _showPrivateKeyError = false;
      });
    }
  }

  void validateAndSubmit() {
    if (privateKeyIsValid(privateKeyController.text)) {
      if (!PrivateKeyCoder()
          .decodeFromBytes(PDUtil.hexToBytes(privateKeyController.text))
          .curve
          .supported) {
        showAppDialog(
            context: context,
            builder: (_) => DialogOverlay(
                  title: AppLocalization.of(context).keyTypeNotSupportedHeader,
                  warningStyle: true,
                  confirmButtonText: AppLocalization.of(context).okayGoBackButton,
                  body: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            AppLocalization.of(context).keyTypeNotSupportedParagraph,
                        style: AppStyles.paragraph(context),
                      )
                    ],
                  ),
                  onConfirm: () {
                    Navigator.of(context)
                        .popUntil(RouteUtils.withNameLike('/intro_welcome'));
                  },
                ));
        return;
      }
      sl
          .get<Vault>()
          .setPrivateKey(PrivateKeyCoder()
              .decodeFromBytes(PDUtil.hexToBytes(privateKeyController.text)))
          .then((_) {
        sl.get<SharedPrefsUtil>().setPrivateKeyBackedUp(true).then((_) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return PinScreen(
                type: PinOverlayType.NEW_PIN,
                onSuccess: (pin) {
                  sl.get<Vault>().setPin(pin).then((_) {
                    walletState.requestUpdate();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/overview', (Route<dynamic> route) => false);
                  });
                });
          }));
        });
      });
    } else if (privateKeyIsEncrypted(privateKeyController.text)) {
      Navigator.of(context).pushNamed('/intro_decrypt_and_import_private_key',
          arguments: privateKeyController.text);
    } else {
      setState(() {
        _showPrivateKeyError = true;
      });
    }
  }
}
