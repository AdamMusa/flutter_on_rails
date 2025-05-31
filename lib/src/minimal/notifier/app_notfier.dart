import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform;

import '../app_state/app_state.dart';
import 'package:minimal_mvn/minimal_mvn.dart';

class AppNotifier extends MMNotifier<AppState> {
  AppNotifier() : super(AppState());

  void setFormData(value) => notify(state.copyWith(form: value));
  void setCurrentUrl(value) => notify(state.copyWith(currentUrl: value));
  void setIsRedirected(value) => notify(state.copyWith(isRedirected: value));

  void setProgress(value) {
    notify(state.copyWith(isLoading: false, progress: value / 100));
    if (state.progress == 1.0) {
      notify(state.copyWith(isLoading: true));
    }
  }

  void setLoading(value) => notify(state.copyWith(isLoading: value));
  void setController(value) => notify(state.copyWith(controller: value));
  void setNextScreenController(value) =>
      notify(state.copyWith(nextScreenController: value));
  void setIndex(value) => notify(state.copyWith(index: value));
  void setNavigable(value) {
    Map<String, dynamic> navapi = state.navapi;
    navapi["navigable"] = value;
    notify(state.copyWith(navapi: navapi));
  }

  void setNavApi(value) {
    if (state.navapi.isNotEmpty && state.navapi["navigable"]) return;
    notify(state.copyWith(navapi: value));
  }

  Future<void> setUserAgent() async {
    if (state.controller == null) return;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        notify(
          state.copyWith(
            userAgent:
                'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
          ),
        );
        break;
      case TargetPlatform.iOS:
        notify(
          state.copyWith(
            userAgent:
                'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
          ),
        );
        break;
      default:
      // notify(state.copyWith(userAgent: value));
    }
  }

  void setAppBar(value) => notify(state.copyWith(appbar: value));
  void setError(value) => notify(state.copyWith(isPageLoadError: value));

  void setConnectivity(value) => notify(state.copyWith(isConnectivity: value));
  void setLinks(value) => notify(state.copyWith(links: value));
}
