import 'package:flutter/material.dart';
import 'package:mewtwo/base/pages/webview/webview_store.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Webview extends StatelessWidget {
  final String url;
  final String? title;
  Webview({Key? key, required this.url, this.title}) : super(key: key);
  final WebviewStore store = WebviewStore();
  

  @override
  Widget build(BuildContext context) {
    late Uri websiteUrl;
    try {
      websiteUrl = Uri.parse(url);
    } on FormatException catch (_) {
      return Scaffold(
          appBar: AppBar(),
          body: Center(child: Text("Not valid url: $url")));
    }
    store.controller.loadRequest(websiteUrl);
    return Observer(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: Text(title ?? store.title, style: const TextStyle(color: Colors.white),)),
          body: WebViewWidget(controller: store.controller),
        );
      }
    );
  }
}
