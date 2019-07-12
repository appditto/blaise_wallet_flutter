import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_text_field.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/tap_outside_unfocus.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:pascaldart/pascaldart.dart';

class IntroDecryptAndImportPrivateKeyPage extends StatefulWidget {
  final String encryptedKey;

  IntroDecryptAndImportPrivateKeyPage({@required this.encryptedKey});

  @override
  _IntroDecryptAndImportPrivateKeyPageState createState() =>
      _IntroDecryptAndImportPrivateKeyPageState();
}

class _IntroDecryptAndImportPrivateKeyPageState
    extends State<IntroDecryptAndImportPrivateKeyPage> {
  FocusNode _passwordFocusNode;
  TextEditingController _passwordController;
  String _passwordError;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _passwordController = TextEditingController();
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // Container for the header
                        Container(
                          padding: EdgeInsetsDirectional.only(
                            top: (MediaQuery.of(context).padding.top) +
                                (24 -
                                    (MediaQuery.of(context).padding.top) /
                                        2),
                          ),
                          decoration: BoxDecoration(
                            gradient: StateContainer.of(context)
                                .curTheme
                                .gradientPrimary,
                          ),
                          // Row for back button and the header
                          child: Row(
                            children: <Widget>[
                              // The header
                              Container(
                                width:
                                    MediaQuery.of(context).size.width - 60,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    30, 24, 30, 24),
                                child: AutoSizeText(
                                  "Decrypt & Import",
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
                          margin: EdgeInsetsDirectional.fromSTEB(
                              30, 30, 30, 20),
                          alignment: Alignment(-1, 0),
                          child: AutoSizeText(
                            "This looks like an encrypted private key, please enter the password to decrypt and import it.",
                            maxLines: 3,
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
                                      label: 'Password',
                                      style: AppStyles.privateKeyPrimary(
                                          context),
                                      passwordField: true,
                                      focusNode: _passwordFocusNode,
                                      controller: _passwordController,
                                      onChanged: onPasswordChanged,
                                      maxLines: 1,
                                    )),
                                // Error Text
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      start: 30,
                                      end: 30,
                                      top: 4,
                                      bottom: 40),
                                  child: Text(
                                    _passwordError == null
                                        ? ""
                                        : _passwordError,
                                    style:
                                        AppStyles.paragraphPrimary(context),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ),
              //"Import" and "Go Back" buttons
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.Primary,
                    text: "Import",
                    buttonTop: true,
                    onPressed: () {
                      decryptAndSubmit();
                    },
                  ),
                ],
              ),
              // "Go Back" button
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: "Go Back",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        )
      )
    );
  }

  void onPasswordChanged(String newText) {
    setState(() {
      _passwordError = null;
    });
  }

  void decryptAndSubmit() {
    if (_passwordController.text.length < 1) {
      setState(() {
        _passwordError = "Password cannot be empty";
      });
      return;
    }
    PrivateKey privKey;
    try {
      privKey = PrivateKeyCrypt.decrypt(
          PDUtil.hexToBytes(widget.encryptedKey), _passwordController.text);
    } catch (e) {
      setState(() {
        _passwordError = "Invalid Password";
      });
      return;
    }
    sl.get<Vault>().setPrivateKey(privKey).then((_) {
      sl.get<SharedPrefsUtil>().setPrivateKeyBackedUp(true).then((_) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/overview', (Route<dynamic> route) => false);
      });
    });
  }
}
