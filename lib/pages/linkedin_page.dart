import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LinkedinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre o Desenvolvedor"),
      ),
      body: _webView(),
    );
  }

  _webView() {
    return WebView(
      // initialUrl: "https://www.linkedin.com/in/adrianofpinheiro",
      initialUrl: "https://github.com/AdrianoFPinheiro?tab=repositories",
    );
  }
}