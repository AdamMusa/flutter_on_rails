// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_on_rails/src/Widget/bottom_navigation_bar.dart';
import 'package:flutter_on_rails/src/Widget/custom_app_bar.dart';
import 'package:flutter_on_rails/src/imports/exports.dart';
import 'package:flutter_on_rails/src/navigation/handle_navigation.dart'
    show HandleNavigation;
import 'package:flutter_on_rails/src/services/run_js.dart';
import 'next_screen.dart';
import '../../minimal/manager/manager.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  MainScreen({super.key, this.url = "http://localhost:3000"});
  String? url = "";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );
  PullToRefreshController? pullToRefreshController;
  bool isNavigating = false;
  String? defaultUserAgent;
  bool isLoaded = false;
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
    if (provider.state.controller == null) return;

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
    if (provider.state.isConnectivity) {
      return const SizedBox();
    }
    if (provider.state.isPageLoadError) {
      return Container(color: Colors.red);
    }

    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar:
              provider.state.appbar != ''
                  ? CustomAppBar(payload: provider.state.appbar)
                  : null,

          body: SafeArea(
            maintainBottomViewPadding: true,
            bottom: false,
            child: Stack(
              children: [
                if (provider.state.isLoading)
                  const Center(child: CircularProgressIndicator.adaptive()),
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url!)),
                  initialOptions: InAppWebViewGroupOptions(
                    ios: IOSInAppWebViewOptions(
                      allowsInlineMediaPlayback: true,
                      allowsBackForwardNavigationGestures: true,
                      allowsLinkPreview: true,
                      isFraudulentWebsiteWarningEnabled: true,
                      sharedCookiesEnabled: true,
                    ),
                  ),
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
                    provider.setController(controller);
                    await _setUserAgent();
                    // Add JavaScript handler to listen for postMessage calls
                    provider.state.controller!.addJavaScriptHandler(
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
                    provider.state.controller!.addJavaScriptHandler(
                      handlerName: "actionHandler",
                      callback: (args) {
                        final actionJson = args[0]; // Your JSON string
                        provider.setNavApi(json.decode(actionJson));
                        // You can parse and use this in Flutter
                      },
                    );
                    // Add keyboard focus handler
                    provider.state.controller!.addJavaScriptHandler(
                      handlerName: "inputFocus",
                      callback: (args) {
                        SystemChannels.textInput.invokeMethod('TextInput.show');
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
                    final currentUrl = await controller.getUrl();
                    provider.setCurrentUrl(currentUrl.toString());
                    await RunJs().handleNav(provider);
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
                    if (url.toString() != widget.url! &&
                        provider.state.isRedirected == false) {}
                  },
                  shouldOverrideUrlLoading: (
                    controller,
                    navigationAction,
                  ) async {
                    return NavigationActionPolicy.ALLOW;
                  },
                ),
              ],
            ),
          ),

          bottomNavigationBar: buildBottomNavigationBar(
            context,
            provider,
            widget.url!,
          ),
        );
      },
    );
  }
}
