import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/webview.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pascaldart/pascaldart.dart';

class OperationDetailsSheet extends StatefulWidget {
  final PascalOperation operation;

  OperationDetailsSheet({@required this.operation});

  _OperationDetailsSheetState createState() => _OperationDetailsSheetState();
}

class _OperationDetailsSheetState extends State<OperationDetailsSheet> {
  @override
  void initState() {
    super.initState();
  }

  String getOptypeDisplay(int optype) {
    switch (optype) {
      case OpType.BLOCKCHAIN_REWARD:
        return AppLocalization.of(context)
            .blockchainRewardOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.TRANSACTION:
        return AppLocalization.of(context)
            .transactionOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.CHANGE_KEY:
        return AppLocalization.of(context)
            .changeKeyOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.RECOVER_FUNDS:
        return AppLocalization.of(context)
            .recoverFundsOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.LIST_FORSALE:
        return AppLocalization.of(context)
            .listAccountForSaleHeader
            .replaceAll("%1", optype.toString());
      case OpType.DELIST_FORSALE:
        return AppLocalization.of(context)
            .delistAccountOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.BUY_ACCOUNT:
        return AppLocalization.of(context)
            .buyAccountOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.CHANGE_KEY_SIGNED:
        return AppLocalization.of(context)
            .changeKeySignedOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.CHANGE_ACCOUNT_INFO:
        return AppLocalization.of(context)
            .changeAccountInfoOPDetails
            .replaceAll("%1", optype.toString());
      case OpType.MULTIOPERATION:
        return AppLocalization.of(context)
            .multioperationOPDetails
            .replaceAll("%1", optype.toString());
      default:
        return AppLocalization.of(context)
            .unknownOPDetails
            .replaceAll("%1", optype.toString());
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

  Widget getSendingAccount() {
    if (widget.operation.optype == OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).sendingAccountOPDetails,
            value: widget.operation.senders[0].sendingAccount.toString());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getReceivingAccount() {
    if (widget.operation.optype == OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).receivingAccountOPDetails,
            value: widget.operation.receivers[0].receivingAccount.toString());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getChangingAccount() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).changingAccountOPDetails,
            value: widget.operation.changers[0].changingAccount.toString());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getSendAmount() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).sendAmountOPDetails,
            value: widget.operation.senders[0].amount.toStringOpt());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getPayload() {
    if (widget.operation.optype == OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).payloadOPDetails,
            value: widget.operation.senders[0].payload);
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getNewPublickey() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).newPublicKeyOPDetails,
            value: PublicKeyCoder()
                .encodeToBase58(widget.operation.changers[0].newEncPubkey));
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getNewName() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).newNameOPDetails,
            value: widget.operation.changers[0].newName.toString());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getSeller() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).sellerAccountOPDetails,
            value: widget.operation.changers[0].sellerAccount.toString());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getAccountPrice() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).accountPriceOPDetails,
            value: widget.operation.changers[0].accountPrice.toStringOpt());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
  }

  Widget getLockedUntilBlock() {
    if (widget.operation.optype != OpType.TRANSACTION) {
      try {
        return TransactionDetailsListItem(
            header: AppLocalization.of(context).lockedUntilBlockOPDetails,
            value: widget.operation.changers[0].lockedUntilBlock.toString());
      } catch (e) {
        return SizedBox();
      }
    }
    return SizedBox();
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
                                    header: AppLocalization.of(context)
                                        .blockOPDetails,
                                    value: widget.operation.block.toString()),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .optxtOPDetails,
                                    value: widget.operation.optxt),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .timeOPDetails,
                                    value: widget.operation.maturation == null
                                        ? AppLocalization.of(context)
                                            .naOPDetails
                                        : UIUtil.formatDateStrLong(
                                            widget.operation.time)),
                                getSendingAccount(),
                                getSendAmount(),
                                getPayload(),
                                getReceivingAccount(),
                                getNewName(),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .ophashOPDetails,
                                    value: widget.operation.ophash,
                                    withDivider: false),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .optypeOPDetails,
                                    value: getOptypeDisplay(
                                        widget.operation.optype)),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .maturationOPDetails,
                                    value: widget.operation.maturation == null
                                        ? AppLocalization.of(context)
                                            .nullOPDetails
                                        : widget.operation.maturation
                                            .toString()),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .feeOPDetails,
                                    value: widget.operation.fee
                                        .toPositive()
                                        .toStringOpt()),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .opblockOPDetails,
                                    value: widget.operation.opblock.toString()),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .noperationOPDetails,
                                    value: getNOperation().toString()),
                                getSeller(),
                                getAccountPrice(),
                                getLockedUntilBlock(),
                                getNewPublickey(),
                                getChangingAccount(),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .accountOPDetails,
                                    value: widget.operation.account.toString()),
                                TransactionDetailsListItem(
                                    header: AppLocalization.of(context)
                                        .signeraccountOPDetails,
                                    value: widget.operation.signerAccount
                                        .toString()),
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
                          text:
                              AppLocalization.of(context).openInExplorerButton,
                          buttonTop: true,
                          onPressed: () {
                            AppWebView.showWebView(context,
                                'https://explore.pascalcoin.org/operations/${widget.operation.ophash}');
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
          ),
        ),
      ],
    );
  }
}

class TransactionDetailsListItem extends StatefulWidget {
  final String header;
  final String value;
  final bool withDivider;

  TransactionDetailsListItem(
      {this.header, this.value, this.withDivider = true});

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
    return Column(children: <Widget>[
      Container(
        width: double.maxFinite,
        color: _copied
            ? StateContainer.of(context).curTheme.success
            : StateContainer.of(context).curTheme.backgroundPrimary,
        child: FlatButton(
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.value.trim()));
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
                        AppLocalization.of(context).copiedButton,
                        style: AppStyles.textLightSmall700(context),
                        textAlign: TextAlign.end,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
      widget.withDivider
          ? Container(
              width: double.maxFinite,
              height: 1,
              color: StateContainer.of(context).curTheme.textDark10,
            )
          : SizedBox()
    ]);
  }
}
