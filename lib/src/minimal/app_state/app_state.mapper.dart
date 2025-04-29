// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'app_state.dart';

class AppStateMapper extends ClassMapperBase<AppState> {
  AppStateMapper._();

  static AppStateMapper? _instance;
  static AppStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AppStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AppState';

  static String _$appbar(AppState v) => v.appbar;
  static const Field<AppState, String> _f$appbar =
      Field('appbar', _$appbar, opt: true, def: '');
  static bool _$isLoading(AppState v) => v.isLoading;
  static const Field<AppState, bool> _f$isLoading =
      Field('isLoading', _$isLoading, opt: true, def: true);
  static bool _$isPageLoadError(AppState v) => v.isPageLoadError;
  static const Field<AppState, bool> _f$isPageLoadError =
      Field('isPageLoadError', _$isPageLoadError, opt: true, def: false);
  static bool _$isConnectivity(AppState v) => v.isConnectivity;
  static const Field<AppState, bool> _f$isConnectivity =
      Field('isConnectivity', _$isConnectivity, opt: true, def: false);
  static bool _$isRedirected(AppState v) => v.isRedirected;
  static const Field<AppState, bool> _f$isRedirected =
      Field('isRedirected', _$isRedirected, opt: true, def: false);
  static double _$progress(AppState v) => v.progress;
  static const Field<AppState, double> _f$progress =
      Field('progress', _$progress, opt: true, def: 0);
  static int _$index(AppState v) => v.index;
  static const Field<AppState, int> _f$index =
      Field('index', _$index, opt: true, def: 0);
  static List<Map<String, dynamic>> _$links(AppState v) => v.links;
  static const Field<AppState, List<Map<String, dynamic>>> _f$links =
      Field('links', _$links, opt: true, def: const []);
  static Map<String, dynamic> _$navapi(AppState v) => v.navapi;
  static const Field<AppState, Map<String, dynamic>> _f$navapi =
      Field('navapi', _$navapi, opt: true, def: const {});
  static Map<String, dynamic> _$form(AppState v) => v.form;
  static const Field<AppState, Map<String, dynamic>> _f$form =
      Field('form', _$form, opt: true, def: const {});
  static InAppWebViewController? _$controller(AppState v) => v.controller;
  static const Field<AppState, InAppWebViewController> _f$controller =
      Field('controller', _$controller, opt: true);
  static InAppWebViewController? _$nextScreenController(AppState v) =>
      v.nextScreenController;
  static const Field<AppState, InAppWebViewController> _f$nextScreenController =
      Field('nextScreenController', _$nextScreenController, opt: true);

  @override
  final MappableFields<AppState> fields = const {
    #appbar: _f$appbar,
    #isLoading: _f$isLoading,
    #isPageLoadError: _f$isPageLoadError,
    #isConnectivity: _f$isConnectivity,
    #isRedirected: _f$isRedirected,
    #progress: _f$progress,
    #index: _f$index,
    #links: _f$links,
    #navapi: _f$navapi,
    #form: _f$form,
    #controller: _f$controller,
    #nextScreenController: _f$nextScreenController,
  };

  static AppState _instantiate(DecodingData data) {
    return AppState(
        appbar: data.dec(_f$appbar),
        isLoading: data.dec(_f$isLoading),
        isPageLoadError: data.dec(_f$isPageLoadError),
        isConnectivity: data.dec(_f$isConnectivity),
        isRedirected: data.dec(_f$isRedirected),
        progress: data.dec(_f$progress),
        index: data.dec(_f$index),
        links: data.dec(_f$links),
        navapi: data.dec(_f$navapi),
        form: data.dec(_f$form),
        controller: data.dec(_f$controller),
        nextScreenController: data.dec(_f$nextScreenController));
  }

  @override
  final Function instantiate = _instantiate;

  static AppState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AppState>(map);
  }

  static AppState fromJson(String json) {
    return ensureInitialized().decodeJson<AppState>(json);
  }
}

