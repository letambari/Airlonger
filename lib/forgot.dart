import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airlonger'),
      ),
      body: WebView(
        initialUrl: 'https://airlonger.com/reset-password',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}