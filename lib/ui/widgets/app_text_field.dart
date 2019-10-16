import 'package:auto_size_text/auto_size_text.dart';
import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TextField button
class TextFieldButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  TextFieldButton({@required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: StateContainer.of(context).curTheme.gradientPrimary,
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: CircleBorder(),
        onPressed: () {
          return onPressed != null ? onPressed() : null;
        },
        splashColor: StateContainer.of(context).curTheme.backgroundPrimary30,
        highlightColor: StateContainer.of(context).curTheme.backgroundPrimary15,
        child: Icon(
          icon,
          size: 22,
          color: StateContainer.of(context).curTheme.backgroundPrimary,
        ),
      ),
    );
  }
}

/// A widget for our custom textfields
class AppTextField extends StatefulWidget {
  final String label;
  final TextFieldButton firstButton;
  final TextFieldButton secondButton;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final TextStyle style;
  final bool passwordField;
  final Widget prefix;
  final int maxLines;
  final List<TextInputFormatter> inputFormatters;
  final Function onChanged;
  final Function onTap;
  final bool readOnly;
  final TextInputAction textInputAction;
  final Function onSubmitted;

  AppTextField(
      {@required this.label,
      @required this.style,
      this.firstButton,
      this.secondButton,
      this.controller,
      this.focusNode,
      this.textCapitalization,
      this.inputType = TextInputType.text,
      this.prefix,
      this.maxLines,
      this.inputFormatters,
      this.onChanged,
      this.onTap,
      this.onSubmitted,
      this.passwordField = false,
      this.readOnly = false,
      this.textInputAction = TextInputAction.done});

  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment(-1, 0),
          child: AutoSizeText(
            widget.label,
            style: AppStyles.textFieldLabel(context),
          ),
        ),
        Container(
          child: Theme(
              data: ThemeData(
                primaryColor: StateContainer.of(context).curTheme.primary,
                hintColor: StateContainer.of(context).curTheme.primary,
                splashColor: StateContainer.of(context).curTheme.primary30,
                highlightColor: StateContainer.of(context).curTheme.primary15,
                textSelectionColor:
                    StateContainer.of(context).curTheme.primary30,
              ),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  TextField(
                    readOnly: widget.readOnly,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    obscureText: widget.passwordField,
                    style: widget.style,
                    cursorColor: StateContainer.of(context).curTheme.primary,
                    keyboardType: widget.inputType,
                    autocorrect: false,
                    textCapitalization:
                        widget.textCapitalization ?? TextCapitalization.none,
                    textInputAction: widget.textInputAction,
                    maxLines: widget.maxLines,
                    minLines: 1,
                    onSubmitted: (text) {
                      if (widget.textInputAction == TextInputAction.done && widget.onSubmitted == null) {
                        FocusScope.of(context).unfocus();
                      } else if (widget.onSubmitted != null) {
                        widget.onSubmitted();
                      }
                    },
                    inputFormatters: widget.inputFormatters,
                    onTap: widget.onTap,
                    onChanged: (String newValue) {
                      if (widget.onChanged != null) {
                        widget.onChanged(newValue);
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: StateContainer.of(context).curTheme.primary),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: StateContainer.of(context).curTheme.primary,
                            width: 2),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: StateContainer.of(context).curTheme.danger,
                            width: 2),
                      ),
                      prefix: widget.prefix,
                      suffixIcon: widget.firstButton == null &&
                              widget.secondButton == null
                          ? Container(
                            width: 0,
                            height: 0,
                          )
                          : Container(
                              width: widget.firstButton == null ||
                                      widget.secondButton == null
                                  ? 50
                                  : 100,
                              height: 38,
                            ),
                    ),
                  ),
                  // Buttons
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          widget.secondButton != null
                              ? Container(
                                  margin: EdgeInsetsDirectional.only(start: 12),
                                  width: 38,
                                  height: 38,
                                  child: widget.secondButton)
                              : SizedBox(),
                          widget.firstButton != null
                              ? Container(
                                  margin: EdgeInsetsDirectional.only(start: 12),
                                  width: 38,
                                  height: 38,
                                  child: widget.firstButton)
                              : SizedBox()
                        ],
                      ),
                    ],
                  )
                ],
              )),
        ),
      ],
    );
  }
}
