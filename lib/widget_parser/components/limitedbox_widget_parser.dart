import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutter/material.dart';

class LimitedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return LimitedBox(
      maxWidth: map.containsKey("maxWidth") ? map['maxWidth'] : double.infinity,
      maxHeight:
          map.containsKey("maxHeight") ? map['maxHeight'] : double.infinity,
      child: WidgetParserBuilder.buildFromMap(
        map['child'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "LimitedBox";

  @override
  Type get widgetType => LimitedBox;
}
