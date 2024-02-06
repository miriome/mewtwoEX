// @dart = 2.12
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:mobx/mobx.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'webview_store.g.dart';

class WebviewStore extends _WebviewStore with _$WebviewStore {}

abstract class _WebviewStore with Store {

  _WebviewStore() {
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) async {
          title = await _controller.getTitle() ?? "";
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          // if (request.url.startsWith('https://www.youtube.com/')) {
          //   return NavigationDecision.prevent;
          // }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
  @readonly
  WebViewController _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)
      // ..setBackgroundColor(const Color(0x00000000))
      ;
  @observable
  String title = "";
}
