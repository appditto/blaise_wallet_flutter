import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/service_locator.dart';
import 'package:blaise_wallet_flutter/ui/account/account.dart';
import 'package:blaise_wallet_flutter/ui/overview/overview.dart';
import 'package:blaise_wallet_flutter/ui/intro/intro_backup_confirm.dart';
import 'package:blaise_wallet_flutter/ui/intro/intro_decrypt_and_import_private_key.dart';
import 'package:blaise_wallet_flutter/ui/intro/intro_import_private_key.dart';
import 'package:blaise_wallet_flutter/ui/intro/intro_new_private_key.dart';
import 'package:blaise_wallet_flutter/ui/settings/contacts/contacts.dart';
import 'package:blaise_wallet_flutter/ui/settings/security.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/intro/intro_welcome.dart';
import 'package:blaise_wallet_flutter/util/sharedprefs_util.dart';
import 'package:blaise_wallet_flutter/util/vault.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

void main() async {
  // Register services
  setupServiceLocator();
  // Run app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(StateContainer(child: App()));
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}


class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(StateContainer.of(context).curTheme.statusBar);
    return OKToast(
      textStyle: AppStyles.snackbar(context),
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blaise',
        theme: ThemeData(
          dialogBackgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
          primaryColor: StateContainer.of(context).curTheme.primary,
          accentColor: StateContainer.of(context).curTheme.primary,
          backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
          fontFamily: 'Metropolis',
          brightness: StateContainer.of(context).curTheme.brightness,
          splashColor: StateContainer.of(context).curTheme.primary30,
          highlightColor: StateContainer.of(context).curTheme.primary15,
        ),
        localizationsDelegates: [
          AppLocalizationsDelegate(StateContainer.of(context).curLanguage),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(
                builder: (_) => Splash(),
                settings: settings,
              );
            case '/intro_welcome':
              return MaterialPageRoute(
                builder: (_) => IntroWelcomePage(),
                settings: settings,
              );
            case '/intro_new_private_key':
              return MaterialPageRoute(
                builder: (_) => IntroNewPrivateKeyPage(),
                settings: settings,
              );
            case '/intro_backup_confirm':
              return MaterialPageRoute(
                builder: (_) => IntroBackupConfirmPage(),
                settings: settings,
              );
            case '/intro_import_private_key':
              return MaterialPageRoute(
                builder: (_) => IntroImportPrivateKeyPage(),
                settings: settings,
              );
            case '/intro_decrypt_and_import_private_key':
              return MaterialPageRoute(
                builder: (_) => IntroDecryptAndImportPrivateKeyPage(),
                settings: settings,
              );
            case '/overview_new':
              return MaterialPageRoute(
                builder: (_) => OverviewPage(),
                settings: settings,
              );
            case '/overview':
              return MaterialPageRoute(
                builder: (_) => OverviewPage(newWallet: false,),
                settings: settings,
              );
            case '/account':
              return MaterialPageRoute(
                builder: (_) => AccountPage(),
                settings: settings,
              );
            case '/security':
              return MaterialPageRoute(
                builder: (_) => SecurityPage(),
                settings: settings,
              );
            case '/contacts':
              return MaterialPageRoute(
                builder: (_) => ContactsPage(),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}

/// Splash
/// Default page route that determines if user is logged in and routes them appropriately.
class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> with WidgetsBindingObserver {
  bool _hasCheckedLoggedIn;
  Future checkLoggedIn() async {
    if (!_hasCheckedLoggedIn) {
      if (await sl.get<SharedPrefsUtil>().getFirstLaunch()) {
        await sl.get<SharedPrefsUtil>().deleteAll(firstLaunch: true);
        await sl.get<Vault>().deleteAll();
        await sl.get<SharedPrefsUtil>().setFirstLaunch();
      }
      _hasCheckedLoggedIn = true;
      Navigator.of(context).pushReplacementNamed('/intro_welcome');
    }
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasCheckedLoggedIn = false;
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
          SchedulerBinding.instance.addPostFrameCallback((_) => checkLoggedIn());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Account for user changing locale when leaving the app
    switch (state) {
      case AppLifecycleState.paused:
        super.didChangeAppLifecycleState(state);
        break;
      case AppLifecycleState.resumed:
        setLanguage();
        super.didChangeAppLifecycleState(state);
        break;
      default:
        super.didChangeAppLifecycleState(state);
        break;
    }
  }

  void setLanguage() {
    /*
    setState(() {
      StateContainer.of(context).deviceLocale = Localizations.localeOf(context);
    });
    sl.get<SharedPrefsUtil>().getLanguage().then((setting) {
      setState(() {
        StateContainer.of(context).updateLanguage(setting);
      });
    });*/    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StateContainer.of(context).curTheme.backgroundPrimary,
    );
  }
}