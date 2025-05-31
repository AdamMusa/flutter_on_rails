// ignore_for_file: library_private_types_in_public_api, deprecated_member_use
import 'package:flutter_on_rails/src/Widget/bottom_navigation_bar.dart';
import 'package:flutter_on_rails/src/Widget/custom_app_bar.dart';
import 'package:flutter_on_rails/src/helpers/webview_helper.dart';
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
  PullToRefreshController? pullToRefreshController;
  bool isNavigating = false;
  bool isLoaded = false;
  final provider = appstatemanager.notifier;

  @override
  void initState() {
    super.initState();
    pullToRefreshController = pullToRefreshControllerHelper;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        if (provider.state.isConnectivity) {
          return const SizedBox(child: Center(child: Text("data")));
        } else if (provider.state.isPageLoadError) {
          return Container(color: Colors.red);
        } else {
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
                    initialSettings: inAppWebViewSettings,
                    pullToRefreshController: pullToRefreshController,
                    onWebViewCreated: (controller) async {
                      provider.setController(controller);
                      await provider.setUserAgent();
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
                          // RunJs().handleNav(provider);
                          // You can parse and use this in Flutter
                        },
                      );
                    },
                    onLoadStart: (controller, url) async {
                      // Set appropriate user agent for the URL
                      await provider.setUserAgent();
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
                    onLoadHttpError: (
                      controller,
                      url,
                      statusCode,
                      description,
                    ) {
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
        }
      },
    );
  }
}
