import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kDebugMode, kIsWeb;
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart' show TargetPlatform;
import 'package:flutter_inappwebview/flutter_inappwebview.dart'
    show InAppWebViewSettings;
import 'package:flutter_on_rails/src/imports/exports.dart'
    show PullToRefreshController, PullToRefreshSettings, URLRequest;
import 'package:flutter_on_rails/src/minimal/manager/manager.dart'
    show appstatemanager;

final provider = appstatemanager.notifier;

final inAppWebViewSettings = InAppWebViewSettings(
  userAgent: provider.state.userAgent,
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
);

PullToRefreshSettings pullToRefreshSettingsHelper = PullToRefreshSettings(
  color: Colors.blue,
);

PullToRefreshController? pullToRefreshControllerHelper =
    kIsWeb ||
            ![
              TargetPlatform.iOS,
              TargetPlatform.android,
            ].contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
          settings: pullToRefreshSettingsHelper,
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
