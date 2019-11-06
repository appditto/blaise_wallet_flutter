import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  int themeID;

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

  Color overlay30;
  Color overlay20;
  Color overlay15;
  Color overlay10;

  Color switchKnob;
  Color switchTrack;

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
  String animationSearch;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;
  AppIconEnum appIcon;
  OverlayTheme scannerTheme;

  /// Operator overrides
  bool operator ==(o) => (o != null && o.hashCode == hashCode);
  int get hashCode => themeID.hashCode;
}

class BlaiseLightTheme extends BaseTheme {
  int themeID = 1;

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

  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);
  Color overlay15 = black.withOpacity(0.15);
  Color overlay10 = black.withOpacity(0.10);

  Color switchKnob = white;
  Color switchTrack = black.withOpacity(0.1);

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
      blurRadius: 20,
      spreadRadius: -3.3);

  BoxShadow shadowAccountCard = BoxShadow(
      color: grayDark.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -2.6);

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
  String animationSearch = 'assets/animation_search.flr';

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
  
  AppIconEnum appIcon = AppIconEnum.LIGHT;

  OverlayTheme scannerTheme = OverlayTheme.BLAISE;
}

class BlaiseDarkTheme extends BaseTheme {
  int themeID = 2;

  static const Color blueish = Color(0xFF8287B5);
  static const Color blueish2 = Color(0xFF6F70A8);
  static const Color blueishLight = Color(0xFFACB7D1);
  static const Color green = Color(0xFF7CBFA1);
  static const Color red = Color(0xFFCC7A7A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white00 = Color(0x00FFFFFF);
  static const Color grayLight = Color(0xFFB5B5BF);
  static const Color grayLightish = Color(0xFF2D3136);
  static const Color grayDark = Color(0xFF1C1E21);
  static const Color grayDark00 = Color(0x001C1E21);
  static const Color black = Color(0xFF000000);

  Color primary = blueish;
  Color primary60 = blueish.withOpacity(0.6);
  Color primary50 = blueish.withOpacity(0.5);
  Color primary30 = blueish.withOpacity(0.3);
  Color primary15 = blueish.withOpacity(0.15);
  Color primary10 = blueish.withOpacity(0.10);

  Color secondary = blueishLight;

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

  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);
  Color overlay15 = black.withOpacity(0.15);
  Color overlay10 = black.withOpacity(0.10);

