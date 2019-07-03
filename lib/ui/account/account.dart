import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/change_name/change_name_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/list_for_sale/list_for_sale_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/private_sale/create_private_sale_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/transfer_account/transfer_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/receive/receive_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/send/send_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/transaction_details_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/settings.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_drawer.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_scaffold.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/operation_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/placeholder_operation_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pascaldart/pascaldart.dart';

class AccountPage extends StatefulWidget {
  final PascalAccount account;
  final bool isBorrowed;

  AccountPage({@required this.account, this.isBorrowed = false});
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  GlobalKey<AppScaffoldState> _scaffoldKey = GlobalKey<AppScaffoldState>();
  List<DialogListItem> operationsList;
  Account accountState;
  List<PascalOperation> rawOperations;
  List<Widget> accountHistory;

  @override
  void initState() {
    super.initState();
    this.operationsList = getOperationsList();
    this.accountState = walletState.getAccountState(widget.account);
    this.accountState.updateAccount();
    if (!this.accountState.operationsLoading) {
      updateAccountHistory();
    }
    this.accountState.getAccountOperations().then((_) {
      updateAccountHistory();
    });
  }

  List<DialogListItem> getOperationsList() {
    return [
      DialogListItem(
        option: "Change Account Name",
        action: () {
          Navigator.pop(context);
          AppSheets.showBottomSheet(
              context: context, widget: ChangeNameSheet());
        },
      ),
      DialogListItem(
        option: "Transfer Account",
        action: () {
          Navigator.pop(context);
          AppSheets.showBottomSheet(
              context: context, widget: TransferAccountSheet());
        },
      ),
      DialogListItem(
        option: "List Account for Sale",
        action: () {
          Navigator.pop(context);
          AppSheets.showBottomSheet(
              context: context, widget: ListForSaleSheet());
        },
      ),
      DialogListItem(
        option: "Private Sale",
        action: () {
          Navigator.pop(context);
          AppSheets.showBottomSheet(
              context: context, widget: CreatePrivateSaleSheet());
        },
      ),
      DialogListItem(option: "Delist Account", disabled: true),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return AppScaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      endDrawer: SizedBox(
          width: double.infinity, child: AppDrawer(child: SettingsPage())),
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      body: LayoutBuilder(
        builder: (context, constraints) => Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // A stack for the main card and the background gradient
                      Stack(
                        children: <Widget>[
                          // Container for the gradient background
                          Container(
                            height: 65 +
                                (MediaQuery.of(context).padding.top) +
                                (20 -
                                    (MediaQuery.of(context).padding.bottom) /
                                        2),
                            decoration: BoxDecoration(
                              gradient: StateContainer.of(context)
                                  .curTheme
                                  .gradientPrimary,
                            ),
                          ),
                          //Container for the main card
                          Container(
                            height: 130,
                            margin: EdgeInsetsDirectional.fromSTEB(
                                12,
                                (MediaQuery.of(context).padding.top) +
                                    (20 -
                                        (MediaQuery.of(context)
                                                .padding
                                                .bottom) /
                                            2),
                                12,
                                0),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                gradient: StateContainer.of(context)
                                    .curTheme
                                    .gradientPrimary,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  StateContainer.of(context)
                                      .curTheme
                                      .shadowMainCard,
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Back icon and price text
                                Container(
                                  height: 130,
                                  width: 60,
                                  alignment: Alignment(0, -1),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Back icon
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                            top: 2, start: 2),
                                        height: 50,
                                        width: 50,
                                        child: FlatButton(
                                            highlightColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .textLight15,
                                            splashColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .textLight30,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            padding: EdgeInsetsDirectional.only(
                                                end: 10),
                                            child: Icon(AppIcons.back,
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .textLight,
                                                size: 22)),
                                      ),
                                      // Price text
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                            start: 16, bottom: 12),
                                        child: AutoSizeText(
                                          "\$" + "0.269",
                                          maxLines: 1,
                                          stepGranularity: 0.1,
                                          minFontSize: 8,
                                          textAlign: TextAlign.start,
                                          style: AppStyles
                                              .paragraphTextLightSmallSemiBold(
                                                  context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Column for balance texts
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    // Container for "TOTAL BALANCE" text
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: AutoSizeText(
                                        "TOTAL BALANCE",
                                        style:
                                            AppStyles.paragraphTextLightSmall(
                                                context),
                                      ),
                                    ),
                                    // Container for the balance
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          168,
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12, 4, 12, 4),
                                      child: Observer(
                                        builder: (BuildContext context) {
                                          return AutoSizeText.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "",
                                                  style: AppStyles
                                                      .iconFontTextLightPascal(
                                                          context),
                                                ),
                                                TextSpan(
                                                    text: " ",
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                                TextSpan(
                                                    text: accountState
                                                        .account.balance
                                                        .toStringOpt(),
                                                    style: AppStyles.header(
                                                        context))
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            minFontSize: 8,
                                            stepGranularity: 1,
                                            style: TextStyle(
                                              fontSize: 28,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    // Container for the fiat conversion
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: AutoSizeText(
                                        "(\$0.00)",
                                        style:
                                            AppStyles.paragraphTextLightSmall(
                                                context),
                                      ),
                                    ),
                                  ],
                                ),
                                // Column for settings icon and other operations icon
                                Container(
                                  width: 60,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      // Settings Icon
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                            top: 2, end: 2),
                                        height: 50,
                                        width: 50,
                                        child: FlatButton(
                                            highlightColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .textLight15,
                                            splashColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .textLight30,
                                            onPressed: () {
                                              _scaffoldKey.currentState
                                                  .openEndDrawer();
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            padding: EdgeInsets.all(0.0),
                                            child: Icon(AppIcons.settings,
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .textLight,
                                                size: 24)),
                                      ),
                                      // Other Operations Icon
                                      Container(
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: 2, end: 2),
                                        height: 50,
                                        width: 50,
                                        child: FlatButton(
                                            highlightColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .textLight15,
                                            splashColor:
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .textLight30,
                                            onPressed: () {
                                              showAppDialog(
                                                  context: context,
                                                  builder: (_) => DialogOverlay(
                                                      title: 'Other Operations',
                                                      optionsList:
                                                          operationsList));
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        50.0)),
                                            padding: EdgeInsetsDirectional.only(
                                                start: 8, top: 6),
                                            child: Icon(AppIcons.edit,
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .textLight,
                                                size: 18)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      widget.isBorrowed
                          ? // Paragraph and illustration
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  //Container for the paragraph
                                  Container(
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        30, 0, 30, 0),
                                    child: AutoSizeText.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "This is a",
                                            style: AppStyles.paragraph(context),
                                          ),
                                          TextSpan(
                                            text: " borrowed account",
                                            style: AppStyles.paragraphPrimary(
                                                context),
                                          ),
                                          TextSpan(
                                            text: ".\n",
                                            style: AppStyles.paragraph(context),
                                          ),
                                          TextSpan(
                                            text: "If you send at least",
                                            style: AppStyles.paragraph(context),
                                          ),
                                          TextSpan(
                                            text: " 0.25 PASCAL",
                                            style: AppStyles.paragraphPrimary(
                                                context),
                                          ),
                                          TextSpan(
                                            text: " to it in the next",
                                            style: AppStyles.paragraph(context),
                                          ),
                                          TextSpan(
                                            text: " 5 days 8 hours",
                                            style: AppStyles.paragraphPrimary(
                                                context),
                                          ),
                                          TextSpan(
                                            text: ", it’ll be yours.",
                                            style: AppStyles.paragraph(context),
                                          ),
                                        ],
                                      ),
                                      stepGranularity: 0.5,
                                      maxLines: 10,
                                      minFontSize: 8,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  // Container for the illustration
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                      top: 24,
                                      bottom: 24,
                                    ),
                                    child: SvgRepaintAsset(
                                        asset: StateContainer.of(context)
                                            .curTheme
                                            .illustrationBorrowed,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.8 *
                                                132 /
                                                295),
                                  ),
                                ],
                              ),
                            )
                          :
                          // Wallet Cards
                          Expanded(
                              child: widget.isBorrowed
                                  ? SizedBox()
                                  : Column(
                                      children: <Widget>[
                                        // Accounts text
                                        Container(
                                          margin:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  24, 18, 24, 4),
                                          alignment: Alignment(-1, 0),
                                          child: AutoSizeText(
                                            "Operations".toUpperCase(),
                                            style:
                                                AppStyles.headerSmall(context),
                                            textAlign: TextAlign.left,
                                            stepGranularity: 0.5,
                                            maxLines: 1,
                                          ),
                                        ),
                                        // Expanded list
                                        Expanded(
                                          // Container for the list
                                          child: Container(
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 8, 12, 0),
                                            width: double.maxFinite,
                                            decoration: BoxDecoration(
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .backgroundPrimary,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                              boxShadow: [
                                                StateContainer.of(context)
                                                    .curTheme
                                                    .shadowSettingsList,
                                              ],
                                            ),
                                            // Operations List
                                            child: Observer(
                                              builder: (BuildContext context) {
                                                if (accountState
                                                        .operationsLoading ||
                                                    accountHistory == null) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12)),
                                                    child: ListView(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    bottom: 24),
                                                        children: [
                                                          PlaceholderOperationListItem(type: PlaceholderOperationType.Sent),
                                                          PlaceholderOperationListItem(type: PlaceholderOperationType.Received),
                                                          PlaceholderOperationListItem(type: PlaceholderOperationType.Sent),
                                                          PlaceholderOperationListItem(type: PlaceholderOperationType.Received),
                                                          PlaceholderOperationListItem(type: PlaceholderOperationType.Sent),
                                                        ]),
                                                  );
                                                } else {
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft: Radius
                                                                .circular(12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12)),
                                                    child: ListView(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                                    bottom: 24),
                                                        children:
                                                            accountHistory),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                      // Bottom bar
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: StateContainer.of(context)
                                .curTheme
                                .backgroundPrimary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            boxShadow: [
                              StateContainer.of(context)
                                  .curTheme
                                  .shadowBottomBar,
                            ],
                          ),
                          child: Container(
                            margin: EdgeInsetsDirectional.only(top: 4),
                            child: Row(
                              children: <Widget>[
                                Observer(
                                  builder: (BuildContext context) {
                                    PascalAccount account =
                                        accountState.account;
                                    return AppButton(
                                      text: "Receive",
                                      type: AppButtonType.PrimaryLeft,
                                      onPressed: () {
                                        AppSheets.showBottomSheet(
                                            context: context,
                                            widget: ReceiveSheet(
                                              accountName:
                                                  account.name.accountName,
                                              accountNumber: account.account,
                                            ));
                                      },
                                    );
                                  },
                                ),
                                Observer(
                                  builder: (BuildContext context) {
                                    return AppButton(
                                      text: "Send",
                                      type: AppButtonType.PrimaryRight,
                                      disabled: accountState.account.balance >
                                              Currency('0')
                                          ? false
                                          : true,
                                      onPressed: () {
                                        AppSheets.showBottomSheet(
                                          context: context,
                                          widget: SendSheet(
                                            account: widget.account,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  void updateAccountHistory() {
    List<Widget> history = [];
    this.accountState.operations.forEach((op) {
      if (op.optype == OpType.TRANSACTION) {
        OperationType type;
        if (op.amount.pasc < BigInt.zero) {
          type = OperationType.Sent;
        } else {
          type = OperationType.Received;
        }
        history.add(OperationListItem(
          type: type,
          amount: op.receivers[0].amount.toStringOpt(),
          address: type == OperationType.Received
              ? op.senders[0].sendingAccount.toString()
              : op.receivers[0].receivingAccount.toString(),
          date: UIUtil.formatDateStr(op.time),
          payload: op.receivers[0].payload,
          onPressed: () {
            AppSheets.showBottomSheet(
                context: context,
                animationDurationMs: 200,
                widget: TransactionDetailsSheet(
                  payload: op.receivers[0].payload,
                  ophash: op.ophash,
                  account: type == OperationType.Received
                      ? op.senders[0].sendingAccount
                      : op.receivers[0].receivingAccount,
                ));
          },
        ));
      }
    });
    if (history.length == 0) {
      // Show welcome
      history.add(OperationListItem(type: OperationType.Welcome));
      history.add(OperationListItem(
        type: OperationType.Sent,
        amount: "1,111",
        address: "111111-11",
        date: "May 11 • 11:11",
      ));
      history.add(OperationListItem(
        type: OperationType.Received,
        amount: "1,111",
        address: "111111-11",
        date: "May 11 • 11:11",
      ));
    }
    setState(() {
      this.accountHistory = history;
    });
  }
}
