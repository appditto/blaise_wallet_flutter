import 'dart:async';
import 'package:blaise_wallet_flutter/util/ui_util.dart';
import 'package:flutter/services.dart';

import 'package:pascaldart/common.dart';
import 'package:quiver/strings.dart';
import 'package:validators/validators.dart';
import 'package:barcode_scan/barcode_scan.dart';

enum DataType { RAW, ACCOUNT, URL, PUBLIC_KEY }

class UserDataUtil {
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

  static String _parseData(String data, DataType type) {
    data = data.trim();
    if (type == DataType.RAW) {
      return data;
    } else if (type == DataType.ACCOUNT) {
      try {
        AccountNumber acctNum = AccountNumber(data);
        return acctNum.toString();
      } catch (e) {}
    } else if (type == DataType.URL) {
      if (isIP(data)) {
        return data;
      } else if (isURL(data)) {
        return data;
      }
    } else if (type == DataType.PUBLIC_KEY) {
      try {
        PublicKeyCoder()
            .decodeFromBase58(data);
        return data;
      } catch (e) {
        try {
          PublicKeyCoder()
              .decodeFromBytes(
                  PDUtil.hexToBytes(
                      data));
          return data;
        } catch (e) {}
      }
    }
    return null;
  }

  static Future<String> getClipboardText(DataType type) async {
    ClipboardData data = await Clipboard.getData("text/plain");
    if (data == null || data.text == null) {
      return null;
    }
    return _parseData(data.text, type);
  }

  static Future<String> getQRData(DataType type) async {
    UIUtil.cancelLockEvent();
    try {
      String data = await BarcodeScanner.scan();
      if (isEmpty(data)) {
        return null;
      }
      return _parseData(data, type);
    } catch (e) {
      return null;
    }
  }
}