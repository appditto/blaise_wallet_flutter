import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pascaldart/pascaldart.dart';

class PublicKeySheet extends StatefulWidget {
  _PublicKeySheetState createState() => _PublicKeySheetState();
}

class _PublicKeySheetState extends State<PublicKeySheet> {
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
                      // Sized Box
                      SizedBox(
                        height: 50,
                        width: 65,
                      ),
                      // Header
                      Container(
                        width: MediaQuery.of(context).size.width - 130,
                        alignment: Alignment(0, 0),
                        child: AutoSizeText(
                          toUppercase(AppLocalization.of(context)
                              .publicKeySheetHeader
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
                        child: AutoSizeText(
                          AppLocalization.of(context).publicKeyParagraph,
                          stepGranularity: 0.5,
                          maxLines: 6,
                          minFontSize: 8,
                          style: AppStyles.paragraph(context),
                        ),
                      ),
                      // Container for the private key
                      Container(
                          margin: EdgeInsetsDirectional.fromSTEB(30, 24, 30, 0),
                          padding:
                              EdgeInsetsDirectional.fromSTEB(30, 12, 30, 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                width: 1,
                                color: StateContainer.of(context)
                                    .curTheme
                                    .primary15),
                            color:
                                StateContainer.of(context).curTheme.primary10,
                          ),
                          child: Observer(builder: (BuildContext context) {
                            if (walletState.publicKey != null) {
                              return AutoSizeText(
                                PublicKeyCoder()
                                    .encodeToBase58(walletState.publicKey),
                                maxLines: 6,
                                stepGranularity: 0.1,
                                minFontSize: 8,
                                textAlign: TextAlign.center,
                                style: AppStyles.privateKeyPrimary(context),
                              );
                            } else {
                              return SizedBox();
                            }
                          })),
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
                      text: _keyCopied
                          ? AppLocalization.of(context).keyCopiedButton
                          : AppLocalization.of(context).copyPublicKeyButton,
                      buttonTop: true,
                      onPressed: () {
                        if (walletState.publicKey != null) {
                          Clipboard.setData(ClipboardData(
                              text: PublicKeyCoder()
                                  .encodeToBase58(walletState.publicKey)));
                        }
                        setState(() {
                          _keyCopied = true;
                        });
                        if (_keyCopiedTimer != null) {
                          _keyCopiedTimer.cancel();
                        }
                        _keyCopiedTimer =
                            Timer(const Duration(milliseconds: 1500), () {
                          if (mounted) {
                            setState(() {
                              _keyCopied = false;
                            });
                          }
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
        ),
      ],
    );
  }
}
