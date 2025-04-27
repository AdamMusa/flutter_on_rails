import 'package:flutterx/imports/exports.dart';

Future init() async {
  await InAppWebViewController.setJavaScriptBridgeName("flutterx");
}
