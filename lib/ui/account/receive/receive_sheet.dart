import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/account/receive/request_sheet.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quiver/strings.dart';

class ReceiveSheet extends StatefulWidget {
  final String accountName;
  final AccountNumber accountNumber;
  ReceiveSheet({this.accountName, this.accountNumber});

  _ReceiveSheetState createState() => _ReceiveSheetState();
}

class _ReceiveSheetState extends State<ReceiveSheet> {
  bool _addressCopied;
  Timer _addressCopiedTimer;

  @override
  void initState() {
    super.initState();
    _addressCopied = false;
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
                    SizedBox(width: 65, height: 50),
                    // Header
                    Container(
                      width: MediaQuery.of(context).size.width - 130,
                      alignment: Alignment(0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: isEmpty(widget.accountName)
                                ? SizedBox()
                                : Container(
                                    margin: EdgeInsets.only(bottom: 2),
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    child: AutoSizeText(
                                      widget.accountName,
                                      style: AppStyles.accountCardName(context),
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                      minFontSize: 8,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 130,
                            child: AutoSizeText(
                              widget.accountNumber.toString(),
                              style: AppStyles.accountCardAddress(context),
                              maxLines: 1,
                              stepGranularity: 0.1,
                              minFontSize: 8,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Share Button is removed for beta
                    /*Container(
                      margin: EdgeInsetsDirectional.only(start: 10, end: 5),
                      height: 50,
                      width: 50,
                      child: FlatButton(
                          highlightColor:
                              StateContainer.of(context).curTheme.textLight15,
                          splashColor:
                              StateContainer.of(context).curTheme.textLight30,
                          onPressed: () {
                            return null;
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Icon(AppIcons.shareaddress,
                              color:
                                  StateContainer.of(context).curTheme.textLight,
                              size: 22)),
                    ),*/
                    SizedBox(width: 65, height: 50),
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
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient:
                            StateContainer.of(context).curTheme.gradientPrimary,
                      ),
                    ),
                    // White overlay
                    Container(
                      width: 172,
                      height: 172,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                    ),
                    // QR Code
                    QrImage(
                      data: widget.accountNumber.toString(),
                      size: 180.0,
                      errorCorrectionLevel: QrErrorCorrectLevel.Q,
                      version: 4,
                      gapless: false,
                    ),
                    // Logo background
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                    ),
                    // Logo
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient:
                            StateContainer.of(context).curTheme.gradientPrimary,
                      ),
                      child: Icon(AppIcons.pascalsymbol,
                          color: StateContainer.of(context)
                              .curTheme
                              .backgroundPrimary,
                          size: 30),
                    ),
                  ],
                ),
              ),
              //"Copy Address" and "Request Amount" buttons
              Row(
                children: <Widget>[
                  AppButton(
                    type: _addressCopied
                        ? AppButtonType.Success
                        : AppButtonType.Primary,
                    text: _addressCopied
                        ? AppLocalization.of(context).copiedAddressButton
                        : AppLocalization.of(context).copyAddressButton,
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.accountNumber.toString()));
                      setState(() {
                        _addressCopied = true;
                      });
                      if (_addressCopiedTimer != null) {
                        _addressCopiedTimer.cancel();
                      }
                      _addressCopiedTimer =
                          Timer(const Duration(milliseconds: 1500), () {
                        if (mounted) {
                          setState(() {
                            _addressCopied = false;
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
