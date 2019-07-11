import 'dart:io';
import 'dart:ui';

import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:flutter/material.dart';

class AppSheets {
  //App Ninty Height Sheet
  static Future<T> showBottomSheet<T>(
      {@required BuildContext context,
      @required Widget widget,
      Color color,
      Color bgColor,
      bool noBlur = false,
      int animationDurationMs = 250,
      bool closeOnTap = false,
      Function onDisposed}) {
    if (color == null) {
      color = StateContainer.of(context).curTheme.backgroundPrimary;
    }
    if (bgColor == null) {
      bgColor = StateContainer.of(context).curTheme.overlay20;
    }
    var route = _AppBottomSheetModalRoute<T>(
        builder: (BuildContext context) {
          return widget;
        },
        color: color,
        noBlur: noBlur,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        bgColor: bgColor,
        animationDurationMs: animationDurationMs,
        closeOnTap: closeOnTap,
        onDisposed: onDisposed);
    return Navigator.push<T>(context, route);
  }
}

/// The constraints of this sheet
class _AppBottomSheetLayout extends SingleChildLayoutDelegate {
  _AppBottomSheetLayout(this.progress);
  final double progress;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    if (constraints.maxHeight < 667)
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.95);
    if ((constraints.maxHeight / constraints.maxWidth > 2.1 &&
            Platform.isAndroid) ||
        constraints.maxHeight > 812)
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.8);
    else
      return BoxConstraints(
          minWidth: constraints.maxWidth,
          maxWidth: constraints.maxWidth,
          minHeight: 0.0,
          maxHeight: constraints.maxHeight * 0.9);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_AppBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}

class _AppBottomSheetModalRoute<T> extends PopupRoute<T> {
  _AppBottomSheetModalRoute(
      {this.builder,
      this.barrierLabel,
      this.color,
      RouteSettings settings,
      this.bgColor,
      this.animationDurationMs,
      this.closeOnTap,
      this.noBlur,
      this.onDisposed})
      : super(settings: settings);

  final WidgetBuilder builder;
  final Color color;
  final bool noBlur;
  final Color bgColor;
  final int animationDurationMs;
  final bool closeOnTap;
  final Function onDisposed;

  @override
  Color get barrierColor => bgColor;

  @override
  bool get barrierDismissible => true;

  @override
  String barrierLabel;

  @override
  void didComplete(T result) {
    if (onDisposed != null) {
      onDisposed();
    }
    super.didComplete(result);
  }

  AnimationController _animationController;
  CurvedAnimation appSheetAnimation;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    _animationController.duration = Duration(milliseconds: animationDurationMs);
    this.appSheetAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.linear)
      ..addStatusListener((animationStatus) {
        if (animationStatus == AnimationStatus.completed) {
          appSheetAnimation.curve = Curves.linear;
        }
      });
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GestureDetector(
        onTap: () {
          if (closeOnTap) {
            // Close when tapped anywhere
            Navigator.of(context).pop();
          }
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: noBlur?0:5, sigmaY: noBlur?0:5),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                      child: AnimatedBuilder(
              animation: appSheetAnimation,
              builder: (context, child) => CustomSingleChildLayout(
                    delegate: _AppBottomSheetLayout(appSheetAnimation.value),
                    child: BottomSheet(
                      animationController: _animationController,
                      onClosing: () => Navigator.of(context).pop(),
                      builder: (context) => Container(
                            decoration: BoxDecoration(
                              color: this.color,
                              borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            ),

                            child: Builder(builder: this.builder),
                          ),
                    ),
                  ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration =>
      Duration(milliseconds: animationDurationMs);
}
