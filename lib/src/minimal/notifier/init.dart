import 'package:flutter_on_rails/src/imports/exports.dart';

Future init() async {
  await InAppWebViewController.setJavaScriptBridgeName("flutter_on_rails");
}
