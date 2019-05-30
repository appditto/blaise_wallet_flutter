import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BaseTheme {
  Color primary;
  Color primary60;

  Color success;
  Color success60;

  Color background;
  Color background60;

  Color text;
  
  Brightness brightness;
  SystemUiOverlayStyle statusBar;
}

class BlaiseLightTheme extends BaseTheme {
  static const Color orange = Color(0xFFF7941F);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0x00000000);

  Color primary = orange;
  Color primary60 = orange.withOpacity(0.6);

  Color success = white;
  Color success60 = white.withOpacity(0.6);

  Color successDark = white;
  Color successDark30 = white.withOpacity(0.3);

  Color background = white;
  Color background60 = white.withOpacity(0.4);

  Color text = black.withOpacity(0.9);

  Brightness brightness = Brightness.light;
  SystemUiOverlayStyle statusBar =
      SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent);
}
