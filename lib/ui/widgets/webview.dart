import 'dart:io';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class AppWebView {
  static void showWebView(BuildContext context, String url) {
    UIUtil.cancelLockEvent();
    Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => WebviewScaffold(
                resizeToAvoidBottomInset: Platform.isAndroid,
                url: url,
                appBar: AppBar(
                    backgroundColor:
                        StateContainer.of(context).curTheme.primary,
                    brightness: StateContainer.of(context).curTheme.brightness,
                    iconTheme: IconThemeData(
                        color:
                            StateContainer.of(context).curTheme.textLight)))));
  }
}
