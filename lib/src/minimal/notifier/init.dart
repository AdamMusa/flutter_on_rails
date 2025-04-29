import 'package:flutter_on_rails/src/imports/exports.dart';
import 'package:flutter/foundation.dart';

Future init() async {
  await InAppWebViewController.setJavaScriptBridgeName("flutter_on_rails");

  // Platform-specific initialization
  if (!kIsWeb) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        // Add any platform-specific initialization here
        break;
      default:
        break;
    }
  }
}
