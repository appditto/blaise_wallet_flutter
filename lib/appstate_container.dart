import 'dart:async';

import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/model/available_currency.dart';
import 'package:blaise_wallet_flutter/model/available_languages.dart';
import 'package:blaise_wallet_flutter/model/available_themes.dart';
import 'package:blaise_wallet_flutter/model/db/appdb.dart';
import 'package:blaise_wallet_flutter/model/db/contact.dart';
import 'package:blaise_wallet_flutter/network/model/request/subscribe_request.dart';
import 'package:blaise_wallet_flutter/network/model/response/subscribe_response.dart';
import 'package:blaise_wallet_flutter/network/ws_client.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/store/wallet/wallet.dart';
import 'package:blaise_wallet_flutter/themes.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pascaldart/pascaldart.dart';

final Wallet walletState = Wallet();

const List<String> PREACHED_SVG_ASSETS = [
  'assets/illustration_backup.svg',
  'assets/illustration_backup_dark.svg',
  'assets/illustration_new_wallet.svg',
  'assets/illustration_new_wallet_dark.svg',
  'assets/illustration_security.svg',
  'assets/illustration_security_dark.svg',
  'assets/illustration_two_options.svg',
  'assets/illustration_two_options_dark.svg',
  'assets/illustration_borrowed.svg',
  'assets/illustration_borrowed_dark.svg',
];

class _InheritedStateContainer extends InheritedWidget {
  // Data is your entire state. In our case just 'User'
  final StateContainerState data;

  // You must pass through a child and your state.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;

  StateContainer({@required this.child});

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  StateContainerState createState() => StateContainerState();
}

/// App InheritedWidget
/// This is where we handle the global state and also where
/// we interact with the server and make requests/handle+propagate responses
///
/// Basically the central hub behind the entire app
class StateContainerState extends State<StateContainer> {
  // Theme
  BaseTheme curTheme = BlaiseLightTheme();

  // Language
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);

  // Currency
  String currencyLocale;
  Locale deviceLocale = Locale('en', 'US');
  AvailableCurrency curCurrency = AvailableCurrency(AvailableCurrencyEnum.USD);

  // Helper FN to precache SVG assets for performance
  Future<void> _precacheSvgs() async {
    PREACHED_SVG_ASSETS.forEach((asset) {
      precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoder, asset), context);
    });
  }

  // Change language
  void updateLanguage(LanguageSetting language) {
    setState(() {
      curLanguage = language;
    });
  }

  // Change the theme
  Future<void> updateTheme(ThemeSetting theme, {bool setIcon = true}) async {
    if (theme != null && theme.getTheme() != curTheme) {
      if (mounted) {
        setState(() {
          this.curTheme = theme.getTheme();
        });
      }
      await sl.get<SharedPrefsUtil>().setTheme(theme);
    }
    if (setIcon) {
      AppIcon.setAppIcon(theme.getTheme().appIcon);
    }
  }

  /// Add donations contact if it hasnt already been added
  Future<void> _addSampleContact() async {
    bool contactAdded = await sl.get<SharedPrefsUtil>().getFirstContactAdded();
    if (!contactAdded) {
      bool addressExists = await sl.get<DBHelper>().contactExistsWithAccount(
          AccountNumber.fromInt(1185729));
      if (addressExists) {
        return;
      }
      bool nameExists = await sl.get<DBHelper>().contactExistsWithName("BlaiseDonations");
      if (nameExists) {
        return;
      }
      await sl.get<SharedPrefsUtil>().setFirstContactAdded(true);
      Contact c = Contact(
          name: "BlaiseDonations",
          account:
              AccountNumber.fromInt(1185729),
          payload: "Thanks!");
      await sl.get<DBHelper>().saveContact(c);
    }
  }

  StreamSubscription<ConnStatusEvent> _connStatusSub;
  StreamSubscription<SubscribeEvent> _subscribeEventSub;
  StreamSubscription<PriceEvent> _priceEventSub;
  StreamSubscription<NewOperationEvent> _newOpSub;

  // Register RX event listenerss
  void _registerBus() {
    _subscribeEventSub = EventTaxiImpl.singleton().registerTo<SubscribeEvent>().listen((event) {
      handleSubscribeResponse(event.response);
    });
    _priceEventSub = EventTaxiImpl.singleton().registerTo<PriceEvent>().listen((event) {
      // PriceResponse's get pushed periodically, it wasn't a request we made so don't pop the queue
      walletState.btcPrice = event.response.btcPrice;
      walletState.localCurrencyPrice = event.response.price;
    });
    _connStatusSub = EventTaxiImpl.singleton().registerTo<ConnStatusEvent>().listen((event) {
      if (event.status == ConnectionStatus.CONNECTED) {
        walletState.requestUpdate();
      } else if (event.status == ConnectionStatus.DISCONNECTED && !sl.get<WSClient>().suspended) {
        sl.get<WSClient>().initCommunication();
      }
    });
    _newOpSub = EventTaxiImpl.singleton().registerTo<NewOperationEvent>().listen((event) {
      walletState.addNewOp(event.operation);
    });
  }

  void _destroyBus() {
    if (_connStatusSub != null) {
      _connStatusSub.cancel();
    }
    if (_subscribeEventSub != null) {
      _subscribeEventSub.cancel();
    }
    if (_priceEventSub != null) {
      _priceEventSub.cancel();
    }
    if (_newOpSub != null) {
      _newOpSub.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _registerBus();
    // Precache SVG Assets
    _precacheSvgs();
    // Set initial theme
    sl.get<SharedPrefsUtil>().getTheme().then((themeSetting) {
      updateTheme(themeSetting, setIcon: false);
    });
    // Add initial contact if not already present
    _addSampleContact();
    // Set currency locale here for the UI to access
    sl.get<SharedPrefsUtil>().getCurrency(deviceLocale).then((currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    // Get default language setting
    sl.get<SharedPrefsUtil>().getLanguage().then((language) {
      setState(() {
        curLanguage = language;
      });
    });
  }

  @override
  void dispose() {
    _destroyBus();
    super.dispose();
  }

  /// Handle account_subscribe response
  void handleSubscribeResponse(SubscribeResponse response) {
    // Set currency locale here for the UI to access
    sl.get<SharedPrefsUtil>().getCurrency(deviceLocale).then((currency) {
      setState(() {
        currencyLocale = currency.getLocale().toString();
        curCurrency = currency;
      });
    });
    // Server gives us a UUID for future requests on subscribe
    if (response.uuid != null) {
      sl.get<SharedPrefsUtil>().setUuid(response.uuid);
    }
    walletState.localCurrencyPrice = response.price;
    walletState.btcPrice = response.btcPrice;
    walletState.hasExceededBorrowLimit = !response.borrowEligible;
    walletState.hasReceivedSubscribeResponse = true;
    sl.get<WSClient>().pop();
    sl.get<WSClient>().processQueue();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}