  Color switchKnob = grayLightish;
  Color switchTrack = black.withOpacity(0.3);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [blueish2, blueishLight],
  );

  LinearGradient gradientListTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1],
    colors: [grayDark, grayDark00],
  );

  BoxShadow shadowPrimaryOne = BoxShadow(
      color: blueish.withOpacity(0.1),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowPrimaryTwo = BoxShadow(
      color: blueish.withOpacity(0.05),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowSuccessOne = BoxShadow(
      color: green.withOpacity(0.1),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccessTwo = BoxShadow(
      color: green.withOpacity(0.05),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDark = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowTextDarkTwo = BoxShadow(
      color: black.withOpacity(0.35),
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowMainCard = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 10),
      blurRadius: 20,
      spreadRadius: -3.3);

  BoxShadow shadowAccountCard = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -2.6);

  BoxShadow shadowBottomBar = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, -15),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowSettingsList = BoxShadow(
      color: black.withOpacity(0.5),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowDangerOne = BoxShadow(
      color: red.withOpacity(0.1),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  BoxShadow shadowDangerTwo = BoxShadow(
      color: red.withOpacity(0.05),
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
  String animationSearch = 'assets/animation_search.flr';

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);
  
  AppIconEnum appIcon = AppIconEnum.DARK;

  OverlayTheme scannerTheme = OverlayTheme.BLAISEDARK;
}

class BlaiseCopperTheme extends BaseTheme {
  int themeID = 3;

  static const Color orange = Color(0xFFDD8D52);
  static const Color orange2 = Color(0xFFCB7244);
  static const Color orangeLight = Color(0xFFFFBF6A);
  static const Color blue = Color(0xFF5A73F2);
  static const Color red = Color(0xFFF25A5A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color white00 = Color(0x00FFFFFF);
  static const Color grayLight = Color(0xFFB9BAC4);
  static const Color grayLightish = Color(0xFF585A6F);
  static const Color grayDark = Color(0xFF2B2C37);
  static const Color grayDark00 = Color(0x002B2C37);
  static const Color black = Color(0xFF000000);

  Color primary = orange;
  Color primary60 = orange.withOpacity(0.6);
  Color primary50 = orange.withOpacity(0.5);
  Color primary30 = orange.withOpacity(0.3);
  Color primary15 = orange.withOpacity(0.15);
  Color primary10 = orange.withOpacity(0.10);

  Color secondary = orangeLight;

  Color success = blue;
  Color success30 = blue.withOpacity(0.3);
  Color success15 = blue.withOpacity(0.15);
  Color success10 = blue.withOpacity(0.1);

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

  Color overlay30 = black.withOpacity(0.3);
  Color overlay20 = black.withOpacity(0.2);
  Color overlay15 = black.withOpacity(0.15);
  Color overlay10 = black.withOpacity(0.10);

  Color switchKnob = grayLightish;
  Color switchTrack = black.withOpacity(0.3);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [orange2, orangeLight],
  );

  LinearGradient gradientListTop = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 1],
    colors: [grayDark, grayDark00],
  );

  BoxShadow shadowPrimaryOne = BoxShadow(
      color: orange.withOpacity(0.1),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowPrimaryTwo = BoxShadow(
      color: orange.withOpacity(0.05),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowSuccessOne = BoxShadow(
      color: blue.withOpacity(0.1),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccessTwo = BoxShadow(
      color: blue.withOpacity(0.05),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDark = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowTextDarkTwo = BoxShadow(
      color: black.withOpacity(0.35),
      offset: Offset(0, 12),
      blurRadius: 24,
      spreadRadius: -4.0);

  BoxShadow shadowMainCard = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 10),
      blurRadius: 20,
      spreadRadius: -3.3);

  BoxShadow shadowAccountCard = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -2.6);

  BoxShadow shadowBottomBar = BoxShadow(
      color: black.withOpacity(0.25),
      offset: Offset(0, -15),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowSettingsList = BoxShadow(
      color: black.withOpacity(0.5),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -5.0);

  BoxShadow shadowDangerOne = BoxShadow(
      color: red.withOpacity(0.1),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  BoxShadow shadowDangerTwo = BoxShadow(
      color: red.withOpacity(0.05),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  String illustrationNewWallet = 'assets/illustration_new_wallet_copper.svg';
  String illustrationBackup = 'assets/illustration_backup_copper.svg';
  String illustrationTwoOptions = 'assets/illustration_two_options_copper.svg';
  String illustrationBorrowed = 'assets/illustration_borrowed_copper.svg';
  String illustrationSecurity = 'assets/illustration_security_copper.svg';

  String animationWelcome = 'assets/animation_welcome_copper.flr';
  String animationSend = 'assets/animation_send_copper.flr';
  String animationNameChange = 'assets/animation_name_change_copper.flr';
  String animationSale = 'assets/animation_sale_copper.flr';
  String animationTransfer = 'assets/animation_transfer_copper.flr';
  String animationGetAccount = 'assets/animation_get_account_copper.flr';
  String animationSearch = 'assets/animation_search.flr';

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent);

  AppIconEnum appIcon = AppIconEnum.COPPER;

  OverlayTheme scannerTheme = OverlayTheme.COPPER;
}

enum AppIconEnum { LIGHT, DARK, COPPER }
class AppIcon {
  static const _channel = const MethodChannel('fappchannel');

  static Future<void> setAppIcon(AppIconEnum iconToChange) async {
    if (!Platform.isIOS) {
      return null;
    }
    String iconStr = "Light";
    switch (iconToChange) {
      case AppIconEnum.DARK:
        iconStr = "Dark";
        break;
      case AppIconEnum.COPPER:
        iconStr = "Copper";
        break;
      case AppIconEnum.LIGHT:
      default:
        iconStr = "Light";
        break;
    }
    final Map<String, dynamic> params = <String, dynamic>{
     'icon': iconStr,
    };
    return await _channel.invokeMethod('changeIcon', params);
  }
}