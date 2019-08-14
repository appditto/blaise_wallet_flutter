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
import 'package:pascaldart/pascaldart.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/strings.dart';

class PublicKeyOverviewSheet extends StatefulWidget {
  PublicKeyOverviewSheet();

  _PublicKeyOverviewSheetState createState() => _PublicKeyOverviewSheetState();
}

class _PublicKeyOverviewSheetState extends State<PublicKeyOverviewSheet> {
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
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
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
                  gradient: StateContainer.of(context).curTheme.gradientPrimary,
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
                        toUppercase(AppLocalization.of(context).publicKeySheetHeader, context),
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
              // QR Code
              Container(
                margin: EdgeInsetsDirectional.only(top: 30, bottom: 10),
                child: Stack(
                  alignment: Alignment(0, 0),
                  children: <Widget>[
                    // Gradient
                    Container(
                      width: 198,
                      height: 198,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient:
                            StateContainer.of(context).curTheme.gradientPrimary,
                      ),
                    ),
                    // White overlay
                    Container(
                      width: 189,
                      height: 189,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                    // QR Code
                    QrImage(
                      data: PublicKeyCoder()
                          .encodeToBase58(walletState.publicKey),
                      size: 198,
                      errorCorrectionLevel: QrErrorCorrectLevel.Q,
                      gapless: false,
                      version: 9,
                    ),
                    // Logo background
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                    ),
                    // Logo
                    Container(
                      width: 53,
                      height: 53,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient:
                            StateContainer.of(context).curTheme.gradientPrimary,
                      ),
                      child: Icon(AppIcons.pascalsymbol,
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary,
                          size: 33),
                    ),
                  ],
                ),
              ),
              //"Copy Address" and "Request Amount" buttons
              Row(
                children: <Widget>[
                  AppButton(
                    type: _keyCopied
                        ? AppButtonType.Success
                        : AppButtonType.Primary,
                    text: _keyCopied
                        ? AppLocalization.of(context).keyCopiedButton
                        : AppLocalization.of(context).copyPublicKeyButton,
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
              // "Request" button
              /*Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: AppLocalization.of(context).requestButton,
                    onPressed: () {
                        Navigator.of(context).pop();
                        AppSheets.showBottomSheet(
                            context: context,
                            widget: RequestSheet(address: widget.accountNumber.toString()));
                      },
                  ),
                ],
              ),*/
            ],
          ),
        ),
      ],
    );
  }
}
