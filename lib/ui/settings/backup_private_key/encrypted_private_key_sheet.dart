import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class EncryptedPrivateKeySheet extends StatefulWidget {
  _EncryptedPrivateKeySheetState createState() =>
      _EncryptedPrivateKeySheetState();
}

class _EncryptedPrivateKeySheetState
    extends State<EncryptedPrivateKeySheet> {
  bool _keyCopied;
  bool _showingKey;
  Timer _keyCopiedTimer;

  @override
  void initState() {
    super.initState();
    _keyCopied = false;
    _showingKey = false;
  }

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
                              Navigator.pop(context);
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
                          "PRIVATE KEY",
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
                                text: "Below is your encrypted private key. It is protected by a password. So, you can store it safely on a password manager for convenience.\n\n",
                                style: AppStyles.paragraph(context),
                              ),
                              TextSpan(
                                text:
                                    "Since it is encrypted with your password, if you lose or forget your password, you won’t be able to decrypt it and access your funds.",
                                style: AppStyles.paragraphPrimary(context),
                              ),
                            ],
                          ),
                          stepGranularity: 0.5,
                          maxLines: 10,
                          minFontSize: 8,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      // Container for the private key
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                        padding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .primary15),
                          color: StateContainer.of(context).curTheme.primary10,
                        ),
                        child: AutoSizeText(
                          _showingKey?"53616C7465645F5FED4A37ECAD2BF13FF24A66DDA299A57632520447B28B9E642C4B2A301CACC217FBD7713F6282C20CCCFDC5FFD2AB93A8E48D8C2C81704D36":'•' * 128,
                          maxLines: 4,
                          stepGranularity: 0.1,
                          minFontSize: 8,
                          textAlign: TextAlign.center,
                          style: AppStyles.privateKeyPrimary(context),
                        ),
                      ),
                      // Container for the Show/Hide button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: StateContainer.of(context)
                                      .curTheme
                                      .backgroundPrimary,
                              boxShadow: [
                                StateContainer.of(context)
                                    .curTheme
                                    .shadowTextDark,
                              ],
                            ),
                            margin:
                                EdgeInsetsDirectional.fromSTEB(30, 12, 30, 0),
                            height: 40,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0)),
                              child: AutoSizeText(
                                _showingKey ? "Hide" : "Show",
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                stepGranularity: 0.1,
                                style: AppStyles.buttonMiniBg(context),
                              ),
                              onPressed: () {
                                setState(() {
                                  _showingKey = !_showingKey;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //"Copy Encrypted Key" and "Close" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: _keyCopied
                          ? AppButtonType.Success
                          : AppButtonType.Primary,
                      text: _keyCopied ? "Key Copied" : "Copy Encrypted Key",
                      buttonTop: true,
                      onPressed: () {
                        setState(() {
                          _keyCopied = true;
                        });
                        if (_keyCopiedTimer != null) {
                          _keyCopiedTimer.cancel();
                        }
                        _keyCopiedTimer =
                            new Timer(const Duration(milliseconds: 1500), () {
                          setState(() {
                            _keyCopied = false;
                          });
                        });
                      },
                    ),
                  ],
                ),
                // "Close" button
                Row(
                  children: <Widget>[
                    AppButton(
                      type: AppButtonType.PrimaryOutline,
                      text: "Close",
                      onPressed: () {
                        Navigator.pop(context);
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
}
