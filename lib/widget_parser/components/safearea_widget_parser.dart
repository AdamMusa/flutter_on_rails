import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class SafeAreaWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    var left = map.containsKey("left") ? map["left"] : true;
    var right = map.containsKey("right") ? map["right"] : true;
    var top = map.containsKey("top") ? map["top"] : true;
    var bottom = map.containsKey("bottom") ? map["bottom"] : true;
    var edgeInsets =
        map.containsKey("minimum")
            ? parseEdgeInsetsGeometry(map['minimum'])!
            : EdgeInsets.zero;
    var maintainBottomViewPadding =
        map.containsKey("maintainBottomViewPadding")
            ? map["maintainBottomViewPadding"]
            : false;
    return SafeArea(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      minimum: edgeInsets as EdgeInsets,
      maintainBottomViewPadding: maintainBottomViewPadding,
      child:
          WidgetParserBuilder.buildFromMap(
            map["child"],
            buildContext,
            listener,
          )!,
    );
  }

  @override
  String get widgetName => "SafeArea";

  @override
  Type get widgetType => SafeArea;
}
