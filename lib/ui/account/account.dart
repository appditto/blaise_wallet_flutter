import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/account/account.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/change_name/change_name_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/delist_for_sale/delisting_for_sale.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/list_for_sale/list_for_sale_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/private_sale/create_private_sale_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/other_operations/transfer_account/transfer_account_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/receive/receive_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/send/send_sheet.dart';
import 'package:blaise_wallet_flutter/ui/account/operation_sheet.dart';
import 'package:blaise_wallet_flutter/ui/settings/settings.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_drawer.dart';
import 'package:blaise_wallet_flutter/ui/widgets/app_scaffold.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/operation_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:blaise_wallet_flutter/ui/widgets/placeholder_operation_list_item.dart';
import 'package:blaise_wallet_flutter/ui/widgets/reactive_refresh.dart';
import 'package:blaise_wallet_flutter/ui/widgets/sheets.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:blaise_wallet_flutter/util/haptic_util.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:logger/logger.dart';
import 'package:pascaldart/pascaldart.dart';

class AccountPage extends StatefulWidget {
  final PascalAccount account;

  AccountPage({@required this.account});
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final Logger log = sl.get<Logger>();

  GlobalKey<AppScaffoldState> _scaffoldKey = GlobalKey<AppScaffoldState>();
  Account accountState;
  // Opacity Animation
  Animation<double> _opacityAnimation;
  AnimationController _opacityAnimationController;

  // Refresh indicator
  bool _isRefreshing;

  // Reference to contacts list
  List<Contact> _contacts;

  // Last refresh
  DateTime _lastRefresh;

  // Account price
  String accountPrice = "0.25";

  // Borrowed account expiration
  String untilExpirationDays = "";
  String untilExpirationHours = "";
  String untilExpirationMinutes = "";

