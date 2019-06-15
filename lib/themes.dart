import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color primary;
  Color primary60;
  Color primary50;
  Color primary30;
  Color primary15;
  Color primary10;

  Color secondary;

  Color success;
  Color success30;
  Color success15;
  Color success10;

  Color danger;
  Color danger30;
  Color danger15;

  Color backgroundPrimary;
  Color backgroundPrimary60;
  Color backgroundPrimary30;
  Color backgroundPrimary15;

  Color backgroundSecondary;

  Color shadow;
  Color shadow50;
  Color shadow10;

  Color textDark;
  Color textDark60;
  Color textDark50;
  Color textDark40;
  Color textDark30;
  Color textDark15;
  Color textDark10;

  Color textLight;
  Color textLight30;
  Color textLight15;

  Color overlay20;
  Color overlay15;
  Color overlay10;

  LinearGradient gradientPrimary;

  LinearGradient gradientListTop;

  BoxShadow shadowPrimaryOne;
  BoxShadow shadowPrimaryTwo;

  BoxShadow shadowSuccessOne;
  BoxShadow shadowSuccessTwo;

  BoxShadow shadowDangerOne;
  BoxShadow shadowDangerTwo;

  BoxShadow shadowSucces;

  BoxShadow shadowTextDark;
  BoxShadow shadowTextDarkTwo;

  BoxShadow shadowMainCard;

  BoxShadow shadowAccountCard;

  BoxShadow shadowBottomBar;

  BoxShadow shadowSettingsList;

  String illustrationNewWallet;
  String illustrationBackup;
  String illustrationTwoOptions;
  String illustrationBorrowed;
  String illustrationSecurity;

  String animationWelcome;
  String animationSend;
  String animationNameChange;
  String animationSale;
  String animationTransfer;
  String animationGetAccount;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;
}

class BlaiseLightTheme extends BaseTheme {
  static const Color orange = Color(0xFFF7941F);
  static const Color yellow = Color(0xFFFCC642);
  static const Color teal = Color(0xFF00C5C3);
  static const Color red = Color(0xFFFF6C59);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white00 = Color(0x00FFFFFF);
  static const Color grayDark = Color(0xFF6B6C71);
  static const Color black = Color(0xFF000000);

  Color primary = orange;
  Color primary60 = orange.withOpacity(0.6);
  Color primary50 = orange.withOpacity(0.5);
  Color primary30 = orange.withOpacity(0.3);
  Color primary15 = orange.withOpacity(0.15);
  Color primary10 = orange.withOpacity(0.10);

  Color secondary = yellow;

  Color success = teal;
  Color success30 = teal.withOpacity(0.3);
  Color success15 = teal.withOpacity(0.15);
  Color success10 = teal.withOpacity(0.1);

  Color danger = red;
  Color danger30 = red.withOpacity(0.3);
  Color danger15 = red.withOpacity(0.15);

  Color backgroundPrimary = white;
  Color backgroundPrimary60 = white.withOpacity(0.6);
  Color backgroundPrimary30 = white.withOpacity(0.3);
  Color backgroundPrimary15 = white.withOpacity(0.15);

  Color backgroundSecondary = white;

  Color textDark = grayDark;
  Color textDark60 = grayDark.withOpacity(0.6);
  Color textDark50 = grayDark.withOpacity(0.5);
  Color textDark40 = grayDark.withOpacity(0.4);
  Color textDark30 = grayDark.withOpacity(0.3);
  Color textDark15 = grayDark.withOpacity(0.15);
  Color textDark10 = grayDark.withOpacity(0.1);

  Color shadow = grayDark;
  Color shadow50 = grayDark.withOpacity(0.5);
  Color shadow10 = grayDark.withOpacity(0.1);

  Color textLight = white;
  Color textLight30 = white.withOpacity(0.3);
  Color textLight15 = white.withOpacity(0.15);

