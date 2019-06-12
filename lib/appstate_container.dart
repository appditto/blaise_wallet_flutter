import 'package:blaise_wallet_flutter/model/available_languages.dart';
import 'package:blaise_wallet_flutter/themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const List<String> PREACHED_SVG_ASSETS = [
  'assets/illustration_backup.svg',
  'assets/illustration_new_wallet.svg',
  'assets/illustration_two_options.svg',
  'assets/illustration_borrowed.svg',
  'assets/illustration_backup_dark.svg',
  'assets/illustration_new_wallet_dark.svg',
  'assets/illustration_two_options_dark.svg',
  'assets/illustration_borrowed_dark.svg',
];

class _InheritedStateContainer extends InheritedWidget {
   // Data is your entire state. In our case just 'User' 
  final StateContainerState data;
   
  // You must pass through a child and your state.
  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class StateContainer extends StatefulWidget {
   // You must pass through a child. 
  final Widget child;

  StateContainer({
    @required this.child
  });

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer).data;
  }
  
  @override
  StateContainerState createState() => StateContainerState();
}

/// App InheritedWidget
/// This is where we handle the global state and also where
/// we interact with the server and make requests/handle+propagate responses
/// 
/// Basically the central hub behind the entire app
class StateContainerState extends State<StateContainer> {
  BaseTheme curTheme = BlaiseLightTheme();
  LanguageSetting curLanguage = LanguageSetting(AvailableLanguage.DEFAULT);

  Future<void> _precacheSvgs() async {
    PREACHED_SVG_ASSETS.forEach((asset) {
      precachePicture(ExactAssetPicture(
        SvgPicture.svgStringDecoder,
        asset
      ), context);
    });
  }

  void updateTheme(BaseTheme theme) {
    if (theme != null) {
      setState(() {
        this.curTheme = theme;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _precacheSvgs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}