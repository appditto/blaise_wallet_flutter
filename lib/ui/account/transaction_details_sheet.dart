import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:qr/qr.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TransactionDetailsSheet extends StatefulWidget {
  final String payload;
  TransactionDetailsSheet({this.payload});

  _TransactionDetailsSheetState createState() =>
      _TransactionDetailsSheetState();
}

class _TransactionDetailsSheetState extends State<TransactionDetailsSheet> {
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
              widget.payload != null
                  ? Container(
                      margin: EdgeInsetsDirectional.only(top: 20),
                      child: AutoSizeText(
                        "Payload",
                        maxLines: 1,
                        stepGranularity: 1,
                        minFontSize: 8,
                        textAlign: TextAlign.start,
                        style: AppStyles.headerSmallBold(context),
                      ),
                    )
                  : SizedBox(),
              widget.payload != null
                  ? Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 24, end: 24, top: 10, bottom: 4),
                      padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            width: 1,
                            color:
                                StateContainer.of(context).curTheme.textDark15),
                        color: StateContainer.of(context).curTheme.textDark10,
                      ),
                      child: AutoSizeText(
                        widget.payload,
                        maxLines: 6,
                        stepGranularity: 0.1,
                        minFontSize: 8,
                        textAlign: TextAlign.center,
                        style: AppStyles.paragraphMedium(context),
                      ),
                    )
                  : SizedBox(),
              //"Copy Address", "Add to Contacts" and ""Transaction Details" buttons
              Row(
                children: <Widget>[
                  AppButton(
                    type: _addressCopied
                        ? AppButtonType.Success
                        : AppButtonType.Primary,
                    text: _addressCopied ? "Address Copied" : "Copy Address",
                    buttonTop: true,
                    onPressed: () {
                      setState(() {
                        _addressCopied = true;
                      });
                      if (_addressCopiedTimer != null) {
                        _addressCopiedTimer.cancel();
                      }
                      _addressCopiedTimer =
                          new Timer(const Duration(milliseconds: 1500), () {
                        setState(() {
                          _addressCopied = false;
                        });
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: "Add to Contacts",
                    buttonMiddle: true,
                  ),
                ],
              ),
              // "Transaction Details" button
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: "Transaction Details",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
