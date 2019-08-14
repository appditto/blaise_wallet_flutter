import 'dart:async';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/bus/events.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/overlay_dialog.dart';
import 'package:event_taxi/event_taxi.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

class UIUtil {
  static bool smallScreen(BuildContext context) {
    if (MediaQuery.of(context).size.height < 667)
      return true;
    else
      return false;
  }

  static void showSnackbar(String content, BuildContext context) {
    showToastWidget(
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.05,
              horizontal: 14),
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: StateContainer.of(context).curTheme.overlay20,
                  offset: Offset(0, 20),
                  blurRadius: 40,
                  spreadRadius: -5),
            ],
          ),
          child: Text(
            content,
            style: AppStyles.snackBar(context),
            textAlign: TextAlign.start,
          ),
        ),
      ),
      dismissOtherToast: true,
      duration: Duration(milliseconds: 2000),
    );
  }

  static String formatDateStr(DateTime dt) {
    int currentYear = DateTime.now().toLocal().year;
    DateTime localTime = dt.toLocal();
    DateFormat df;
    if (localTime.year != currentYear) {
      df = DateFormat("MMM dd, yyyy • HH:mm");
    } else {
      df = DateFormat("MMM dd • HH:mm");
    }
    return df.format(localTime);
  }

  static String formatDateStrLong(DateTime dt) {
    //"Jul 08, 2019 • 13:24:01 (1562592241)"
    int secondsSinceEpoch = dt.millisecondsSinceEpoch ~/ 1000;
    DateTime localTime = dt.toLocal();
    DateFormat df;
    df = DateFormat("MMM dd, yyyy • HH:mm:ss");
    return df.format(localTime) + "\n($secondsSinceEpoch)";
  }

  /// Show a dialog asking if they want to confirm a fee
  static void showFeeDialog(
      {@required BuildContext context, @required Function onConfirm}) {
    showAppDialog(
        context: context,
        builder: (_) => DialogOverlay(
            title: AppLocalization.of(context).addFeeHeader,
            feeDialog: true,
            confirmButtonText:
                toUppercase(AppLocalization.of(context).confirmButton, context),
            body: TextSpan(
              children: [
                TextSpan(
                  text: AppLocalization.of(context).feeRequiredParagraph + "\n",
                  style: AppStyles.paragraph(context),
                ),
                TextSpan(
                  text: AppLocalization.of(context)
                      .feeConfirmAmountParagraph
                      .replaceAll("%1", "0.0001"),
                  style: AppStyles.paragraphPrimary(context),
                ),
              ],
            ),
            onConfirm: () {
              onConfirm();
            }));
  }

  static StreamSubscription<dynamic> _lockDisableSub;
  static Future<void> cancelLockEvent() async {
    // Cancel auto-lock event, usually if we are launching another intent
    if (_lockDisableSub != null) {
      _lockDisableSub.cancel();
    }
    EventTaxiImpl.singleton().fire(DisableLockTimeoutEvent(disable: true));
    Future<dynamic> delayed = Future.delayed(Duration(seconds: 10));
    delayed.then((_) {
      return true;
    });
    _lockDisableSub = delayed.asStream().listen((_) {
      EventTaxiImpl.singleton().fire(DisableLockTimeoutEvent(disable: false));
    });
  }
}

List<TextSpan> formatLocalizedColors(BuildContext context, String input) {
  List<TextSpan> ret = [];
  if (!input.contains('<colored>') && !input.contains('</colored>')) {
    ret.add(TextSpan(text: input, style: AppStyles.paragraph(context)));
    return ret;
  }
  int i = 0;
  int iEnd = 0;
  while (input.contains('<colored>') && input.contains('</colored>')) {
    i = input.indexOf('<colored>');
    iEnd = input.indexOf('</colored>');
    ret.add(TextSpan(
        text: input.substring(0, i), style: AppStyles.paragraph(context)));
    ret.add(TextSpan(
        text: input.substring(i + 9, iEnd),
        style: AppStyles.paragraphPrimary(context)));
    input = input.substring(iEnd + 10);
  }
  if (input.length > 0) {
    ret.add(TextSpan(text: input, style: AppStyles.paragraph(context)));
  }
  return ret;
}

List<TextSpan> formatLocalizedColorsDanger(BuildContext context, String input) {
  List<TextSpan> ret = [];
  if (!input.contains('<colored>') && !input.contains('</colored>')) {
    ret.add(TextSpan(text: input, style: AppStyles.paragraph(context)));
    return ret;
  }
  int i = 0;
  int iEnd = 0;
  while (input.contains('<colored>') && input.contains('</colored>')) {
    i = input.indexOf('<colored>');
    iEnd = input.indexOf('</colored>');
    ret.add(TextSpan(
        text: input.substring(0, i), style: AppStyles.paragraph(context)));
    ret.add(TextSpan(
        text: input.substring(i + 9, iEnd),
        style: AppStyles.paragraphDanger(context)));
    input = input.substring(iEnd + 10);
  }
  if (input.length > 0) {
    ret.add(TextSpan(text: input, style: AppStyles.paragraph(context)));
  }
  return ret;
}

String toUppercase(String input, BuildContext context) {
    Locale locale = Locale(StateContainer.of(context).curLanguage.getLocaleString());
    if (locale != null && locale.languageCode == 'tr') {
      input = input.replaceAll("i", "İ");
    } else if (locale != null && locale.languageCode == 'de') {
      input = input.replaceAll("ß", "SS");
    }
    return input.toUpperCase();
}