  void formatExpiryDate(DateTime expiry) {
    if (expiry != null) {
      DateTime now = DateTime.now().toUtc();
      int diffS = expiry.difference(now).inSeconds;
      if (diffS <= 60) {
        // Seconds only
        untilExpirationDays = "0";
        untilExpirationHours = "0";
        untilExpirationMinutes = "0";
      } else if (diffS <= 3600) {
        // Minutes
        String minutesStr = "";
        int minutes = diffS ~/ 60;
        minutesStr = minutes.toString();
        untilExpirationDays = "0";
        untilExpirationHours = "0";
        untilExpirationMinutes = minutesStr;
      } else if (diffS <= 86400) {
        // Hours:Minutes
        String hoursStr = "";
        int hours = diffS ~/ 3600;
        hoursStr = hours.toString();
        diffS = diffS % 3600;
        String minutesStr = "";
        int minutes = diffS ~/ 60;
        minutesStr = minutes.toString();
        untilExpirationDays = "0";
        untilExpirationHours = hoursStr;
        untilExpirationMinutes = minutesStr;
      } else {
        // Days:Hours:Minutes
        String daysStr = "";
        int days = diffS ~/ 86400;
        daysStr = days.toString();
        diffS = diffS % 86400;
        String hoursStr = "";
        int hours = diffS ~/ 3600;
        hoursStr = hours.toString();
        diffS = diffS % 3600;
        String minutesStr = "";
        int minutes = diffS ~/ 60;
        minutesStr = minutes.toString();
        untilExpirationDays = daysStr;
        untilExpirationHours = hoursStr;
        untilExpirationMinutes = minutesStr;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isRefreshing = false;
    _registerBus();
    this.accountState = walletState.getAccountState(widget.account);
    this.accountState.updateAccount();
    if (!this.accountState.account.isBorrowed) {
      this.accountState.getAccountOperations();
    }
    walletState.activeAccount = widget.account.account;
    // Opacity Animation
    _opacityAnimationController = new AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = new Tween(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(
        parent: _opacityAnimationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );
    _startAnimation();
    // Contacts
    _updateContacts();
    // Subscribe for updates
    walletState.requestUpdate();
    // Update FCM token
    if (!this.accountState.account.isBorrowed) {
      walletState.fcmUpdate(widget.account.account);
    }
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
    if (accountState.operationsLoading ||
        accountState.operationsToDisplay == null) {
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
    walletState.activeAccount = null;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        // Do an auto-refresh
        if (_lastRefresh == null ||
            DateTime.now().toUtc().difference(_lastRefresh).inSeconds > 300) {
          _refresh(socketUpdate: false);
        }
        walletState.requestUpdate();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  void _startAnimation() {
    _opacityAnimationController.addListener(_animationControllerListener);
    _opacityAnimation.addStatusListener(_animationStatusListener);
    _opacityAnimationController.forward();
  }

  Future<void> _updateContacts() async {
    List<Contact> contacts = await sl.get<DBHelper>().getContacts();
    if (mounted) {
      setState(() {
        _contacts = contacts;
      });
    }
  }

  List<DialogListItem> getOperationsList() {
    return [
      DialogListItem(
        option: AppLocalization.of(context).changeAccountNameHeader,
        action: () {
          Navigator.of(context).pop();
          AppSheets.showBottomSheet(
              context: context,
              widget: ChangeNameSheet(account: accountState.account));
        },
      ),
      DialogListItem(
        option: AppLocalization.of(context).transferAccountHeader,
        action: () {
          Navigator.of(context).pop();
          AppSheets.showBottomSheet(
              context: context,
              widget: TransferAccountSheet(
                account: accountState.account,
              ));
        },
      ),
      DialogListItem(
          option: AppLocalization.of(context).listAccountForSaleHeader,
          action: () {
            Navigator.of(context).pop();
            AppSheets.showBottomSheet(
                context: context,
                widget: ListForSaleSheet(account: accountState.account));
          },
          disabled: accountState == null ||
              accountState.account.state == AccountState.LISTED),
      DialogListItem(
          option: AppLocalization.of(context).createPrivateSaleHeader,
          action: () {
            Navigator.of(context).pop();
            AppSheets.showBottomSheet(
                context: context,
                widget: CreatePrivateSaleSheet(account: accountState.account));
          },
          disabled: accountState == null ||
              accountState.account.state == AccountState.LISTED),
      DialogListItem(
          option: AppLocalization.of(context).delistFromSaleHeader,
          action: () {
            Navigator.of(context).pop();
            AppSheets.showBottomSheet(
                context: context,
                widget: DelistingForSaleSheet(
                  account: accountState.account,
                  fee: walletState.shouldHaveFee()
                      ? walletState.MIN_FEE
                      : walletState.NO_FEE,
                ));
          },
          disabled: accountState == null ||
              accountState.account.state != AccountState.LISTED),
    ];
  }

  StreamSubscription<UpdateHistoryEvent> _historySub;
  StreamSubscription<ContactModifiedEvent> _contactModifiedSub;

  void _registerBus() {
    _historySub = EventTaxiImpl.singleton()
        .registerTo<UpdateHistoryEvent>()
        .listen((event) {
      walletState.loadWallet();
    });
    _contactModifiedSub = EventTaxiImpl.singleton()
        .registerTo<ContactModifiedEvent>()
        .listen((event) {
      _updateContacts();
    });
  }

  void _destroyBus() {
    if (_historySub != null) {
      _historySub.cancel();
    }
    if (_contactModifiedSub != null) {
      _contactModifiedSub.cancel();
    }
  }

  // Refresh list
  Future<void> _refresh({bool socketUpdate = true}) async {
    _lastRefresh = DateTime.now().toUtc();
    setState(() {
      _isRefreshing = true;
    });
    HapticUtil.success();
    // Hide refresh indicator after 3 seconds if no server response
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    });
    if (socketUpdate) {
      walletState.requestUpdate();
    }
    if (!widget.account.isBorrowed) {
      this.accountState?.updateAccount();
      this.accountState?.getAccountOperations()?.whenComplete(() {
        if (mounted) {
          setState(() {
            _isRefreshing = false;
          });
        }
      });
    } else {
      this.accountState?.updateAccount()?.whenComplete(() {
        if (mounted) {
          if (this.accountState.account.isBorrowed) {
            setState(() {
              _isRefreshing = false;
            });
          } else {
            walletState.updateBorrowed().then((_) {
              if (mounted) {
                setState(() {
                  _isRefreshing = false;
                });
                if (walletState.borrowedAccount == null) {
                  walletState.loadWallet();
                  Navigator.of(context).pushReplacementNamed('/account',
                      arguments: this.accountState.account);
                }
              }
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // The main scaffold that holds everything
    return AppScaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      endDrawer: SizedBox(
          width: double.infinity,
          child: AppDrawer(child: SettingsPage(account: accountState))),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: widget.account.isBorrowed
                                  ? () {
                                      return null;
                                    }
                                  : () {
                                      showAppDialog(
                                          context: context,
                                          builder: (_) => DialogOverlay(
                                              title: AppLocalization.of(context)
                                                  .otherOperationsHeader,
                                              optionsList:
                                                  getOperationsList()));
                                    },
                              highlightColor: StateContainer.of(context)
                                  .curTheme
                                  .textLight15,
                              splashColor: StateContainer.of(context)
                                  .curTheme
                                  .textLight30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  // Back icon and price text
                                  Container(
                                    height: 130,
                                    width: 60,
                                    alignment: Alignment(-1, 0),
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
                                                Navigator.of(context).pop();
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      end: 10),
                                              child: Icon(AppIcons.back,
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .textLight,
                                                  size: 22)),
                                        ),
                                        // Price text
                                        Observer(
                                            builder: (BuildContext context) {
                                          if (walletState.localCurrencyPrice ==
                                              null) {
                                            return Opacity(
                                              opacity: _opacityAnimation.value,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .textLight
                                                          .withOpacity(0.75),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
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
                                            return Container(
                                              margin:
                                                  EdgeInsetsDirectional.only(
                                                      start: 16, bottom: 12),
                                              child: AutoSizeText(
                                                walletState
                                                    .getLocalCurrencyDisplay(
                                                        currency:
                                                            StateContainer.of(
                                                                    context)
                                                                .curCurrency,
                                                        amount: Currency('1'),
                                                        decimalDigits: 3),
                                                maxLines: 1,
                                                stepGranularity: 0.1,
                                                minFontSize: 8,
                                                textAlign: TextAlign.start,
                                                style: AppStyles
                                                    .paragraphTextLightSmallSemiBold(
                                                        context),
                                              ),
                                            );
                                          }
                                        })
                                      ],
                                    ),
                                  ),
                                  // Column for balance texts
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      // Container for "TOTAL BALANCE" text
                                      Container(
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 12, 0),
                                        child: AutoSizeText(
                                          toUppercase(AppLocalization.of(context)
                                              .accountBalanceHeader
                                              ,context),
                                          style:
                                              AppStyles.paragraphTextLightSmall(
                                                  context),
                                        ),
                                      ),
                                      // Container for the balance
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                168,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12, 4, 12, 4),
                                        child: Observer(
                                          builder: (BuildContext context) {
                                            Currency bal =
                                                accountState.accountBalance;
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
                                                      text: bal.toStringOpt(),
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
                                      Observer(
                                        builder: (BuildContext context) {
                                          if (walletState.localCurrencyPrice ==
                                              null) {
                                            return Opacity(
                                              opacity: _opacityAnimation.value,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .textLight
                                                          .withOpacity(0.75),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
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
                                            return Container(
                                              margin: EdgeInsetsDirectional
                                                  .fromSTEB(12, 0, 12, 0),
                                              child: AutoSizeText(
                                                "(${walletState.getLocalCurrencyDisplay(currency: StateContainer.of(context).curCurrency, amount: accountState.accountBalance)})",
                                                style: AppStyles
                                                    .paragraphTextLightSmall(
                                                        context),
                                              ),
                                            );
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                  // Column for settings icon and other operations icon
                                  Container(
                                    width: 60,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
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
                                            child: !widget.account.isBorrowed
                                                ? FlatButton(
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
                                                              title: AppLocalization
                                                                      .of(
                                                                          context)
                                                                  .otherOperationsHeader,
                                                              optionsList:
                                                                  getOperationsList()));
                                                    },
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50.0)),
                                                    padding:
                                                        EdgeInsetsDirectional.only(
                                                            start: 8, top: 6),
                                                    child: Icon(AppIcons.edit,
                                                        color:
                                                            StateContainer.of(
                                                                    context)
                                                                .curTheme
                                                                .textLight,
                                                        size: 18))
                                                : SizedBox()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget.account.isBorrowed
                      ? // Paragraph and illustration
                      Expanded(
                          child: ReactiveRefreshIndicator(
                              backgroundColor: StateContainer.of(context)
                                  .curTheme
                                  .backgroundPrimary,
                              onRefresh: _refresh,
                              isRefreshing: _isRefreshing,
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                //Container for the paragraph
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      margin: EdgeInsetsDirectional
                                          .fromSTEB(30, 0, 30, 0),
                                      child: Observer(
                                        builder: (context) {
                                          String msgStr = "";
                                          List<TextSpan> msg;
                                          if ((walletState
                                                      .borrowedAccount !=
                                                  null &&
                                              walletState
                                                  .borrowedAccount
                                                  .paid) || accountState.paid) {
                                            msgStr = AppLocalization.of(
                                                    context)
                                                .borrowedAccountPaidParagraph;
                                            msg = formatLocalizedColors(
                                                context, msgStr);
                                          } else {
                                            formatExpiryDate(walletState
                                                .borrowedAccount
                                                ?.expiry);
                                            msgStr = AppLocalization.of(
                                                    context)
                                                .borrowedAccountParagraph
                                                .replaceAll("%1",
                                                    accountPrice)
                                                .replaceAll("%2",
                                                    untilExpirationDays)
                                                .replaceAll("%3",
                                                    untilExpirationHours)
                                                .replaceAll('%4',
                                                    untilExpirationMinutes);
                                            msg = formatLocalizedColors(
                                                context, msgStr);
                                          }
                                          return AutoSizeText.rich(
                                            TextSpan(children: msg),
                                            stepGranularity: 0.5,
                                            maxLines: 10,
                                            minFontSize: 8,
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(fontSize: 14),
                                          );
                                        },
                                      )),
                                  // Container for the illustration
                                  Container(
                                    margin: EdgeInsetsDirectional.only(
                                      top: 24,
                                      bottom: 24,
                                    ),
                                    child: SvgRepaintAsset(
                                        asset:
                                            StateContainer.of(context)
                                                .curTheme
                                                .illustrationBorrowed,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.8,
                                        height: MediaQuery.of(context)
                                                .size
                                                .width *
                                            0.8 *
                                            132 /
                                            295),
                                  ),
                                ],
                              ),
                                ),
                              )))
                      :
                      // Wallet Cards
                      Expanded(
                          child: widget.account.isBorrowed
                              ? SizedBox()
                              : Column(
                                  children: <Widget>[
                                    // Accounts text
                                    Container(
                                      margin: EdgeInsetsDirectional.fromSTEB(
                                          24, 18, 24, 4),
                                      alignment: Alignment(-1, 0),
                                      child: AutoSizeText(
                                        toUppercase(AppLocalization.of(context)
                                            .operationsHeader
                                            ,context),
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
                                        child: Observer(
                                          builder: (BuildContext context) {
                                            if (accountState
                                                    .operationsLoading ||
                                                accountState.operations ==
                                                    null) {
                                              return ReactiveRefreshIndicator(
                                                  backgroundColor:
                                                      StateContainer.of(context)
                                                          .curTheme
                                                          .backgroundPrimary,
                                                  onRefresh: _refresh,
                                                  isRefreshing: _isRefreshing,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12)),
                                                      child: Opacity(
                                                        opacity:
                                                            _opacityAnimation
                                                                .value,
                                                        child: ListView(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        bottom:
                                                                            24),
                                                            children: [
                                                              PlaceholderOperationListItem(
                                                                  type: PlaceholderOperationType
                                                                      .Received),
                                                              PlaceholderOperationListItem(
                                                                  type:
                                                                      PlaceholderOperationType
                                                                          .Sent),
                                                              PlaceholderOperationListItem(
                                                                  type: PlaceholderOperationType
                                                                      .Received),
                                                              PlaceholderOperationListItem(
                                                                  type: PlaceholderOperationType
                                                                      .Received),
                                                              PlaceholderOperationListItem(
                                                                  type:
                                                                      PlaceholderOperationType
                                                                          .Sent),
                                                              PlaceholderOperationListItem(
                                                                  type:
                                                                      PlaceholderOperationType
                                                                          .Sent),
                                                              PlaceholderOperationListItem(
                                                                  type: PlaceholderOperationType
                                                                      .Received),
                                                              PlaceholderOperationListItem(
                                                                  type:
                                                                      PlaceholderOperationType
                                                                          .Sent),
                                                            ]),
                                                      )));
                                            } else {
                                              return ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12)),
                                                child: ReactiveRefreshIndicator(
                                                    backgroundColor:
                                                        StateContainer.of(
                                                                context)
                                                            .curTheme
                                                            .backgroundPrimary,
                                                    onRefresh: _refresh,
                                                    isRefreshing: _isRefreshing,
                                                    child: accountState
                                                            .hasOperationsToDisplay()
                                                        ? ListView.builder(
                                                            physics:
                                                                AlwaysScrollableScrollPhysics(),
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        bottom:
                                                                            24),
                                                            itemCount: accountState
                                                                .operationsToDisplay
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return _buildAccountHistoryItem(
                                                                  accountState
                                                                          .operationsToDisplay[
                                                                      index]);
                                                            })
                                                        : ListView(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .only(
                                                                        bottom:
                                                                            24),
                                                            children:
                                                                getPlaceholderCards(),
                                                          )),
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
                          StateContainer.of(context).curTheme.shadowBottomBar,
                        ],
                      ),
                      child: Container(
                        margin: EdgeInsetsDirectional.only(top: 4),
                        child: Row(
                          children: <Widget>[
                            Observer(
                              builder: (BuildContext context) {
                                PascalAccount account = accountState.account;
                                return AppButton(
                                  text:
                                      AppLocalization.of(context).receiveButton,
                                  type: AppButtonType.PrimaryLeft,
                                  onPressed: () {
                                    AppSheets.showBottomSheet(
                                        context: context,
                                        widget: ReceiveSheet(
                                          accountName: account.name.accountName,
                                          accountNumber: account.account,
                                        ));
                                  },
                                );
                              },
                            ),
                            Observer(
                              builder: (BuildContext context) {
                                return AppButton(
                                  text: AppLocalization.of(context).sendButton,
                                  type: AppButtonType.PrimaryRight,
                                  disabled: accountState.accountBalance >
                                          Currency('0')
                                      ? false || widget.account.isBorrowed
                                      : true,
                                  onPressed: () {
                                    AppSheets.showBottomSheet(
                                      context: context,
                                      widget: SendSheet(
                                          account: accountState.account,
                                          localCurrency: StateContainer.of(context).curCurrency),
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

  Widget _buildAccountHistoryItem(PascalOperation op) {
    if (op.optype == OpType.TRANSACTION) {
      OperationType type;
      if (op.senders[0].sendingAccount == accountState.account.account) {
        type = OperationType.Sent;
      } else {
        type = OperationType.Received;
      }
      AccountNumber accountToCheck = type == OperationType.Received
          ? op.senders[0].sendingAccount
          : op.receivers[0].receivingAccount;
      List<Contact> contacts =
          _contacts.where((c) => c.account == accountToCheck).toList();
      Contact c;
      if (contacts.length > 0) {
        c = contacts[0];
      }
      return OperationListItem(
        type: type,
        amount: op.receivers[0].amount.toStringOpt(),
        address: c == null ? accountToCheck.toString() : c.name,
        isContact: c != null,
        date: op.maturation != null
            ? UIUtil.formatDateStr(op.time)
            : AppLocalization.of(context).pendingHeader,
        payload: op.receivers[0].payload,
        onPressed: () {
          AppSheets.showBottomSheet(
              context: context,
              animationDurationMs: 200,
              widget: OperationSheet(
                payload: op.receivers[0].payload,
                ophash: op.ophash,
                operation: op,
                isContact: c != null,
                account: type == OperationType.Received
                    ? op.senders[0].sendingAccount
                    : op.receivers[0].receivingAccount,
              ));
        },
      );
    } else if (op.optype == OpType.CHANGE_ACCOUNT_INFO) {
      // Only show change name
      if (op.changers[0].newName != null) {
        return OperationListItem(
          type: OperationType.NameChanged,
          address: op.changers[0].changingAccount.toString(),
          date: op.maturation != null
              ? UIUtil.formatDateStr(op.time)
              : AppLocalization.of(context).pendingHeader,
          payload: "",
          name: op.changers[0].newName.toString(),
          onPressed: () {
            AppSheets.showBottomSheet(
                context: context,
                animationDurationMs: 200,
                widget: OperationSheet(
                  payload: "",
                  ophash: op.ophash,
                  operation: op,
                  account: op.changers[0].changingAccount,
                ));
          },
        );
      }
    } else if (op.optype == OpType.LIST_FORSALE) {
      return OperationListItem(
        type: OperationType.ListedForSale,
        address: op.changers[0].sellerAccount.toString(),
        date: op.maturation != null
            ? UIUtil.formatDateStr(op.time)
            : AppLocalization.of(context).pendingHeader,
        payload: "",
        price: op.changers[0].accountPrice.toStringOpt(),
        onPressed: () {
          AppSheets.showBottomSheet(
              context: context,
              animationDurationMs: 200,
              widget: OperationSheet(
                payload: "",
                ophash: op.ophash,
                operation: op,
                account: op.changers[0].sellerAccount,
              ));
        },
      );
    } else if (op.optype == OpType.DELIST_FORSALE) {
      return OperationListItem(
        type: OperationType.DelistedForSale,
        address: op.signerAccount.toString(),
        date: op.maturation != null
            ? UIUtil.formatDateStr(op.time)
            : AppLocalization.of(context).pendingHeader,
        payload: "",
        onPressed: () {
          AppSheets.showBottomSheet(
              context: context,
              animationDurationMs: 200,
              widget: OperationSheet(
                payload: "",
                ophash: op.ophash,
                operation: op,
                account: op.signerAccount,
              ));
        },
      );
    }
    return SizedBox();
  }

  List<Widget> getPlaceholderCards() {
    List<Widget> history = [];
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
    return history;
  }
}
