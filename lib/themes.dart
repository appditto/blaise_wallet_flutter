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
  Color textDark50;
  Color textDark10;

  Color textLight;
  Color textLight30;
  Color textLight15;

  Color overlay20;

  LinearGradient gradientPrimary;

  BoxShadow shadowPrimaryOne;
  BoxShadow shadowPrimaryTwo;

  BoxShadow shadowDangerOne;
  BoxShadow shadowDangerTwo;

  BoxShadow shadowSucces;

  BoxShadow shadowTextDark;

  BoxShadow shadowMainCard;

  BoxShadow shadowBottomBar;

  BoxShadow shadowSettingsList;

  Brightness brightness;
  SystemUiOverlayStyle statusBar;
}

class BlaiseLightTheme extends BaseTheme {
  static const Color orange = Color(0xFFF7941F);
  static const Color yellow = Color(0xFFFCC642);
  static const Color teal = Color(0xFF00C5C3);
  static const Color red = Color(0xFFFF6C59);
  static const Color white = Color(0xFFFFFFFF);
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
  Color textDark50 = grayDark.withOpacity(0.5);
  Color textDark10 = grayDark.withOpacity(0.1);

  Color shadow = grayDark;
  Color shadow50 = grayDark.withOpacity(0.5);
  Color shadow10 = grayDark.withOpacity(0.1);

  Color textLight = white;
  Color textLight30 = white.withOpacity(0.3);
  Color textLight15 = white.withOpacity(0.15);

  Color overlay20 = black.withOpacity(0.2);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [orange, yellow],
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

  BoxShadow shadowMainCard = BoxShadow(
      color: grayDark.withOpacity(0.2),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -3.0);

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

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
}

class BlaiseDarkTheme extends BaseTheme {
  static const Color darkTeal = Color(0xFF61DEFF);
  static const Color lightTeal = Color(0xFFA8FDFF);
  static const Color teal = Color(0xFF00C5C3);
  static const Color red = Color(0xFFFF6C59);
  static const Color bluishGray = Color(0xFF3D3F4F);
  static const Color grayDark = Color(0xFF6B6C71);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFE8ECF3);

  Color primary = darkTeal;
  Color primary60 = darkTeal.withOpacity(0.6);
  Color primary50 = darkTeal.withOpacity(0.5);
  Color primary30 = darkTeal.withOpacity(0.3);
  Color primary15 = darkTeal.withOpacity(0.15);
  Color primary10 = darkTeal.withOpacity(0.10);

  Color secondary = lightTeal;

  Color success = teal;
  Color success30 = teal.withOpacity(0.3);
  Color success15 = teal.withOpacity(0.15);
  Color success10 = teal.withOpacity(0.1);

  Color danger = red;

  Color backgroundPrimary = bluishGray;
  Color backgroundPrimary60 = bluishGray.withOpacity(0.6);
  Color backgroundPrimary30 = bluishGray.withOpacity(0.3);
  Color backgroundPrimary15 = bluishGray.withOpacity(0.15);

  Color backgroundSecondary = bluishGray;

  Color textDark = white;
  Color textDark50 = white.withOpacity(0.5);
  Color textDark10 = white.withOpacity(0.1);

  Color shadow = black;
  Color shadow50 = black.withOpacity(0.3);
  Color shadow10 = black.withOpacity(0.1);

  Color textLight = bluishGray;
  Color textLight30 = bluishGray.withOpacity(0.3);
  Color textLight15 = bluishGray.withOpacity(0.15);

  Color overlay20 = black.withOpacity(0.2);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [darkTeal, lightTeal],
  );

  BoxShadow shadowPrimaryOne = BoxShadow(
      color: darkTeal.withOpacity(0.3),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  BoxShadow shadowPrimaryTwo = BoxShadow(
      color: darkTeal.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowSuccess = BoxShadow(
      color: teal.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowTextDark = BoxShadow(
      color: black.withOpacity(0.15),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  BoxShadow shadowMainCard = BoxShadow(
      color: black.withOpacity(0.2),
      offset: Offset(0, 10),
      blurRadius: 30,
      spreadRadius: -3.0);

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

  Brightness brightness = Brightness.dark;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
}
