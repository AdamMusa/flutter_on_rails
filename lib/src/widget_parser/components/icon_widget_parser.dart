import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/icons_helper.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class IconWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Icon(
      map.containsKey('data')
          ? getIconUsingPrefix(name: map['data'])
          : Icons.android,
      size: map.containsKey("size") ? map['size']?.toDouble() : null,
      color: map.containsKey('color') ? parseHexColor(map['color']) : null,
      semanticLabel:
          map.containsKey('semanticLabel') ? map['semanticLabel'] : null,
      textDirection:
          map.containsKey('textDirection')
              ? parseTextDirection(map['textDirection'])
              : null,
    );
  }

  @override
  String get widgetName => "Icon";

  @override
  Type get widgetType => Icon;
}
