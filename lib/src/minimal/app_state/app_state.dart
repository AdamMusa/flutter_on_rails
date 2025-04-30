import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
part "app_state.mapper.dart";

@MappableClass()
class AppState with AppStateMappable {
  AppState({
    this.appbar = '',
    this.isLoading = true,
    this.isPageLoadError = false,
    this.isConnectivity = false,
    this.isRedirected = false,
    this.progress = 0,
    this.index = 0,
    this.links = const [],
    this.navapi = const {},
    this.form = const {},
    this.controller,
    this.currentUrl = "",
    this.nextScreenController,
  });
  bool isLoading;
  bool isPageLoadError;
  bool isConnectivity;
  bool isRedirected;
  double progress;
  int index;
  List<Map<String, dynamic>> links;
  Map<String, dynamic> navapi;
  Map<String, dynamic> form;
  String appbar;
  String currentUrl;
  InAppWebViewController? controller;
  InAppWebViewController? nextScreenController;
}
