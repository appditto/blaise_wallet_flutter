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

  Color danger;

  Color backgroundPrimary;
  Color backgroundPrimary30;
  Color backgroundPrimary15;

  Color backgroundSecondary;

  Color textDark;
  Color textDark50;

  Color textLight;
  Color textLight30;
  Color textLight15;

  LinearGradient gradientPrimary;

  BoxShadow shadowPrimary;

  BoxShadow shadowSecondary;

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

  Color primary = orange;
  Color primary60 = orange.withOpacity(0.6);
  Color primary50 = orange.withOpacity(0.5);
  Color primary30 = orange.withOpacity(0.3);
  Color primary15 = orange.withOpacity(0.15);
  Color primary10 = orange.withOpacity(0.10);

  Color secondary = yellow;

  Color success = teal;

  Color danger = red;

  Color backgroundPrimary = white;
  Color backgroundPrimary30 = white.withOpacity(0.3);
  Color backgroundPrimary15 = white.withOpacity(0.15);

  Color backgroundSecondary = white;

  Color textDark = grayDark;
  Color textDark50 = grayDark.withOpacity(0.5);

  Color textLight = white;
  Color textLight30 = white.withOpacity(0.3);
  Color textLight15 = white.withOpacity(0.15);

  LinearGradient gradientPrimary = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    stops: [0.0, 1],
    colors: [orange, yellow],
  );

  BoxShadow shadowPrimary = BoxShadow(
      color: orange.withOpacity(0.5),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);
  
  BoxShadow shadowSecondary = BoxShadow(
      color: orange.withOpacity(0.25),
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: -4.0);

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
}
