import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter/material.dart';

class UIUtil {
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
                  color: StateContainer.of(context).curTheme.textDark50,
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
    DateFormat df = DateFormat("MMM dd • HH:mm");
    return df.format(dt);
  }
}
