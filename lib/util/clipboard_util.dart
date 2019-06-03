import 'dart:async';
import 'package:flutter/services.dart';

import 'package:pascaldart/common.dart';

class ClipboardUtil {
  static StreamSubscription<dynamic> setStream;

  /// Set to clear clipboard after 2 minutes, if clipboard contains a pkey
  static Future<void> setClipboardClearEvent() async {
    if (setStream != null) {
      setStream.cancel();
    }
    Future<dynamic> delayed = new Future.delayed(new Duration(minutes: 2));
    delayed.then((_) {
      return true;
    });
    setStream = delayed.asStream().listen((_) {
      Clipboard.getData("text/plain").then((data) {
        // Clear if valid pkey
        if (data != null && data.text != null) {
          try {
            PrivateKeyCoder().decodeFromBytes(PDUtil.hexToBytes(data.text));
            Clipboard.setData(ClipboardData(text: ""));
          } catch (e) {}
        }
      });
    });
  }
}