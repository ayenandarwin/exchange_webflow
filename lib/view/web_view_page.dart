// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// class WebViewPage extends StatelessWidget {
//   const WebViewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ;
//     return Scaffold(
//       body: SafeArea(
//         child: InAppWebView(
//           // initialUrlRequest: URLRequest(url: WebUri("https://www.sarpaynantaw.com/web/payapp/login")),
//           initialUrlRequest: URLRequest(
//               url: WebUri("https://www.sarpaynantaw.com/web/money/login")),
//           androidOnPermissionRequest: (controller, origin, resources) async {
//             return PermissionRequestResponse(
//               resources: resources,
//               action: PermissionRequestResponseAction.GRANT,
//             );
//           },
//           onReceivedServerTrustAuthRequest: (controller, challenge) async {
//             return ServerTrustAuthResponse(
//                 action: ServerTrustAuthResponseAction.PROCEED);
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late InAppWebViewController webViewController; // WebView controller
  double progress = 0; // For loading progress indicator

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        if (await webViewController.canGoBack()) {
          webViewController.goBack(); // Go back in WebView
          return false; // Prevent default back behavior
        }
        return true; // Exit app if no back history in WebView
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   title: const Text("WebView App"),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.refresh),
          //       onPressed: () {
          //         webViewController.reload(); // Reload the WebView
          //       },
          //     ),
          //   ],
          // ),
          body: Column(
            children: [
              // Linear progress bar for loading
              progress < 1.0
                  ? LinearProgressIndicator(
                      value: progress,
                      color: Colors.blue,
                      backgroundColor: Colors.black45,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri("https://www.sarpaynantaw.com/web/money/login"),
                  ),
                  onWebViewCreated: (controller) {
                    webViewController = controller; // Set the controller
                  },
                  onProgressChanged: (controller, progressValue) {
                    setState(() {
                      progress = progressValue / 100; // Update progress value
                    });
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT,
                    );
                  },
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
