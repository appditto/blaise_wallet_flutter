import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

/// A widget for buttons
class PlaceholderAccountCard extends StatefulWidget {
  _PlaceholderAccountCardState createState() => _PlaceholderAccountCardState();
}

class _PlaceholderAccountCardState extends State<PlaceholderAccountCard> {
  @override
  Widget build(BuildContext context) {
    // Account Card
    return Container(
      width: double.maxFinite,
      margin: EdgeInsetsDirectional.fromSTEB(12, 5, 12, 5),
      height: 70,
      decoration: BoxDecoration(
          color: StateContainer.of(context).curTheme.backgroundPrimary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [StateContainer.of(context).curTheme.shadowAccountCard]),
      child: Stack(
        children: <Widget>[
          // Left gradient background
          Container(
            height: double.maxFinite,
            width: MediaQuery.of(context).size.width * 0.47 - 24,
            decoration: BoxDecoration(
                gradient: StateContainer.of(context).curTheme.gradientPrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
          ),
          FlatButton(
            onPressed: () {
              return null;
            },
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Left part of the card with account name and number
                Container(
                  height: double.maxFinite,
                  width: MediaQuery.of(context).size.width * 0.47 - 24,
                  padding: EdgeInsetsDirectional.only(start: 16, end: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsetsDirectional.only(bottom: 5),
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.textLight.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: AutoSizeText(
                          "            ",
                          style: AppStyles.accountCardName(context),
                          textAlign: TextAlign.left,
                          stepGranularity: 0.5,
                          maxLines: 1,
                          minFontSize: 8,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: StateContainer.of(context).curTheme.textLight.withOpacity(0.75),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: AutoSizeText(
                          "         ",
                          style: AppStyles.accountCardAddress(context),
                          textAlign: TextAlign.left,
                          stepGranularity: 0.5,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
                // Right part of the card with balance
                Container(
                  height: double.maxFinite,
                  width: MediaQuery.of(context).size.width * 0.53 - 24,
                  padding: EdgeInsetsDirectional.only(end: 16),
                  alignment: Alignment(1, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: StateContainer.of(context).curTheme.primary.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: AutoSizeText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "              ",
                              style: AppStyles.balanceMedium(context)),
                        ],
                      ),
                      textAlign: TextAlign.end,
                      maxLines: 1,
                      minFontSize: 4,
                      stepGranularity: 1,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
