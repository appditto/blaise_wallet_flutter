import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/localization.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

class FeeContainer extends StatelessWidget {
  final String feeText;
  FeeContainer({@required this.feeText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(30, 4, 30, 0),
      alignment: Alignment(-1, 0),
      child: AutoSizeText.rich(
        TextSpan(children: [
          TextSpan(
            text: AppLocalization.of(context).feeColonHeader + " ",
            style: AppStyles.primarySmall600(context),
          ),
          TextSpan(
            text: "",
            style: AppStyles.iconFontPrimaryBalanceSmallPascal(context),
          ),
          TextSpan(text: " ", style: TextStyle(fontSize: 6)),
          TextSpan(
              text: this.feeText, style: AppStyles.primarySmall600(context)),
        ]),
      ),
    );
  }
}
