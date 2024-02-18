import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


void main() {
  runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewDemo(),
    );
  }
}

class WebViewDemo extends StatefulWidget {
  const WebViewDemo({super.key});

  @override
  State<WebViewDemo> createState() => _WebViewDemoState();
}

class _WebViewDemoState extends State<WebViewDemo> {

  WebViewController controller = WebViewController();
  late WebViewController _webViewController;
  @override
  void initState()
  {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) => {},
          onPageStarted: (url) => {},
          onPageFinished: (url) => {},
        ),)

      ..loadRequest(Uri.parse('https://ayazit.com'));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
          onWillPop: () async {
            if( await _webViewController.canGoBack()){
              _webViewController.goBack();
              return false;
            }else{
              return true;
            }
          },

          child: WebViewWidget(
            controller: controller,
          ),

          onWebViewCreated: (WebViewController controller) {
            _webViewController = controller;
          }
      ),
    );
  }
}

