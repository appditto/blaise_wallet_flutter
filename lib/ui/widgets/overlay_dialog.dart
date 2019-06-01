import 'dart:ui';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:blaise_wallet_flutter/ui/util/text_styles.dart';
import 'package:blaise_wallet_flutter/ui/widgets/auto_resize_text.dart';
import 'package:flutter/material.dart';

class DialogOverlay extends StatefulWidget {
  final String title;

  DialogOverlay({@required this.title});

  @override
  State<StatefulWidget> createState() => _DialogOverlayState();
}

class _DialogOverlayState extends State<DialogOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _blurAnimation;
  Tween _tween;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _blurAnimation = Tween(begin: 0.0, end: 5.0).animate(
     CurvedAnimation(parent: _controller, curve: Curves.easeInOut) 
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _blurAnimation.value, sigmaY: _blurAnimation.value),
          child: ScaleTransition(
            scale: _scaleAnimation,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.5,
                ),
                decoration: BoxDecoration(
                  color: StateContainer.of(context)
                      .curTheme
                      .backgroundPrimary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: StateContainer.of(context)
                          .curTheme
                          .textDark50,
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
                          gradient: StateContainer.of(context)
                              .curTheme
                              .gradientPrimary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                        ),
                        child: Container(
                          margin: EdgeInsetsDirectional.fromSTEB(
                              24, 16, 24, 16),
                          child: AutoSizeText(
                            widget.title,
                            style: AppStyles.modalHeader(context),
                            maxLines: 1,
                            stepGranularity: 0.1,
                          ),
                        ),
                      ),
                      // Options container
                      Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height *
                                        0.5 -
                                    60,
                            minHeight: 0),
                        // Options list
                        child: ListView(
                          padding: EdgeInsetsDirectional.only(
                              top: 8, bottom: 8),
                          children: <Widget>[
                            // Single Option
                            Container(
                              width: double.maxFinite,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () {
                                    return null;
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(0),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment(-1, 0),
                                    margin: EdgeInsetsDirectional.only(
                                        start: 24, end: 24),
                                    child: AutoSizeText(
                                      "\$ US Dollar",
                                      style: AppStyles.paragraphBig(
                                          context),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                    ),
                                  )),
                            ),
                            // Single Option
                            Container(
                              width: double.maxFinite,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () {
                                    return null;
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(0),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment(-1, 0),
                                    margin: EdgeInsetsDirectional.only(
                                        start: 24, end: 24),
                                    child: AutoSizeText(
                                      "\$ Argentine Peso",
                                      style: AppStyles.paragraphBig(
                                          context),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                    ),
                                  )),
                            ),
                            // Single Option
                            Container(
                              width: double.maxFinite,
                              height: 50,
                              child: FlatButton(
                                  onPressed: () {
                                    return null;
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(0),
                                  ),
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment(-1, 0),
                                    margin: EdgeInsetsDirectional.only(
                                        start: 24, end: 24),
                                    child: AutoSizeText(
                                      "\$ Australian Dollar",
                                      style: AppStyles.paragraphBig(
                                          context),
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      stepGranularity: 0.1,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}