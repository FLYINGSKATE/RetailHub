import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CoworkingScreenWeb extends StatefulWidget {
  const CoworkingScreenWeb({super.key});

  @override
  State<CoworkingScreenWeb> createState() => _CoworkingScreenWebState();
}

bool? check = false;

class _CoworkingScreenWebState extends State<CoworkingScreenWeb> {
  var controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color.fromARGB(0, 255, 255, 255))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            Text('Loading...' + progress.toString());
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://app.retailhub.ai/'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: WebViewWidget(controller: controller),
    ));
  }
}
