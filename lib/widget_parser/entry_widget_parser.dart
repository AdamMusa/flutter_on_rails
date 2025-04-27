library dynamic_widget;

import 'dart:convert';

import 'package:flutterx/widget_parser/components/align_widget_parser.dart';
import 'package:flutterx/widget_parser/components/appbar_widget_parser.dart';
import 'package:flutterx/widget_parser/components/aspectratio_widget_parser.dart';
import 'package:flutterx/widget_parser/components/baseline_widget_parser.dart';
import 'package:flutterx/widget_parser/components/button_widget_parser.dart';
import 'package:flutterx/widget_parser/components/card_widget_parser.dart';
import 'package:flutterx/widget_parser/components/center_widget_parser.dart';
import 'package:flutterx/widget_parser/components/container_widget_parser.dart';
import 'package:flutterx/widget_parser/components/divider_widget_parser.dart';
import 'package:flutterx/widget_parser/components/dropcaptext_widget_parser.dart';
import 'package:flutterx/widget_parser/components/expanded_widget_parser.dart';
import 'package:flutterx/widget_parser/components/fittedbox_widget_parser.dart';
import 'package:flutterx/widget_parser/components/icon_widget_parser.dart';
import 'package:flutterx/widget_parser/components/image_widget_parser.dart';
import 'package:flutterx/widget_parser/components/indexedstack_widget_parser.dart';
import 'package:flutterx/widget_parser/components/limitedbox_widget_parser.dart';
import 'package:flutterx/widget_parser/components/listtile_widget_parser.dart';
import 'package:flutterx/widget_parser/components/offstage_widget_parser.dart';
import 'package:flutterx/widget_parser/components/opacity_widget_parser.dart';
import 'package:flutterx/widget_parser/components/padding_widget_parser.dart';
import 'package:flutterx/widget_parser/components/placeholder_widget_parser.dart';
import 'package:flutterx/widget_parser/components/row_column_widget_parser.dart';
import 'package:flutterx/widget_parser/components/safearea_widget_parser.dart';
import 'package:flutterx/widget_parser/components/scaffold_widget_parser.dart';
import 'package:flutterx/widget_parser/components/selectabletext_widget_parser.dart';
import 'package:flutterx/widget_parser/components/sizedbox_widget_parser.dart';
import 'package:flutterx/widget_parser/components/stack_positioned_widgets_parser.dart';
import 'package:flutterx/widget_parser/components/text_widget_parser.dart';
import 'package:flutterx/widget_parser/components/wrap_widget_parser.dart';
import 'package:flutterx/widget_parser/scrolling/gridview_widget_parser.dart';
import 'package:flutterx/widget_parser/scrolling/listview_widget_parser.dart';
import 'package:flutterx/widget_parser/scrolling/pageview_widget_parser.dart';
import 'package:flutterx/widget_parser/scrolling/single_child_scroll_view_widget_parser.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

import 'package:flutterx/widget_parser/components/cliprrect_widget_parser.dart';
import 'package:flutterx/widget_parser/components/overflowbox_widget_parser.dart';
import 'package:flutterx/widget_parser/components/rotatedbox_widget_parser.dart';

class WidgetParserBuilder {
  static final Logger log = Logger('DynamicWidget');

  static final _parsers = [
    ContainerWidgetParser(),
    TextWidgetParser(),
    SelectableTextWidgetParser(),
    RowWidgetParser(),
    ColumnWidgetParser(),
    AssetImageWidgetParser(),
    NetworkImageWidgetParser(),
    PlaceholderWidgetParser(),
    GridViewWidgetParser(),
    ListViewWidgetParser(),
    PageViewWidgetParser(),
    ExpandedWidgetParser(),
    PaddingWidgetParser(),
    CenterWidgetParser(),
    AlignWidgetParser(),
    AspectRatioWidgetParser(),
    FittedBoxWidgetParser(),
    BaselineWidgetParser(),
    StackWidgetParser(),
    PositionedWidgetParser(),
    IndexedStackWidgetParser(),
    ExpandedSizedBoxWidgetParser(),
    SizedBoxWidgetParser(),
    OpacityWidgetParser(),
    WrapWidgetParser(),
    DropCapTextParser(),
    IconWidgetParser(),
    ClipRRectWidgetParser(),
    SafeAreaWidgetParser(),
    ListTileWidgetParser(),
    ScaffoldWidgetParser(),
    AppBarWidgetParser(),
    LimitedBoxWidgetParser(),
    OffstageWidgetParser(),
    OverflowBoxWidgetParser(),
    ElevatedButtonParser(),
    DividerWidgetParser(),
    TextButtonParser(),
    RotatedBoxWidgetParser(),
    CardParser(),
    SingleChildScrollViewParser(),
  ];

  static final _widgetNameParserMap = <String, WidgetParser>{};

  static bool _defaultParserInited = false;

  // use this method for adding your custom widget parser
  static void addParser(WidgetParser parser) {
    log.info(
      "add custom widget parser, make sure you don't overwirte the widget type.",
    );
    _parsers.add(parser);
    _widgetNameParserMap[parser.widgetName] = parser;
  }

  static void initDefaultParsersIfNess() {
    if (!_defaultParserInited) {
      for (var parser in _parsers) {
        _widgetNameParserMap[parser.widgetName] = parser;
      }
      _defaultParserInited = true;
    }
  }

  static Widget? build(
    String json,
    BuildContext buildContext,
    ClickListener listener,
  ) {
    initDefaultParsersIfNess();
    Map<String, dynamic> map = jsonDecode(json);
    ClickListener listener0 = listener;
    Widget? widget = buildFromMap(map, buildContext, listener0);
    return widget;
  }

  static Widget? buildFromMap(
    Map<String, dynamic>? map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    // print(map);

    initDefaultParsersIfNess();
    if (map == null) {
      return null;
    }

    String? widgetName = map['type'];
    if (widgetName == null) {
      return null;
    }

    WidgetParser? parser = _widgetNameParserMap[widgetName];

    if (parser != null) {
      return parser.parse(map, buildContext, listener);
    }
    log.warning("Not support parser type: $widgetName");
    return null;
  }

  static List<Widget> buildWidgets(
    List<dynamic> values,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    initDefaultParsersIfNess();
    List<Widget> rt = [];
    for (Map<String, dynamic> value in values) {
      var buildFromMap2 = buildFromMap(value, buildContext, listener);
      if (buildFromMap2 != null) {
        rt.add(buildFromMap2);
      }
    }
    return rt;
  }
}

/// extends this class to make a Flutter widget parser.
abstract class WidgetParser {
  /// parse the json map into a flutter widget.
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  );

  /// the widget type name for example:
  /// {"type" : "Text", "data" : "Denny"}
  /// if you want to make a flutter Text widget, you should implement this
  /// method return "Text", for more details, please see
  /// @TextWidgetParser
  String get widgetName;

  /// match current widget
  Type get widgetType;

  bool matchWidgetForExport(Widget? widget) => widget.runtimeType == widgetType;
}

abstract class ClickListener {
  void onClicked(String? event);
}

class NonResponseWidgetClickListener implements ClickListener {
  static final Logger log = Logger('NonResponseWidgetClickListener');

  @override
  void onClicked(String? event) {
    log.info("receiver click event: ${event!}");
    debugPrint("receiver click event: $event");
  }
}
