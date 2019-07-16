import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/overview/get_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/overview/get_account_sheet_beta.dart';
import 'package:blaise_wallet_flutter/ui/overview/get_account_sheet_beta_with_accounts.dart';
import 'package:blaise_wallet_flutter/ui/settings/settings.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/account_card.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_drawer.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_scaffold.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/placeholder_account_card.dart';
import 'package:blaise_wallet_flutter/ui/widgets/reactive_refresh.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/util/haptic_util.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class OverviewPage extends StatefulWidget {
  OverviewPage();
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  GlobalKey<AppScaffoldState> _scaffoldKey = GlobalKey<AppScaffoldState>();
  // Opacity Animation
  Animation<double> _opacityAnimation;
  AnimationController _opacityAnimationController;

  // Pull to refresh
  bool _isRefreshing;
  // Whether to lock app
  bool _lockDisabled;

  Future<void> walletLoad() async {
    try {
      await walletState?.loadWallet();
    } catch (e) {
      if (mounted) {
        UIUtil.showSnackbar("Did not get a response from server", context);
      }
    }
  }

  StreamSubscription<DaemonChangedEvent> _daemonChangeSub;
  StreamSubscription<DisableLockTimeoutEvent> _disableLockSub;

  void _registerBus() {
    _daemonChangeSub = EventTaxiImpl.singleton()
        .registerTo<DaemonChangedEvent>()
        .listen((event) {
      walletLoad();
    });
    // Hackish event to block auto-lock functionality
    _disableLockSub = EventTaxiImpl.singleton()
        .registerTo<DisableLockTimeoutEvent>()
        .listen((event) {
      if (event.disable) {
        cancelLockEvent();
      }
      _lockDisabled = event.disable;
    });
  }

  void _destroyBus() {
    if (_daemonChangeSub != null) {
      _daemonChangeSub.cancel();
    }
    if (_disableLockSub != null) {
      _disableLockSub.cancel();
    }    
  }

  // To lock and unlock the app
  StreamSubscription<dynamic> lockStreamListener;

  Future<void> setAppLockEvent() async {
    if (await sl.get<SharedPrefsUtil>().getLock() && !_lockDisabled) {
      if (lockStreamListener != null) {
        lockStreamListener.cancel();
      }
      Future<dynamic> delayed = new Future.delayed(
          (await sl.get<SharedPrefsUtil>().getLockTimeout()).getDuration());
      delayed.then((_) {
        return true;
      });
      lockStreamListener = delayed.asStream().listen((_) {
        Navigator.of(context).pushReplacementNamed('/');
      });
    }
  }

  Future<void> cancelLockEvent() async {
    if (lockStreamListener != null) {
      lockStreamListener.cancel();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        setAppLockEvent();
        break;
      case AppLifecycleState.resumed:
        cancelLockEvent();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    WidgetsBinding.instance.addObserver(this);
    _isRefreshing = false;
    _lockDisabled = false;
    // Load the wallet, total balance, etc.
    walletLoad();
    // Opacity Animation
    _opacityAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _opacityAnimationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _startAnimation();
  }

  void _animationStatusListener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
        _opacityAnimationController.forward();
        break;
      case AnimationStatus.completed:
        _opacityAnimationController.reverse();
        break;
      default:
        return null;
    }
  }

  void _animationControllerListener() {
    if (walletState.walletLoading) {
      setState(() {});
    } else {
      _disposeAnimations();
    }
  }

  void _disposeAnimations() {
    try {
      _opacityAnimation?.removeStatusListener(_animationStatusListener);
      _opacityAnimationController?.removeListener(_animationControllerListener);
      _opacityAnimationController?.dispose();
    } catch (e) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeAnimations();
    _destroyBus();
    super.dispose();
  }

  void _startAnimation() {
    _opacityAnimationController.addListener(_animationControllerListener);
    _opacityAnimation.addStatusListener(_animationStatusListener);
    _opacityAnimationController.forward();
  }

  // Refresh list
  Future<void> _refresh() async {
    setState(() {
      _isRefreshing = true;
    });
    HapticUtil.success();
    // Hide refresh indicator after 3 seconds if no server response
    Future.delayed(new Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    });
    walletLoad().whenComplete(() {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    });
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
                            (20 - (MediaQuery.of(context).padding.bottom) / 2),
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
                                    (MediaQuery.of(context).padding.bottom) /
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
                                    style: AppStyles.paragraphTextLightSmall(
                                        context),
                                  ),
                                ),
                                // Container for the balance
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 160,
                                    margin: EdgeInsetsDirectional.fromSTEB(
                                        24, 4, 24, 4),
                                    child: Observer(
                                        builder: (BuildContext context) {
                                      if (walletState.walletLoading) {
                                        return Opacity(
                                          opacity: _opacityAnimation.value,
                                          child: Align(
                                            alignment: Alignment(-1, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .textLight
                                                        .withOpacity(0.75),
                                                borderRadius:
                                                    BorderRadius.circular(100),
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
                                                  style:
                                                      TextStyle(fontSize: 12)),
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
                                        return Opacity(
                                          opacity: _opacityAnimation.value,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .textLight
                                                  .withOpacity(0.75),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: AutoSizeText(
                                              "                  ",
                                              style: AppStyles
                                                  .paragraphTextLightSmall(
                                                      context),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return AutoSizeText(
                                          "(\$" + "0.00" + ")",
                                          style:
                                              AppStyles.paragraphTextLightSmall(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // Settings Icon
                                Container(
                                  margin: EdgeInsetsDirectional.only(
                                      top: 2, end: 2),
                                  height: 50,
                                  width: 50,
                                  child: FlatButton(
                                      highlightColor: StateContainer.of(context)
                                          .curTheme
                                          .textLight15,
                                      splashColor: StateContainer.of(context)
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
                                  child: Observer(
                                    builder: (BuildContext context) {
                                      if (walletState.walletLoading) {
                                        return Opacity(
                                          opacity: _opacityAnimation.value,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: StateContainer.of(context)
                                                  .curTheme
                                                  .textLight
                                                  .withOpacity(0.75),
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: AutoSizeText(
                                              "            ",
                                              style: AppStyles
                                                  .paragraphTextLightSmallSemiBold(
                                                      context),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return AutoSizeText(
                                          "\$" + "0.000",
                                          style: AppStyles
                                              .paragraphTextLightSmallSemiBold(
                                                  context),
                                        );
                                      }
                                    },
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
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(24, 18, 24, 4),
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
                                  ReactiveRefreshIndicator(
                                      backgroundColor:
                                          StateContainer.of(context)
                                              .curTheme
                                              .backgroundPrimary,
                                      onRefresh: _refresh,
                                      isRefreshing: _isRefreshing,
                                      child: ListView(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 3, 0, 19),
                                        children: _getPlaceholderAccountCards(),
                                      )),
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
                          child: ReactiveRefreshIndicator(
                              backgroundColor: StateContainer.of(context)
                                  .curTheme
                                  .backgroundPrimary,
                              onRefresh: _refresh,
                              isRefreshing: _isRefreshing,
                              child: Center(
                                child: SingleChildScrollView(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height -
                                        (130 +
                                            ((MediaQuery.of(context)
                                                    .padding
                                                    .top) +
                                                (20 -
                                                    (MediaQuery.of(context)
                                                            .padding
                                                            .bottom) /
                                                        2))) -
                                        ((MediaQuery.of(context)
                                                .padding
                                                .bottom) +
                                            (24 -
                                                (MediaQuery.of(context)
                                                        .padding
                                                        .bottom) /
                                                    2)) -
                                        50 -
                                        20,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    30, 0, 30, 0),
                                            child: AutoSizeText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: "Welcome to",
                                                    style: AppStyles.paragraph(
                                                        context),
                                                  ),
                                                  TextSpan(
                                                    text: " Blaise Wallet",
                                                    style: AppStyles
                                                        .paragraphPrimary(
                                                            context),
                                                  ),
                                                  TextSpan(
                                                    text: ".\n",
                                                    style: AppStyles.paragraph(
                                                        context),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "You can start by getting an account.",
                                                    style: AppStyles.paragraph(
                                                        context),
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
                                                asset:
                                                    StateContainer.of(context)
                                                        .curTheme
                                                        .illustrationNewWallet,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.55),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )));
                    } else {
                      // Wallet Cards
                      return Expanded(
                        child: Column(
                          children: <Widget>[
                            // Accounts text
                            Container(
                              margin:
                                  EdgeInsetsDirectional.fromSTEB(24, 18, 24, 4),
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
                                  ReactiveRefreshIndicator(
                                      backgroundColor:
                                          StateContainer.of(context)
                                              .curTheme
                                              .backgroundPrimary,
                                      onRefresh: _refresh,
                                      isRefreshing: _isRefreshing,
                                      child: ListView.builder(
                                          physics:
                                              AlwaysScrollableScrollPhysics(),
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 3, 0, 19),
                                          itemCount:
                                              walletState.walletAccounts.length,
                                          itemBuilder: (context, index) {
                                            return AccountCard(
                                                account: walletState
                                                    .walletAccounts[index]);
                                          })),
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
                  Observer(builder: (BuildContext context) {
                    if (walletState.walletAccounts.length > 0) {
                      return Container(
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
                                  AppSheets.showBottomSheet(
                                      context: context,
                                      widget: GetAccountSheetBetaWithAccounts());
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
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
                                  AppSheets.showBottomSheet(
                                      context: context,
                                      widget: GetAccountSheetBeta());
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getPlaceholderAccountCards() {
    List<Widget> ret = [];
    for (var i = 0; i < 7; i++) {
      ret.add(Opacity(
          opacity: _opacityAnimation.value, child: PlaceholderAccountCard()));
    }
    return ret;
  }
}
