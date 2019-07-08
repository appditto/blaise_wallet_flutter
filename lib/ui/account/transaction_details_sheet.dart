import 'dart:async';
import 'dart:typed_data';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:quiver/strings.dart';

class TransactionDetailsSheet extends StatefulWidget {
  _TransactionDetailsSheetState createState() =>
      _TransactionDetailsSheetState();
}

class _TransactionDetailsSheetState extends State<TransactionDetailsSheet> {
  @override
  void initState() {
    super.initState();
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
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Material(
                child: Column(
                  children: <Widget>[
                    // Transaction Details
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          // The List
                          SingleChildScrollView(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 50),
                            child: Column(
                              children: <Widget>[
                                TransactionDetailsListItem(
                                    header: "block", value: "331135"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "time",
                                    value:
                                        "Jul 08, 2019 • 13:24:01 (1562592241)"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "opblock", value: "1"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "maturation", value: "2"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "optype",
                                    value: "Delist Account (5)"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "account", value: "582406"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "signer_account", value: "582406"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "n_opreation", value: "5976"),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "ophash",
                                    value:
                                        "7D0D050006E3080058170000A316A82C0DAA2122DBB79A7EA37450EB66471BBB"),
                              ],
                            ),
                          ),
                          // Bottom Gradient
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 40,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      0.0,
                                      1.0
                                    ],
                                    colors: [
                                      StateContainer.of(context)
                                          .curTheme
                                          .backgroundPrimary
                                          .withOpacity(0.0),
                                      StateContainer.of(context)
                                          .curTheme
                                          .backgroundPrimary,
                                    ]),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //"Open in Explorer" button
                    Row(
                      children: <Widget>[
                        AppButton(
                          type: AppButtonType.Primary,
                          text: "Open in Explorer",
                          buttonTop: true,
                          onPressed: () {
                            return null;
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
          ),
        ),
      ],
    );
  }
}

class TransactionDetailsListItem extends StatefulWidget {
  final String header;
  final String value;
  TransactionDetailsListItem({
    this.header,
    this.value,
  });
  _TransactionDetailsListItemState createState() =>
      _TransactionDetailsListItemState();
}

class _TransactionDetailsListItemState
    extends State<TransactionDetailsListItem> {
  @override
  void initState() {
    super.initState();
  }

  Timer _copiedTimer;
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      color: _copied
          ? StateContainer.of(context).curTheme.success
          : StateContainer.of(context).curTheme.backgroundPrimary,
      child: FlatButton(
        onPressed: () {
          setState(() {
            _copied = true;
          });
          if (_copiedTimer != null) {
            _copiedTimer.cancel();
          }
          _copiedTimer = Timer(const Duration(milliseconds: 1000), () {
            if (mounted) {
              setState(() {
                _copied = false;
              });
            }
          });
        },
        splashColor: StateContainer.of(context).curTheme.textDark30,
        highlightColor: StateContainer.of(context).curTheme.textDark15,
        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: AutoSizeText(
                widget.header,
                style: _copied
                    ? AppStyles.textLightSmall400(context)
                    : AppStyles.textDarkSmall400(context),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 100,
              margin: EdgeInsetsDirectional.only(top: 6),
              child: AutoSizeText(
                widget.value,
                style: _copied
                    ? AppStyles.textLightLarge700(context)
                    : AppStyles.textDarkLarge700(context),
                textAlign: TextAlign.center,
              ),
            ),
            _copied
                ? Container(
                    alignment: Alignment(1, 0),
                    margin: EdgeInsetsDirectional.only(end: 16),
                    child: AutoSizeText(
                      "Copied",
                      style: AppStyles.textLightSmall700(context),
                      textAlign: TextAlign.end,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
