import 'dart:async';
import 'package:flutter/services.dart';

import 'package:pascaldart/common.dart';
import 'package:validators/validators.dart';

enum DataType { ACCOUNT, URL, PUBLIC_KEY }

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

  static Future<String> getClipboardText(DataType type) async {
    ClipboardData data = await Clipboard.getData("text/plain");
    if (data == null || data.text == null) {
      return null;
    } else if (type == DataType.ACCOUNT) {
      try {
        AccountNumber acctNum = AccountNumber(data.text.trim());
        return acctNum.toString();
      } catch (e) {}
    } else if (type == DataType.URL) {
      if (isIP(data.text.trim())) {
        return data.text.trim();
      } else if (isURL(data.text.trim())) {
        return data.text.trim();
      }
    } else if (type == DataType.PUBLIC_KEY) {
      try {
        PublicKeyCoder()
            .decodeFromBase58(data.text.trim());
        return data.text.trim();
      } catch (e) {
        try {
          PublicKeyCoder()
              .decodeFromBytes(
                  PDUtil.hexToBytes(
                      data.text.trim()));
          return data.text.trim();
        } catch (e) {}
      }
    }
    return null;
  }
}