mixin AppStateMappable {
  String toJson() {
    return AppStateMapper.ensureInitialized()
        .encodeJson<AppState>(this as AppState);
  }

  Map<String, dynamic> toMap() {
    return AppStateMapper.ensureInitialized()
        .encodeMap<AppState>(this as AppState);
  }

  AppStateCopyWith<AppState, AppState, AppState> get copyWith =>
      _AppStateCopyWithImpl<AppState, AppState>(
          this as AppState, $identity, $identity);
  @override
  String toString() {
    return AppStateMapper.ensureInitialized().stringifyValue(this as AppState);
  }

  @override
  bool operator ==(Object other) {
    return AppStateMapper.ensureInitialized()
        .equalsValue(this as AppState, other);
  }

  @override
  int get hashCode {
    return AppStateMapper.ensureInitialized().hashValue(this as AppState);
  }
}

extension AppStateValueCopy<$R, $Out> on ObjectCopyWith<$R, AppState, $Out> {
  AppStateCopyWith<$R, AppState, $Out> get $asAppState =>
      $base.as((v, t, t2) => _AppStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AppStateCopyWith<$R, $In extends AppState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Map<String, dynamic>,
      ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>> get links;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get navapi;
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get form;
  $R call(
      {String? appbar,
      bool? isLoading,
      bool? isPageLoadError,
      bool? isConnectivity,
      bool? isRedirected,
      double? progress,
      int? index,
      List<Map<String, dynamic>>? links,
      Map<String, dynamic>? navapi,
      Map<String, dynamic>? form,
      InAppWebViewController? controller,
      InAppWebViewController? nextScreenController});
  AppStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AppStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AppState, $Out>
    implements AppStateCopyWith<$R, AppState, $Out> {
  _AppStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AppState> $mapper =
      AppStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Map<String, dynamic>,
          ObjectCopyWith<$R, Map<String, dynamic>, Map<String, dynamic>>>
      get links => ListCopyWith($value.links,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(links: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get navapi => MapCopyWith($value.navapi,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(navapi: v));
  @override
  MapCopyWith<$R, String, dynamic, ObjectCopyWith<$R, dynamic, dynamic>>
      get form => MapCopyWith($value.form,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(form: v));
  @override
  $R call(
          {String? appbar,
          bool? isLoading,
          bool? isPageLoadError,
          bool? isConnectivity,
          bool? isRedirected,
          double? progress,
          int? index,
          List<Map<String, dynamic>>? links,
          Map<String, dynamic>? navapi,
          Map<String, dynamic>? form,
          Object? controller = $none,
          Object? nextScreenController = $none}) =>
      $apply(FieldCopyWithData({
        if (appbar != null) #appbar: appbar,
        if (isLoading != null) #isLoading: isLoading,
        if (isPageLoadError != null) #isPageLoadError: isPageLoadError,
        if (isConnectivity != null) #isConnectivity: isConnectivity,
        if (isRedirected != null) #isRedirected: isRedirected,
        if (progress != null) #progress: progress,
        if (index != null) #index: index,
        if (links != null) #links: links,
        if (navapi != null) #navapi: navapi,
        if (form != null) #form: form,
        if (controller != $none) #controller: controller,
        if (nextScreenController != $none)
          #nextScreenController: nextScreenController
      }));
  @override
  AppState $make(CopyWithData data) => AppState(
      appbar: data.get(#appbar, or: $value.appbar),
      isLoading: data.get(#isLoading, or: $value.isLoading),
      isPageLoadError: data.get(#isPageLoadError, or: $value.isPageLoadError),
      isConnectivity: data.get(#isConnectivity, or: $value.isConnectivity),
      isRedirected: data.get(#isRedirected, or: $value.isRedirected),
      progress: data.get(#progress, or: $value.progress),
      index: data.get(#index, or: $value.index),
      links: data.get(#links, or: $value.links),
      navapi: data.get(#navapi, or: $value.navapi),
      form: data.get(#form, or: $value.form),
      controller: data.get(#controller, or: $value.controller),
      nextScreenController:
          data.get(#nextScreenController, or: $value.nextScreenController));

  @override
  AppStateCopyWith<$R2, AppState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AppStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
