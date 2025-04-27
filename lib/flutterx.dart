// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutterx/Widget/bottom_navigation_bar.dart';
import 'package:flutterx/Widget/custom_app_bar.dart';
import 'package:flutterx/imports/exports.dart';
import 'package:flutterx/navigation/handle_navigation.dart'
    show HandleNavigation;
import 'package:flutterx/services/run_js.dart';
import 'next_screen.dart';
import 'src/minimal/manager/manager.dart';

class FlutterX extends StatefulWidget {
  FlutterX({super.key, this.url = "http://localhost:3000"});
  String? url = "";
  @override
  _FlutterXState createState() => _FlutterXState();
}

class _FlutterXState extends State<FlutterX> {
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;
  bool isNavigating = false;
  String? defaultUserAgent;
  bool isLoaded = false;
  bool isNotAuth = true;
  bool hasShownAuthMessage = false;
  String? lastProcessedUrl;
  String? initialAuthUrl;
  Map data = {};
  String userAgent =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";
  final provider = appstatemanager.notifier;

  @override
  void initState() {
    super.initState();

    pullToRefreshController =
        kIsWeb ||
                ![
                  TargetPlatform.iOS,
                  TargetPlatform.android,
                ].contains(defaultTargetPlatform)
            ? null
            : PullToRefreshController(
              settings: pullToRefreshSettings,
              onRefresh: () async {
                if (defaultTargetPlatform == TargetPlatform.android) {
                  provider.state.controller?.reload();
                } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                  provider.state.controller?.loadUrl(
                    urlRequest: URLRequest(
                      url: await provider.state.controller?.getUrl(),
                    ),
                  );
                }
              },
            );
  }

  Future<void> _setUserAgent() async {
    if (webViewController == null) return;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Android WebView user agent without "wv" identifier
        userAgent =
            'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';
        break;
      case TargetPlatform.iOS:
        // iOS Safari user agent
        userAgent =
            'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1';
        break;
      default:
        // Desktop Chrome user agent for other platforms
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Rebuilding ...");
    print("Get ${provider.state.navapi} ...");
    if (provider.state.isConnectivity) {
      return const SizedBox();
    }
    if (provider.state.isPageLoadError) {
      return Container(color: Colors.red);
    }

    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return SafeArea(
          bottom: false,
          child: Scaffold(
            appBar:
                provider.state.appbar != ''
                    ? CustomAppBar(payload: provider.state.appbar)
                    : null,
            body: Stack(
              children: [
                if (provider.state.isLoading)
                  const Center(child: CircularProgressIndicator.adaptive()),
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url!)),
                  initialSettings: InAppWebViewSettings(
                    userAgent: userAgent,
                    isInspectable: kDebugMode,
                    javaScriptEnabled: true,
                    useShouldOverrideUrlLoading: true,
                    allowsLinkPreview: true,
                    allowsBackForwardNavigationGestures: true,
                    allowsInlineMediaPlayback: true,
                    mediaPlaybackRequiresUserGesture: false,
                    javaScriptCanOpenWindowsAutomatically: true,
                    supportZoom: true,
                    incognito: false,
                    cacheEnabled: true,
                    transparentBackground: false,
                    disableContextMenu: false,
                    disableHorizontalScroll: false,
                    disableVerticalScroll: false,
                    disableDefaultErrorPage: false,
                    useWideViewPort: true,
                  ),
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                    await _setUserAgent();
                    // Store the controller in the provider
                    provider.setController(controller);
                    // Add JavaScript handler to listen for postMessage calls

                    controller.addJavaScriptHandler(
                      handlerName: 'Flutter',
                      callback: (args) {
                        // Args are the messages sent from JavaScript
                        Map<String, dynamic> message = json.decode(args[0]);
                        if (message['type'] == 'AppBar') {
                          provider.setAppBar(json.encode(message));
                          message.toString();
                        } else {
                          RunJs().handleJavaScriptMessages(context, message);
                        }
                      },
                    );
                    controller.addJavaScriptHandler(
                      handlerName: "actionHandler",
                      callback: (args) {
                        final actionJson = args[0]; // Your JSON string
                        provider.setNavApi(json.decode(actionJson));
                        print("Received from JS: ${json.decode(actionJson)}");
                        // You can parse and use this in Flutter
                      },
                    );
                  },
                  onLoadStart: (controller, url) async {
                    // Set appropriate user agent for the URL
                    await _setUserAgent();
                  },
                  onProgressChanged: (controller, progress) {
                    if (provider.state.progress == 100) {
                      pullToRefreshController?.endRefreshing();
                    }
                    provider.setProgress(progress);
                  },
                  onReceivedServerTrustAuthRequest: (
                    controller,
                    challenge,
                  ) async {
                    return ServerTrustAuthResponse(
                      action: ServerTrustAuthResponseAction.PROCEED,
                    );
                  },
                  onLoadHttpError: (controller, url, statusCode, description) {
                    pullToRefreshController?.endRefreshing();
                  },
                  onReceivedHttpError: (controller, request, errorResponse) {
                    pullToRefreshController?.endRefreshing();
                    provider.setError(true);
                  },
                  onLoadStop: (controller, url) async {
                    isNavigating = false;
                    isLoaded = true;
                    pullToRefreshController?.endRefreshing();
                    provider.setLoading(false);
                    await controller.evaluateJavascript(
                      source: """
                        (function() {
                          document.addEventListener("click", function(event) {
                            // Correct selector for data_frails_action (with an underscore)
                            const link = event.target.closest("a[data_frails_action]");
                            console.log("Link clicked:", link);  // Check if the link is found
                            if (!link) return;
                            const action = link.getAttribute("data_frails_action");
                            console.log("Action:", action); 
                            if (window.flutterx) {
                              window.flutterx.callHandler('actionHandler', action);
                            }
                          });
                        })();
                      """,
                    );
                    await RunJs().runJavaScriptAndHideBottomNav(provider);
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) async {
                    if (provider.state.navapi.containsKey('navigable') &&
                        provider.state.navapi["navigable"]) {
                      HandleNavigation().navigate(
                        context: context,
                        transition: provider.state.navapi["animate"],
                        action: provider.state.navapi["action"],
                        child: NextPage(url: url.toString()),
                      );
                    }
                    if (url != widget.url! &&
                        provider.state.isRedirected == false) {}
                  },
                  shouldOverrideUrlLoading: (
                    controller,
                    navigationAction,
                  ) async {
                    final url = navigationAction.request.url;

                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ],
            ),
            bottomNavigationBar: buildBottomNavigationBar(
              provider,
              widget.url!,
            ),
          ),
        );
      },
    );
  }
}
