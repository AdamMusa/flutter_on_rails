import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class ListTileWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    bool isThreeLine =
        map.containsKey("isThreeLine") ? map["isThreeLine"] : false;
    EdgeInsetsGeometry? contentPadding =
        map.containsKey("contentPadding")
            ? parseEdgeInsetsGeometry(map["contentPadding"])
            : null;
    bool? dense = map.containsKey("dense") ? map["dense"] : false;
    bool enabled = map.containsKey("enabled") ? map["enabled"] : true;
    Widget? leading =
        map.containsKey("leading")
            ? WidgetParserBuilder.buildFromMap(
              map["leading"],
              buildContext,
              listener,
            )
            : null;
    bool selected = map.containsKey("selected") ? map["selected"] : false;
    Widget? subtitle =
        map.containsKey("subtitle")
            ? WidgetParserBuilder.buildFromMap(
              map["subtitle"],
              buildContext,
              listener,
            )
            : null;
    Widget? title =
        map.containsKey("title")
            ? WidgetParserBuilder.buildFromMap(
              map["title"],
              buildContext,
              listener,
            )
            : null;
    Widget? trailing =
        map.containsKey("trailing")
            ? WidgetParserBuilder.buildFromMap(
              map["trailing"],
              buildContext,
              listener,
            )
            : null;
    String? tapEvent = map.containsKey("tapEvent") ? map["tapEvent"] : null;

    return ListTile(
      isThreeLine: isThreeLine,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
      dense: dense,
      contentPadding: contentPadding,
      enabled: enabled,
      onTap: () {
        if (listener != null && tapEvent != null) {
          listener.onClicked(tapEvent);
        }
      },
      selected: selected,
    );
  }

  @override
  String get widgetName => "ListTile";

  @override
  Type get widgetType => ListTile;
}
