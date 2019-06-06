import 'package:flutter/material.dart';

/// A widget that will unfocus any focus nodes when tapped outside of the child boundaries
class TapOutsideUnfocus extends StatelessWidget {
  final List<FocusNode> focusNodes;
  final Widget child;

  TapOutsideUnfocus({@required this.focusNodes, @required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            // Clear focus of our fields when tapped in this empty space
            focusNodes.forEach((f) {
              f.unfocus();
            });
          },
          child: Container(
            color: Colors.transparent,
            child: SizedBox.expand(),
            constraints: BoxConstraints.expand(),
          ),
        ),
        this.child
      ]
    );
  }
}