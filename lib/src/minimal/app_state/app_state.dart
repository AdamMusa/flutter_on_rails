import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
part "app_state.mapper.dart";

@MappableClass()
class AppState with AppStateMappable {
  bool isLoading = true;
  bool isPageLoadError = false;
  bool isConnectivity = false;
  bool isRedirected = false;
  double progress = 0;
  int index = 0;
  List<Map<String, dynamic>> links = [];
  Map<String, dynamic> navapi = {};
  Map<String, dynamic> form = {};
  String appbar = '';
  InAppWebViewController? controller;
}
