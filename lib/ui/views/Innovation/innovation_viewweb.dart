import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../widgets/progressbar_widget.dart';
import 'innovation_viewmodel.dart';

class InnovationWebView extends StatefulWidget {
  final url;

  InnovationWebView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  InnovationWebViewState createState() => InnovationWebViewState();
}

class InnovationWebViewState extends State<InnovationWebView>
    with SingleTickerProviderStateMixin {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext? context, InnovationViewModel? viewModel,
          Widget? child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              _bodyWidget(viewModel!),
              loadingView(viewModel.isLoading),
            ],
          ),
        );
      },
      viewModelBuilder: () => InnovationViewModel(),
      onViewModelReady: (InnovationViewModel model) {
        model.initModel(context);
        // model.showProgressBar(true);
        controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Color.fromARGB(0, 255, 255, 255))
          ..setNavigationDelegate(
            NavigationDelegate(
              onProgress: (int progress) {
                Text('Loading...' + progress.toString());
              },
              onPageStarted: (String url) {
                model.showProgressBar(true);
                model.notifyListeners();
              },
              onPageFinished: (String url) {
                model.showProgressBar(false);
                model.notifyListeners();
              },
              onWebResourceError: (WebResourceError error) {
                model.showProgressBar(false);
                model.notifyListeners();
              },
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            ),
          );
        if (widget.url.isNotEmpty) {
          final uri = Uri.parse(widget.url);
          final hasScheme = uri.scheme.isNotEmpty;
          if (hasScheme) {
            controller.loadRequest(uri);
          } else {
            controller.loadRequest(Uri.parse('https://${widget.url}'));
          }
        }
      },
    );
  }

  Widget _bodyWidget(InnovationViewModel viewModel) {
    return WebViewWidget(controller: controller);
  }
}