  Color overlay20 = black.withOpacity(0.2);
  Color overlay15 = black.withOpacity(0.15);
  Color overlay10 = black.withOpacity(0.10);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [orange, yellow],
  );

  LinearGradient gradientListTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1],
    colors: [white, white00],
  );

  BoxShadow shadowPrimaryOne = BoxShadow(
      color: orange.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowPrimaryTwo = BoxShadow(
      color: orange.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowSuccessOne = BoxShadow(
      color: teal.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccessTwo = BoxShadow(
      color: teal.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccess = BoxShadow(
      color: teal.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDark = BoxShadow(
      color: grayDark.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowTextDarkTwo = BoxShadow(
      color: grayDark.withOpacity(0.25),
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowMainCard = BoxShadow(
      color: grayDark.withOpacity(0.2),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -3.0);

  BoxShadow shadowAccountCard = BoxShadow(
      color: grayDark.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowBottomBar = BoxShadow(
      color: grayDark.withOpacity(0.2),
      offset: Offset(0, -15),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowSettingsList = BoxShadow(
      color: grayDark.withOpacity(0.4),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowDangerOne = BoxShadow(
      color: red.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  BoxShadow shadowDangerTwo = BoxShadow(
      color: red.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  String illustrationNewWallet = 'assets/illustration_new_wallet.svg';
  String illustrationBackup = 'assets/illustration_backup.svg';
  String illustrationTwoOptions = 'assets/illustration_two_options.svg';
  String illustrationBorrowed = 'assets/illustration_borrowed.svg';
  String illustrationSecurity = 'assets/illustration_security.svg';

  String animationWelcome = 'assets/animation_welcome.flr';
  String animationSend = 'assets/animation_send.flr';
  String animationNameChange = 'assets/animation_name_change.flr';
  String animationSale = 'assets/animation_sale.flr';
  String animationTransfer = 'assets/animation_transfer.flr';
  String animationGetAccount = 'assets/animation_get_account.flr';

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
}

class BlaiseDarkTheme extends BaseTheme {
  static const Color teal = Color(0xFF61DEFF);
  static const Color tealLight = Color(0xFFA8FDFF);
  static const Color green = Color(0xFF00FFBF);
  static const Color red = Color(0xFFFF6C59);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white00 = Color(0x00FFFFFF);
  static const Color grayLight = Color(0xFFD7D9E6);
  static const Color grayDark = Color(0xFF3D3F4F);
  static const Color grayDark00 = Color(0x003D3F4F);
  static const Color black = Color(0xFF000000);

  Color primary = teal;
  Color primary60 = teal.withOpacity(0.6);
  Color primary50 = teal.withOpacity(0.5);
  Color primary30 = teal.withOpacity(0.3);
  Color primary15 = teal.withOpacity(0.15);
  Color primary10 = teal.withOpacity(0.10);

  Color secondary = tealLight;

  Color success = green;
  Color success30 = green.withOpacity(0.3);
  Color success15 = green.withOpacity(0.15);
  Color success10 = green.withOpacity(0.1);

  Color danger = red;
  Color danger30 = red.withOpacity(0.3);
  Color danger15 = red.withOpacity(0.15);

  Color backgroundPrimary = grayDark;
  Color backgroundPrimary60 = grayDark.withOpacity(0.6);
  Color backgroundPrimary30 = grayDark.withOpacity(0.3);
  Color backgroundPrimary15 = grayDark.withOpacity(0.15);

  Color backgroundSecondary = grayDark;

  Color textDark = grayLight;
  Color textDark60 = grayLight.withOpacity(0.6);
  Color textDark50 = grayLight.withOpacity(0.5);
  Color textDark40 = grayLight.withOpacity(0.4);
  Color textDark30 = grayLight.withOpacity(0.3);
  Color textDark15 = grayLight.withOpacity(0.15);
  Color textDark10 = grayLight.withOpacity(0.1);

  Color shadow = black;
  Color shadow50 = black.withOpacity(0.5);
  Color shadow10 = black.withOpacity(0.1);

  Color textLight = grayDark;
  Color textLight30 = grayDark.withOpacity(0.3);
  Color textLight15 = grayDark.withOpacity(0.15);

  Color overlay20 = black.withOpacity(0.2);
  Color overlay15 = black.withOpacity(0.15);
  Color overlay10 = black.withOpacity(0.10);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [teal, tealLight],
  );

  LinearGradient gradientListTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1],
    colors: [grayDark, grayDark00],
  );

  BoxShadow shadowPrimaryOne = BoxShadow(
      color: teal.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowPrimaryTwo = BoxShadow(
      color: teal.withOpacity(0.125),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowSuccessOne = BoxShadow(
      color: green.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccessTwo = BoxShadow(
      color: green.withOpacity(0.125),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDark = BoxShadow(
      color: black.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowTextDarkTwo = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowMainCard = BoxShadow(
      color: black.withOpacity(0.2),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -3.0);

  BoxShadow shadowAccountCard = BoxShadow(
      color: black.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowBottomBar = BoxShadow(
      color: black.withOpacity(0.2),
      offset: Offset(0, -15),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowSettingsList = BoxShadow(
      color: black.withOpacity(0.4),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowDangerOne = BoxShadow(
      color: red.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  BoxShadow shadowDangerTwo = BoxShadow(
      color: red.withOpacity(0.125),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  String illustrationNewWallet = 'assets/illustration_new_wallet_dark.svg';
  String illustrationBackup = 'assets/illustration_backup_dark.svg';
  String illustrationTwoOptions = 'assets/illustration_two_options_dark.svg';
  String illustrationBorrowed = 'assets/illustration_borrowed_dark.svg';
  String illustrationSecurity = 'assets/illustration_security_dark.svg';

  String animationWelcome = 'assets/animation_welcome_dark.flr';
  String animationSend = 'assets/animation_send_dark.flr';
  String animationNameChange = 'assets/animation_name_change_dark.flr';
  String animationSale = 'assets/animation_sale_dark.flr';
  String animationTransfer = 'assets/animation_transfer_dark.flr';
  String animationGetAccount = 'assets/animation_get_account_dark.flr';


  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
}