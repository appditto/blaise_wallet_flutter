import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color primary;

  Color secondary;

  Color success;

  Color danger;

  Color background;
  Color backgroundTwo;

  Color textDark;
  Color textLight;

  LinearGradient gradientMain;

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

  Color secondary = yellow;

  Color success = teal;

  Color danger = red;

  Color background = white;
  Color backgroundTwo = white;

  Color textDark = grayDark;
  Color textLight = white;

  LinearGradient gradientMain = LinearGradient(
    // Where the linear gradient begins and ends
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: [0.0, 1],
    colors: [orange, yellow],
  );

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
}
