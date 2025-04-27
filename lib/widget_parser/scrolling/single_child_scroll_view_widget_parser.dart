import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class SingleChildScrollViewParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }

    var clipBehaviorString = map['clipBehavior'];
    return SingleChildScrollView(
      reverse: map.containsKey('reverse') ? map['reverse'] : false,
      clipBehavior: parseClipBehavior(clipBehaviorString),
      padding:
          map.containsKey("padding")
              ? parseEdgeInsetsGeometry(map["padding"])!
              : EdgeInsets.zero,
      scrollDirection: scrollDirection,
      child: WidgetParserBuilder.buildFromMap(
        map['child'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "SingleChildScrollView";

  @override
  Type get widgetType => SingleChildScrollView;
}
