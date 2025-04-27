import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class ScaffoldWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    var scaffoldWidget = Scaffold(
      appBar:
          map.containsKey("appBar")
              ? WidgetParserBuilder.buildFromMap(
                    map["appBar"],
                    buildContext,
                    listener,
                  )
                  as PreferredSizeWidget?
              : null,
      body:
          map.containsKey("body")
              ? WidgetParserBuilder.buildFromMap(
                map["body"],
                buildContext,
                listener,
              )
              : null,
      floatingActionButton:
          map.containsKey("floatingActionButton")
              ? WidgetParserBuilder.buildFromMap(
                map["floatingActionButton"],
                buildContext,
                listener,
              )
              : null,
      backgroundColor:
          map.containsKey("backgroundColor")
              ? parseHexColor(map["backgroundColor"])
              : null,
    );

    return scaffoldWidget;
  }

  @override
  String get widgetName => "Scaffold";

  @override
  Type get widgetType => Scaffold;
}
