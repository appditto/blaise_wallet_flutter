import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';

/// A widget for displaying a mnemonic phrase
class SettingsListItem extends StatefulWidget {
  final String header;
  final String subheader;
  final String contactName;
  final String contactAddress;
  final IconData icon;
  final Function onPressed;
  final bool contact;
  final bool disabled;

  SettingsListItem({
    this.header,
    this.subheader,
    this.icon,
    this.contactName,
    this.contactAddress,
    this.onPressed,
    this.disabled = false,
    this.contact = false,
  });

  _SettingsListItemState createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: 70,
          child: FlatButton(
            padding: EdgeInsetsDirectional.only(start: 24, end: 24),
            onPressed: () {
              if (widget.onPressed != null && !widget.disabled) {
                widget.onPressed();
              }
              return;
            },
            splashColor: widget.disabled ? Colors.transparent : StateContainer.of(context).curTheme.primary30,
            highlightColor: widget.disabled ? Colors.transparent : StateContainer.of(context).curTheme.primary15,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: widget.contact
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AutoSizeText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: " ",
                              style: AppStyles.iconFontPrimarySmall(context),
                            ),
                            TextSpan(
                              text: widget.contactName,
                              style: AppStyles.contactsItemName(context),
                            ),
                          ]),
                          maxLines: 1,
                          stepGranularity: 0.1,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2 - 80,
                        alignment: Alignment(1, 0),
                        child: AutoSizeText(
                          widget.contactAddress,
                          style: AppStyles.contactsItemAddress(context),
                          maxLines: 1,
                          stepGranularity: 0.1,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Icon(widget.icon,
                            size: 24,
                            color: widget.disabled ? StateContainer.of(context).curTheme.primary60 : StateContainer.of(context).curTheme.primary),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(start: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width - 130,
                              child: AutoSizeText(
                                widget.header,
                                style: widget.disabled ? AppStyles.settingsItemHeaderDisabled(context) : AppStyles.settingsItemHeader(context),
                                maxLines: 1,
                                stepGranularity: 0.1,
                              ),
                            ),
                            widget.subheader == null
                                ? SizedBox()
                                : Container(
                                    width: MediaQuery.of(context).size.width - 130,
                                    child: AutoSizeText(
                                      widget.subheader,
                                      style:
                                          widget.disabled ? AppStyles.settingsItemSubHeaderDisabled(context) : AppStyles.settingsItemSubHeader(context),
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 1,
          color: StateContainer.of(context)
              .curTheme
              .textDark10,
        ),
      ]
    );
  }
}
