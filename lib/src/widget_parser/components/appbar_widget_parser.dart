import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class AppBarWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    AppBar appBarWidget = AppBar(
      title:
          map.containsKey("title")
              ? WidgetParserBuilder.buildFromMap(
                map["title"],
                buildContext,
                listener,
              )
              : null,
      leading:
          map.containsKey("leading")
              ? WidgetParserBuilder.buildFromMap(
                map["leading"],
                buildContext,
                listener,
              )
              : null,
      actions:
          map.containsKey("actions")
              ? WidgetParserBuilder.buildWidgets(
                map["actions"],
                buildContext,
                listener,
              )
              : null,
      centerTitle:
          map.containsKey("centerTitle") ? map["centerTitle"] as bool? : false,
      backgroundColor:
          map.containsKey("backgroundColor")
              ? parseHexColor(map["backgroundColor"])
              : null,
    );
    return appBarWidget;
  }

  @override
  String get widgetName => "AppBar";

  @override
  Type get widgetType => AppBar;
}
