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

  static bool _$isLoading(AppState v) => v.isLoading;
  static const Field<AppState, bool> _f$isLoading =
      Field('isLoading', _$isLoading, mode: FieldMode.member);
  static bool _$isPageLoadError(AppState v) => v.isPageLoadError;
  static const Field<AppState, bool> _f$isPageLoadError =
      Field('isPageLoadError', _$isPageLoadError, mode: FieldMode.member);
  static bool _$isConnectivity(AppState v) => v.isConnectivity;
  static const Field<AppState, bool> _f$isConnectivity =
      Field('isConnectivity', _$isConnectivity, mode: FieldMode.member);
  static bool _$isRedirected(AppState v) => v.isRedirected;
  static const Field<AppState, bool> _f$isRedirected =
      Field('isRedirected', _$isRedirected, mode: FieldMode.member);
  static double _$progress(AppState v) => v.progress;
  static const Field<AppState, double> _f$progress =
      Field('progress', _$progress, mode: FieldMode.member);
  static int _$index(AppState v) => v.index;
  static const Field<AppState, int> _f$index =
      Field('index', _$index, mode: FieldMode.member);
  static List<Map<String, dynamic>> _$links(AppState v) => v.links;
  static const Field<AppState, List<Map<String, dynamic>>> _f$links =
      Field('links', _$links, mode: FieldMode.member);
  static Map<String, dynamic> _$navapi(AppState v) => v.navapi;
  static const Field<AppState, Map<String, dynamic>> _f$navapi =
      Field('navapi', _$navapi, mode: FieldMode.member);
  static Map<String, dynamic> _$form(AppState v) => v.form;
  static const Field<AppState, Map<String, dynamic>> _f$form =
      Field('form', _$form, mode: FieldMode.member);
  static String _$appbar(AppState v) => v.appbar;
  static const Field<AppState, String> _f$appbar =
      Field('appbar', _$appbar, mode: FieldMode.member);
  static InAppWebViewController? _$controller(AppState v) => v.controller;
  static const Field<AppState, InAppWebViewController> _f$controller =
      Field('controller', _$controller, mode: FieldMode.member);

  @override
  final MappableFields<AppState> fields = const {
    #isLoading: _f$isLoading,
    #isPageLoadError: _f$isPageLoadError,
    #isConnectivity: _f$isConnectivity,
    #isRedirected: _f$isRedirected,
    #progress: _f$progress,
    #index: _f$index,
    #links: _f$links,
    #navapi: _f$navapi,
    #form: _f$form,
    #appbar: _f$appbar,
    #controller: _f$controller,
  };

  static AppState _instantiate(DecodingData data) {
    return AppState();
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
  $R call();
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
  $R call() => $apply(FieldCopyWithData({}));
  @override
  AppState $make(CopyWithData data) => AppState();

  @override
  AppStateCopyWith<$R2, AppState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AppStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
