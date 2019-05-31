import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgRepaintAsset extends StatelessWidget {
  String asset;
  double width;

  SvgRepaintAsset({this.asset, this.width});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SvgPicture.asset(asset, width: width)
    );
  }
}