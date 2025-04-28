import '../app_state/app_state.dart';
import 'package:minimal_mvn/minimal_mvn.dart';

class AppNotifier extends MMNotifier<AppState> {
  AppNotifier() : super(AppState());

  void setFormData(value) => notify(state.copyWith(form: value));
  void setIsRedirected(value) => notify(state.copyWith(isRedirected: value));

  void setProgress(value) {
    notify(state.copyWith(isLoading: false, progress: value / 100));
    if (state.progress == 1.0) {
      notify(state.copyWith(isLoading: true));
    }
  }

  void setLoading(value) => notify(state.copyWith(isLoading: value));
  void setController(value) => notify(state.copyWith(controller: value));
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

  void setAppBar(value) => notify(state.copyWith(appbar: value));
  void setError(value) => notify(state.copyWith(isPageLoadError: value));

  void setConnectivity(value) => notify(state.copyWith(isConnectivity: value));
  void setLinks(value) => notify(state.copyWith(links: value));
}
