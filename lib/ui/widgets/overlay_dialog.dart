import 'dart:ui';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:blaise_wallet_flutter/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';

class DialogOverlay extends StatefulWidget {
  final String title;
  final List<DialogListItem> optionsList;
  final bool logout;
  final bool logoutConfirm;

  DialogOverlay(
      {this.title,
      this.optionsList,
      this.logout = false,
      this.logoutConfirm = false});

  @override
  State<StatefulWidget> createState() => _DialogOverlayState();
}

class _DialogOverlayState extends State<DialogOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
    _scaleAnimation = Tween(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _opacityAnimation = Tween(begin: 0.5, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  buildListItems(List<DialogListItem> optionsList) {
    List<Widget> widgets = [];
    for (var option in optionsList) {
      widgets.add(
        // Single Option
        Container(
          width: double.maxFinite,
          height: 50,
          child: FlatButton(
              onPressed: option.action,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.all(0),
              child: Container(
                alignment: Alignment(-1, 0),
                margin: EdgeInsetsDirectional.only(start: 24, end: 24),
                child: AutoSizeText(
                  option.option,
                  style: AppStyles.paragraphBig(context),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  stepGranularity: 0.1,
                ),
              )),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                  maxWidth: MediaQuery.of(context).size.width*0.8,
                ),
                decoration: BoxDecoration(
                  color: StateContainer.of(context).curTheme.backgroundPrimary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: StateContainer.of(context).curTheme.shadow50,
                      offset: Offset(0, 30),
                      blurRadius: 60,
                      spreadRadius: -10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Header of the modal
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          gradient: widget.logout
                              ? null
                              : StateContainer.of(context)
                                  .curTheme
                                  .gradientPrimary,
                          color: widget.logout
                              ? StateContainer.of(context).curTheme.danger
                              : null,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Container(
                          margin:
                              EdgeInsetsDirectional.fromSTEB(24, 16, 24, 16),
                          child: AutoSizeText(
                            widget.title,
                            style: AppStyles.modalHeader(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                        ),
                      ),
                      // Options container
                      widget.logout
                          ? Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      24, 16, 24, 16),
                                  child: Column(
                                    children: <Widget>[
                                      widget.logoutConfirm
                                          ? AutoSizeText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "Are you sure that you’ve backed up your private key? ",
                                                    style: AppStyles.paragraph(
                                                        context),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "As long as you’ve backed up your private key, you have nothing to worry about.",
                                                    style: AppStyles
                                                        .paragraphDanger(
                                                            context),
                                                  ),
                                                ],
                                              ),
                                              stepGranularity: 0.1,
                                              maxLines: 8,
                                              minFontSize: 8,
                                            )
                                          : AutoSizeText.rich(
                                              TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "Logging out will remove your private key and all Blaise related data from this device. ",
                                                    style: AppStyles
                                                        .paragraphDanger(
                                                            context),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "If your private key is not backed up, you will never be able to access your funds again. If your private key is backed up, you have nothing to worry about.",
                                                    style: AppStyles.paragraph(
                                                        context),
                                                  ),
                                                ],
                                              ),
                                              stepGranularity: 0.1,
                                              maxLines: 8,
                                              minFontSize: 8,
                                            ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    AppButton(
                                      type: AppButtonType.Danger,
                                      text: widget.logoutConfirm
                                          ? "YES, I'M SURE"
                                          : "DELETE PRIVATE KEY\nAND LOGOUT",
                                      buttonTop: true,
                                      onPressed: () {
                                        widget.logoutConfirm
                                            ? Navigator.pushNamed(
                                                context, "/intro_welcome")
                                            : {
                                                Navigator.pop(context),
                                                showDialog(
                                                    context: context,
                                                    builder: (_) =>
                                                        DialogOverlay(
                                                            title:
                                                                'ARE YOU SURE?',
                                                            logout: true,
                                                            logoutConfirm:
                                                                true))
                                              };
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    AppButton(
                                      type: AppButtonType.DangerOutline,
                                      text: "CANCEL",
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.6 -
                                          60,
                                  minHeight: 0),
                              // Options list
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsetsDirectional.only(
                                    top: 8, bottom: 8),
                                children: buildListItems(widget.optionsList),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DialogListItem {
  final String option;
  final Function action;
  DialogListItem({@required this.option, this.action});
}
