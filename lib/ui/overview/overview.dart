import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/overview/buy_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/overview/get_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/settings.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/account_card.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_drawer.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_scaffold.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/placeholder_account_card.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pascaldart/pascaldart.dart';

class OverviewPage extends StatefulWidget {
  final bool newWallet;
  OverviewPage({this.newWallet = true});
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  GlobalKey<AppScaffoldState> _scaffoldKey = GlobalKey<AppScaffoldState>();

  @override
  void initState() {
    super.initState();
    // Load the wallet, total balance, etc.
    walletState.loadWallet();
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
                                // Column for balance texts
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    // Container for "TOTAL BALANCE" text
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      child: AutoSizeText(
                                        "TOTAL BALANCE",
                                        style:
                                            AppStyles.paragraphTextLightSmall(
                                                context),
                                      ),
                                    ),
                                    // Container for the balance
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                160,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            24, 4, 24, 4),
                                        child: Observer(
                                            builder: (BuildContext context) {
                                          if (walletState.walletLoading) {
                                            return Align(
                                              alignment: Alignment(-1, 0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .textLight,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: AutoSizeText(
                                                  "             ",
                                                  style:
                                                      AppStyles.header(context),
                                                  maxLines: 1,
                                                  minFontSize: 8,
                                                  stepGranularity: 1,
                                                ),
                                              ),
                                            );
                                          } else {
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
                                                      text: walletState
                                                          .totalWalletBalance
                                                          .toStringOpt(),
                                                      style: AppStyles.header(
                                                          context)),
                                                ],
                                              ),
                                              maxLines: 1,
                                              minFontSize: 8,
                                              stepGranularity: 1,
                                              style: TextStyle(
                                                fontSize: 28,
                                              ),
                                            );
                                          }
                                        })),
                                    // Container for the fiat conversion
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      child: Observer(
                                        builder: (BuildContext context) {
                                          if (walletState.walletLoading) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .textLight,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: AutoSizeText(
                                                "                  ",
                                                style: AppStyles
                                                    .paragraphTextLightSmall(
                                                        context),
                                              ),
                                            );
                                          } else {
                                            return AutoSizeText(
                                              widget.newWallet
                                                  ? "(\$" + "0.00" + ")"
                                                  : "(\$" + "2,745.14" + ")",
                                              style: AppStyles
                                                  .paragraphTextLightSmall(
                                                      context),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                // Column for settings icon and price text
                                Column(
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
                                                  BorderRadius.circular(50.0)),
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(AppIcons.settings,
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .textLight,
                                              size: 24)),
                                    ),
                                    Container(
                                      margin: EdgeInsetsDirectional.only(
                                          end: 16, bottom: 12),
                                      child: AutoSizeText(
                                        "\$" + "0.269",
                                        style: AppStyles
                                            .paragraphTextLightSmallSemiBold(
                                                context),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Observer(builder: (BuildContext context) {
                        // Wallet loaded with no accounts
                        if (walletState.walletLoading) {
                          return Expanded(
                            child: Column(
                              children: <Widget>[
                                // Accounts text
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      24, 18, 24, 4),
                                  alignment: Alignment(-1, 0),
                                  child: AutoSizeText(
                                    "Accounts".toUpperCase(),
                                    style: AppStyles.headerSmall(context),
                                    textAlign: TextAlign.left,
                                    stepGranularity: 0.5,
                                    maxLines: 1,
                                  ),
                                ),
                                // Accounts List
                                Expanded(
                                  child: Stack(
                                    children: <Widget>[
                                      // The list
                                      ListView(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 3, 0, 19),
                                          children: [
                                            PlaceholderAccountCard(),
                                            PlaceholderAccountCard(),
                                            PlaceholderAccountCard(),
                                          ]),
                                      // The gradient at the top
                                      Container(
                                        height: 8,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            gradient: StateContainer.of(context)
                                                .curTheme
                                                .gradientListTop),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (walletState.walletAccounts.isEmpty) {
                          return Expanded(
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
                                          text: "Welcome to",
                                          style: AppStyles.paragraph(context),
                                        ),
                                        TextSpan(
                                          text: " Blaise Wallet",
                                          style: AppStyles.paragraphPrimary(
                                              context),
                                        ),
                                        TextSpan(
                                          text: ".\n",
                                          style: AppStyles.paragraph(context),
                                        ),
                                        TextSpan(
                                          text:
                                              "You can start by getting an account.",
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
                                  ),
                                  child: SvgRepaintAsset(
                                      asset: StateContainer.of(context)
                                          .curTheme
                                          .illustrationNewWallet,
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.55),
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Wallet Cards
                          return Expanded(
                            child: Column(
                              children: <Widget>[
                                // Accounts text
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      24, 18, 24, 4),
                                  alignment: Alignment(-1, 0),
                                  child: AutoSizeText(
                                    "Accounts".toUpperCase(),
                                    style: AppStyles.headerSmall(context),
                                    textAlign: TextAlign.left,
                                    stepGranularity: 0.5,
                                    maxLines: 1,
                                  ),
                                ),
                                // Accounts List
                                Expanded(
                                  child: Stack(
                                    children: <Widget>[
                                      // The list
                                      ListView(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 3, 0, 19),
                                          children: _getAccountCards(
                                              walletState.walletAccounts)),
                                      // The gradient at the top
                                      Container(
                                        height: 8,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                            gradient: StateContainer.of(context)
                                                .curTheme
                                                .gradientListTop),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                      // Bottom bar
                      Container(
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
                            StateContainer.of(context).curTheme.shadowBottomBar,
                          ],
                        ),
                        child: Container(
                          margin: EdgeInsetsDirectional.only(top: 4),
                          child: Row(
                            children: <Widget>[
                              AppButton(
                                text: "Get an Account",
                                type: AppButtonType.Primary,
                                onPressed: () {
                                  widget.newWallet
                                      ? AppSheets.showBottomSheet(
                                          context: context,
                                          widget: GetAccountSheet())
                                      : AppSheets.showBottomSheet(
                                          context: context,
                                          widget: BuyAccountSheet());
                                },
                              ),
                            ],
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

  List<Widget> _getAccountCards(List<PascalAccount> accounts) {
    List<Widget> ret = [];
    accounts.forEach((account) {
      ret.add(AccountCard(account: account));
    });
    return ret;
  }
}
