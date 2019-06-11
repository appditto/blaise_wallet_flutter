import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class PublicKeySheet extends StatefulWidget {
  _PublicKeySheetState createState() =>
      _PublicKeySheetState();
}

class _PublicKeySheetState
    extends State<PublicKeySheet> {
  bool _keyCopied;
  Timer _keyCopiedTimer;

  @override
  void initState() {
    super.initState();
    _keyCopied = false;
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
                          "PUBLIC KEY",
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
                        child: AutoSizeText(
                          "Below is your public key. As the name suggest, it is safe to share it publicly. It is used to publicly prove that a particular operation belongs to your private key.",
                          stepGranularity: 0.5,
                          maxLines: 6,
                          minFontSize: 8,
                          style: AppStyles.paragraph(context),
                        ),
                      ),
                      // Container for the private key
                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                        padding: EdgeInsetsDirectional.fromSTEB(30, 12, 30, 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              width: 1,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .primary15),
                          color: StateContainer.of(context).curTheme.primary10,
                        ),
                        // TODO PublicKey would be nicer stored in the global state
                        child: FutureBuilder(
                          future: sl.get<Vault>().getPrivateKey(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              PrivateKey pk = PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(snapshot.data));
                              String pubKey = PublicKeyCoder().encodeToBase58(Keys.fromPrivateKey(pk).publicKey);
                              return AutoSizeText(
                                pubKey,
                                maxLines: 6,
                                stepGranularity: 0.1,
                                minFontSize: 8,
                                textAlign: TextAlign.center,
                                style: AppStyles.privateKeyPrimary(context),
                              );
                            } else {
                              return SizedBox();
                            }
                          }
                        )
                      ),
                    ],
                  ),
                ),
                //"Copy Unencrypted Key" and "Close" buttons
                Row(
                  children: <Widget>[
                    AppButton(
                      type: _keyCopied
                          ? AppButtonType.Success
                          : AppButtonType.Primary,
                      text: _keyCopied ? "Key Copied" : "Copy Public Key",
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
