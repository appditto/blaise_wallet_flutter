import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';

class AppMarginSizes {
  static const m0 = 0.0;
  static const m1 = 4.0;
  static const m2 = 16.0;
  static const m3 = 18.0;
  static const m4 = 24.0;
  static const m5 = 30.0;
  static const m6 = 40.0;
}

class AppMargins {
  // Text Field Header Margins
  static EdgeInsetsDirectional textFieldHeader(BuildContext context) {
    return UIUtil.smallScreen(context)
        ? EdgeInsetsDirectional.fromSTEB(AppMarginSizes.m5, AppMarginSizes.m2,
            AppMarginSizes.m5, AppMarginSizes.m0)
        : EdgeInsetsDirectional.fromSTEB(AppMarginSizes.m5, AppMarginSizes.m5,
            AppMarginSizes.m5, AppMarginSizes.m0);
  }
}
