import 'package:blaise_wallet_flutter/appstate_container.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebView {
  static void showWebView(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => WebViewFlutter(initialUrl: url)));
  }
}

class WebViewFlutter extends StatefulWidget {
  final String initialUrl;

  WebViewFlutter({@required this.initialUrl});

  @override
  State createState() => WebViewFlutterState();
}

class WebViewFlutterState extends State<WebViewFlutter> {
  String title;

  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (null != webViewController && await webViewController?.canGoBack())
          webViewController?.goBack();
        else
          Navigator.of(context).pop();
        return Future<bool>.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            brightness: StateContainer.of(context).curTheme.brightness,
          ),
          body: Builder(builder: (co) {
            return WebView(
              initialUrl: widget.initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController web) async {
                webViewController = web;
              },
              onPageFinished: (url) async {
                title = await webViewController.evaluateJavascript("document.title");
                setState(() {});
              },
            );
          })),
    );
  }
}