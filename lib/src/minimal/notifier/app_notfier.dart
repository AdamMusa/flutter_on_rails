import '../app_state/app_state.dart';
import 'package:minimal_mvn/minimal_mvn.dart';

class AppNotifier extends MMNotifier<AppState> {
  AppNotifier() : super(AppState());

  void setFormData(value) => notify(state.form = value);
  void setIsRedirected(value) => notify(state.isRedirected = value);

  void setProgress(newValue) {
    state.progress = newValue / 100;
    state.isLoading = false;
    if (state.progress == 1.0) {
      state.isLoading = true;
    }
    notifyListeners();
  }

  void setLoading(value) => notify(state.isLoading = value);
  void setController(value) => notify(state.controller = value);
  void setIndex(value) => notify(state.index = value);
  void setNavigable(value) => notify(state.navapi["navigable"] = value);

  void setNavApi(value) {
    if (state.navapi.isNotEmpty && state.navapi["navigable"]) return;
    state.navapi = value;
    notifyListeners();
  }

  void setAppBar(value) => notify(state.appbar = value);
  void setError(value) => notify(state.isPageLoadError = value);

  void setConnectivity(value) => notify(state.isConnectivity = value);
  void setLinks(value) => notify(state.links = value);
}
