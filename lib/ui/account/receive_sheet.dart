import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:blaise_wallet_flutter/ui/widgets/svg_repaint.dart';
import 'package:flutter/material.dart';

class ReceiveSheet extends StatefulWidget {
  _ReceiveSheetState createState() => _ReceiveSheetState();
}

class _ReceiveSheetState extends State<ReceiveSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: StateContainer.of(context).curTheme.backgroundPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Column(
            children: <Widget>[
              // Sheet header
              Container(
                height: 60,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient:
                      StateContainer.of(context).curTheme.gradientPrimary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Close Button
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 5, end: 10),
                      height: 50,
                      width: 50,
                      child: FlatButton(
                          highlightColor:
                              StateContainer.of(context).curTheme.textLight15,
                          splashColor:
                              StateContainer.of(context).curTheme.textLight30,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Icon(AppIcons.close,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textLight,
                              size: 20)),
                    ),
                    // Header
                    Container(
                      width: MediaQuery.of(context).size.width-130,
                      alignment: Alignment(0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AutoSizeText(
                            "yekta",
                            style: AppStyles.accountCardName(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            textAlign: TextAlign.center,
                          ),
                          AutoSizeText(
                            "578706-79",
                            style: AppStyles.accountCardAddress(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Share Button
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 10, end: 5),
                      height: 50,
                      width: 50,
                      child: FlatButton(
                          highlightColor:
                              StateContainer.of(context).curTheme.textLight15,
                          splashColor:
                              StateContainer.of(context).curTheme.textLight30,
                          onPressed: () {
                            return null;
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Icon(AppIcons.shareaddress,
                              color: StateContainer.of(context)
                                  .curTheme
                                  .textLight,
                              size: 22)),
                    ),
                  ],
                ),
              ),
              //"Copy Address" and "Request Amount" buttons
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.Primary,
                    text: "Copy Address",
                    buttonTop: true,
                  ),
                ],
              ),
              // "Request Amount" button
              Row(
                children: <Widget>[
                  AppButton(
                    type: AppButtonType.PrimaryOutline,
                    text: "Request Amount",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
