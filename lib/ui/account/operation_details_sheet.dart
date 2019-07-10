import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:pascaldart/pascaldart.dart';

class OperationDetailsSheet extends StatefulWidget {
  final PascalOperation operation;

  OperationDetailsSheet({@required this.operation});

  _OperationDetailsSheetState createState() =>
      _OperationDetailsSheetState();
}

class _OperationDetailsSheetState extends State<OperationDetailsSheet> {
  @override
  void initState() {
    super.initState();
  }

  String getOptypeDisplay(int optype) {
    switch (optype) {
      case OpType.BLOCKCHAIN_REWARD:
        return "Blockchain Reward ($optype)";
      case OpType.TRANSACTION:
        return "Transaction ($optype)";
      case OpType.CHANGE_KEY:
        return "Change Key ($optype)";
      case OpType.RECOVER_FUNDS:
        return "Recover Funds ($optype)";
      case OpType.LIST_FORSALE:
        return "List Account for Sale ($optype)";
      case OpType.DELIST_FORSALE:
        return "Delist Account ($optype)";
      case OpType.BUY_ACCOUNT:
        return "Buy account ($optype)";
      case OpType.CHANGE_KEY_SIGNED:
        return "Change Key Signed ($optype)";
      case OpType.CHANGE_ACCOUNT_INFO:
        return "Change Account Info ($optype)";
      case OpType.MULTIOPERATION:
        return "Multioperation ($optype)";
      default:
        return "Unknown ($optype)";
    }
  }

  int getNOperation() {
    int nOp;
    try {
      if (widget.operation.optype == OpType.TRANSACTION) {
        nOp = widget.operation.senders[0].nOperation;
      } else {
        nOp = widget.operation.changers[0].nOperation;
      }
    } catch (e) {
      nOp = -1;
    }
    return nOp;
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
                                    header: "block", value: widget.operation.block.toString()),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "time",
                                    value:
                                        widget.operation.maturation == null ? "N/A" : UIUtil.formatDateStrLong(widget.operation.time)),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "opblock", value: widget.operation.opblock.toString()),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "maturation", value: widget.operation.maturation == null ? "null" : widget.operation.maturation.toString()),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                       .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "optype",
                                    value: getOptypeDisplay(widget.operation.optype)),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "account", value: widget.operation.account.account.toString()),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "signer_account", value: widget.operation.signerAccount.toString()),
                                Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                getNOperation() == -1 ? SizedBox() : TransactionDetailsListItem(
                                    header: "n_operation", value: getNOperation().toString()),
                                getNOperation() == -1 ? SizedBox() : Divider(
                                  color: StateContainer.of(context)
                                      .curTheme
                                      .textDark10,
                                  height: 1,
                                ),
                                TransactionDetailsListItem(
                                    header: "ophash",
                                    value:
                                        widget.operation.ophash),
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
