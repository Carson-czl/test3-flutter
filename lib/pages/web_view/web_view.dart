import 'package:flutter/material.dart';
import 'package:web_wallet/common/widget/custom_app_bar.dart';
import 'package:web_wallet/common/widget/theme_scheme.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPageParam {
  String? uri;
  String? assetPath;
  String title;
  WebViewPageParam({
    this.uri,
    this.assetPath,
    this.title = "",
  });
}

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController webViewController;
  String webViewTitle = '';

  @override
  void initState() {
    initWebViewData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var arguments =
          ModalRoute.of(context)?.settings.arguments as WebViewPageParam?;
      if (arguments != null) {
        if (arguments.assetPath != null && arguments.assetPath != '') {
          webViewController
              .loadFlutterAsset('assets/html/date-table/index.html');
        } else if (arguments.uri != null && arguments.uri != '') {
          webViewController.loadRequest(Uri.parse(arguments.uri ?? ''));
        }
        setState(() {
          webViewTitle = arguments.title;
        });
      }
    });
    super.initState();
  }

  void initWebViewData() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      // ..addJavaScriptChannel(
      //   'MyJavascriptChannel',
      //   onMessageReceived: (JavaScriptMessage res) {},
      // )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (request) {
            // Handle navigation.
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: webViewTitle,
        leadingShow: false,
        borderWidth: 1,
        rightBtn: <Widget>[],
      ),
      backgroundColor: ThemeScheme.getWhiteBackground(),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}
