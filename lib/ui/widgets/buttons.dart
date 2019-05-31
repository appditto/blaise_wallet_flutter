import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  Primary,
  PrimaryOutline,
  Success,
  SuccessOutline,
}

/// A widget for displaying a mnemonic phrase
class AppButton extends StatefulWidget {
  final AppButtonType type;
  final String text;
  final Function onPressed;
  final bool disabled;
  final bool buttonTop;

  AppButton({this.type, this.text, this.onPressed, this.disabled = false, this.buttonTop = false});

  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: widget.type == AppButtonType.Primary || widget.type == AppButtonType.Success ? BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: widget.type == AppButtonType.Primary ? StateContainer.of(context).curTheme.gradientPrimary : StateContainer.of(context).curTheme.gradientPrimary, // Success color placeholder
          boxShadow: [
            StateContainer.of(context).curTheme.shadowPrimaryOne,
          ],
        ) 
        : BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                 widget.type == AppButtonType.PrimaryOutline ? StateContainer.of(context).curTheme.shadowPrimaryTwo : StateContainer.of(context).curTheme.shadowPrimaryTwo,
              ]),
        margin: widget.buttonTop
            ? EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0)
            : EdgeInsetsDirectional.fromSTEB(
                20,
                16,
                20,
                (MediaQuery.of(context).padding.bottom) +
                    (24 - (MediaQuery.of(context).padding.bottom) / 2),
              ),
        height: 50,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0)),
          child: AutoSizeText(
            widget.text,
            textAlign: TextAlign.center,
            maxLines: 1,
            stepGranularity: 0.1,
            style: widget.type == AppButtonType.Primary ? AppStyles.buttonPrimary(context) : AppStyles.buttonPrimaryOutline(context),
          ),
          splashColor:
              widget.type == AppButtonType.Primary ? StateContainer.of(context).curTheme.backgroundPrimary30 : StateContainer.of(context).curTheme.primary30,
          highlightColor:
              widget.type == AppButtonType.Primary ? StateContainer.of(context).curTheme.backgroundPrimary15 : StateContainer.of(context).curTheme.primary15,
          onPressed: () {
            if (widget.onPressed != null && !widget.disabled) {
              widget.onPressed();
            }
            return;
          },
        ),
      ),
    );
  }
}