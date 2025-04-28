// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_on_rails/src/helpers/responds_to.dart';
import 'package:flutter_on_rails/src/minimal/manager/manager.dart';
import 'package:flutter_on_rails/src/services/run_js.dart';
import 'package:logging/logging.dart';

// Add at the top of the file, outside any class
final _logger = Logger('NextScreen');

class NextPage extends StatelessWidget {
  NextPage({super.key, required this.url});

  final provider = appstatemanager.notifier;
  final String url;
  String userAgent =
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";
  Future<void> _setUserAgent() async {
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
    return ListenableBuilder(
      listenable: provider,
      builder: (context, _) {
        return SafeArea(
          bottom: false,
          child: Scaffold(
            appBar:
                provider.state.navapi["action"] != "replace"
                    ? AppBar(
                      backgroundColor: setBackgroundColor(provider),
                      title: Text(
                        setTitle(provider),
                        style: TextStyle(color: setLeadingColor(provider)),
                      ),
                      leading: IconButton(
                        color: setLeadingColor(provider),
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () async {
                          provider.setNavigable(false);
                          await provider.state.controller!.goBack();
                          Navigator.of(context).pop();
                        },
                      ),
                      actions:
                          provider.state.form.isEmpty
                              ? null
                              : [
                                setActionWidgetForForm(
                                  provider,
                                  provider.state.form,
                                ),
                              ],
                    )
                    : null,
            body: InAppWebView(
              initialUrlRequest: URLRequest(url: WebUri(url)),
              onWebViewCreated: (
                InAppWebViewController webViewController,
              ) async {
                webViewController = provider.state.controller!;
                await _setUserAgent();
                provider.state.controller!.addJavaScriptHandler(
                  handlerName: "inputFocus",
                  callback: (args) async {
                    final actionJson = args[0];
                    await showNativeKeyboard(json.decode(actionJson));
                    _logger.info(
                      "Received from JS: ${json.decode(actionJson.toString())}",
                    );
                  },
                );
              },
              // initialSettings: InAppWebViewSettings(
              //   userAgent: userAgent,
              //   isInspectable: kDebugMode,
              //   javaScriptEnabled: true,
              //   useShouldOverrideUrlLoading: true,
              //   allowsLinkPreview: true,
              //   allowsBackForwardNavigationGestures: true,
              //   allowsInlineMediaPlayback: true,
              //   mediaPlaybackRequiresUserGesture: false,
              //   javaScriptCanOpenWindowsAutomatically: true,
              //   supportZoom: true,
              //   incognito: false,
              //   cacheEnabled: true,
              //   transparentBackground: false,
              //   disableContextMenu: false,
              //   disableHorizontalScroll: false,
              //   disableVerticalScroll: false,
              //   disableDefaultErrorPage: false,
              //   useWideViewPort: true,
              // ),
              onLoadStart: (controller, url) async {
                // Set appropriate user agent for the URL
                // await _setUserAgent();
              },
              onLoadStop: (controller, url) async {
                await RunJs().handleForm(provider);
                await sinkKeyboard(controller, provider);
              },
              // onReceivedServerTrustAuthRequest: (controller, challenge) async {
              //   return ServerTrustAuthResponse(
              //     action: ServerTrustAuthResponseAction.PROCEED,
              //   );
              // },
              // shouldOverrideUrlLoading: (controller, navigationAction) async {
              //   return NavigationActionPolicy.ALLOW;
              // },
            ),
          ),
        );
      },
    );
  }
}
