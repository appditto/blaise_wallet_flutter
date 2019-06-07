import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/account/receive_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/transaction_details_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/settings.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/account_card.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_drawer.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_scaffold.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/operation_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  List<DialogListItem> operationsList = [
    DialogListItem(option: "Change Account Name"),
    DialogListItem(option: "Transfer Account"),
    DialogListItem(option: "List Account for Sale"),
    DialogListItem(option: "Private Sale"),
    DialogListItem(option: "Delist Account", disabled: true),
  ];
  GlobalKey<AppScaffoldState> _scaffoldKey = GlobalKey<AppScaffoldState>();

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
                                      child: AutoSizeText.rich(
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
                                                style: TextStyle(fontSize: 12)),
                                            TextSpan(
                                                text: "9,104",
                                                style:
                                                    AppStyles.header(context)),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        minFontSize: 8,
                                        stepGranularity: 1,
                                        style: TextStyle(
                                          fontSize: 28,
                                        ),
                                      ),
                                    ),
                                    // Container for the fiat conversion
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: AutoSizeText(
                                        "(\$" + "2,448.97" + ")",
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
                      // Wallet Cards
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            // Accounts text
                            Container(
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(24, 18, 24, 4),
                              alignment: Alignment(-1, 0),
                              child: AutoSizeText(
                                "Operations".toUpperCase(),
                                style: AppStyles.headerSmall(context),
                                textAlign: TextAlign.left,
                                stepGranularity: 0.5,
                                maxLines: 1,
                              ),
                            ),
                            // Expanded list
                            Expanded(
                              // Container for the list
                              child: Container(
                                margin: EdgeInsetsDirectional.fromSTEB(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                  child: ListView(
                                    padding:
                                        EdgeInsetsDirectional.only(bottom: 24),
                                    children: <Widget>[
                                      OperationListItem(
                                        type: OperationType.Received,
                                        amount: "1,864",
                                        address: "212823-56",
                                        date: "May 23 • 16:16",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet());
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                      OperationListItem(
                                        type: OperationType.Sent,
                                        amount: "41.843",
                                        address: "@bbedward",
                                        date: "May 22 • 12:19",
                                        payload: "What's up bb?",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet(payload: "What's up bb?",));
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                      OperationListItem(
                                        type: OperationType.Received,
                                        amount: "321.2",
                                        address: "112131-21",
                                        date: "May 22 • 11:44",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet());
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                      OperationListItem(
                                        type: OperationType.Sent,
                                        amount: "22.5321",
                                        address: "@odm4rk",
                                        date: "May 20 • 23:5",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet());
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                      OperationListItem(
                                        type: OperationType.Sent,
                                        amount: "19.19",
                                        address: "191919-19",
                                        date: "May 19 • 19:19",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet());
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                      OperationListItem(
                                        type: OperationType.Received,
                                        amount: "2,341.45",
                                        address: "515219-67",
                                        date: "May 19 • 16:07",
                                        payload: "This is the rest of the payment.",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet(payload: "This is the rest of the payment.",));
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                      OperationListItem(
                                        type: OperationType.Received,
                                        amount: "16.75",
                                        address: "442152-13",
                                        date: "May 18 • 12:15",
                                        onPressed: () {
                                          AppSheets.showBottomSheet(
                                              context: context,
                                              animationDurationMs: 200,
                                              widget:
                                                  TransactionDetailsSheet());
                                        },
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        height: 1,
                                        color: StateContainer.of(context)
                                            .curTheme
                                            .textDark10,
                                      ),
                                    ],
                                  ),
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
                                AppButton(
                                  text: "Receive",
                                  type: AppButtonType.PrimaryLeft,
                                  onPressed: () {
                                    AppSheets.showBottomSheet(
                                        context: context,
                                        widget: ReceiveSheet(
                                          accountName: "yekta",
                                          address: "578706-79",
                                        ));
                                  },
                                ),
                                AppButton(
                                  text: "Send",
                                  type: AppButtonType.PrimaryRight,
                                ),
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
}
