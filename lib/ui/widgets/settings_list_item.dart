import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/app_icons.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';

/// A widget for displaying a mnemonic phrase
class SettingsListItem extends StatefulWidget {
  final String header;
  final String subheader;
  final IconData icon;
  final Function onPressed;
  final bool disabled;

  SettingsListItem(
      {@required this.header,
      @required this.icon,
      this.subheader = null,
      this.onPressed,
      this.disabled = false});

  _SettingsListItemState createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 68,
      child: FlatButton(
        padding: EdgeInsetsDirectional.only(start: 24, end: 24),
        onPressed: () {
          return null;
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(widget.icon,
                  size: 24, color: StateContainer.of(context).curTheme.primary),
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
                      style: AppStyles.settingsItemHeader(context),
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
                            style: AppStyles.settingsItemSubHeader(context),
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
    );
  }
}
