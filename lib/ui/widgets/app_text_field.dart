import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';

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
        gradient: StateContainer.of(
                context)
            .curTheme
            .gradientPrimary,
      ),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: CircleBorder(),
        onPressed: () {
          return onPressed != null ? onPressed() : null;
        },
        splashColor: StateContainer
                .of(context)
            .curTheme
            .backgroundPrimary30,
        highlightColor:
            StateContainer.of(
                    context)
                .curTheme
                .backgroundPrimary15,
        child: Icon(
          icon,
          size: 22,
          color: StateContainer.of(
                  context)
              .curTheme
              .backgroundPrimary,
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
  final TextStyle style;
  final bool passwordField;
  final Widget prefix;
  final int maxLines;

  AppTextField({
    @required this.label,
    @required this.style,
    this.firstButton,
    this.secondButton,
    this.controller,
    this.focusNode,
    this.prefix,
    this.maxLines,
    this.passwordField = false
  });

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
              primaryColor: StateContainer.of(context)
                  .curTheme
                  .primary,
              hintColor: StateContainer.of(context)
                  .curTheme
                  .primary,
              splashColor: StateContainer.of(context)
                  .curTheme
                  .primary30,
              highlightColor: StateContainer.of(context)
                  .curTheme
                  .primary15,
              textSelectionColor: StateContainer.of(context)
                  .curTheme
                  .primary30,
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: widget.passwordField,
              style: widget.style,
              cursorColor: StateContainer.of(context)
                  .curTheme
                  .primary,
              keyboardType: TextInputType.text,
              autocorrect: false,
              textCapitalization:
                  TextCapitalization.characters,
              textInputAction: TextInputAction.done,
              maxLines: widget.maxLines,
              minLines: 1,
              decoration: InputDecoration(
                prefix: widget.prefix,
                suffixIcon: widget.firstButton == null && widget.secondButton == null ?
                null :
                  Container(
                    width: widget.firstButton == null || widget.secondButton == null ? 44 : 88,
                    height: 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        widget.secondButton != null ? 
                          Container(
                            width: 38,
                            height: 38,
                            child: widget.secondButton
                           )
                        : SizedBox(),
                        widget.firstButton != null ?
                          Container(
                            margin: EdgeInsetsDirectional.only(start: 12),
                            width: 38,
                            height: 38,
                            child: widget.firstButton
                           )
                        : SizedBox()
                      ],
                    ),
                  ),
              ),
            ),
          ),
        ),
      ],
    );        
  }
}