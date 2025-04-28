import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class ExpandedWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Expanded(
      flex: map.containsKey("flex") ? map["flex"] : 1,
      child:
          WidgetParserBuilder.buildFromMap(
            map["child"],
            buildContext,
            listener,
          )!,
    );
  }

  @override
  String get widgetName => "Expanded";

  @override
  Type get widgetType => Expanded;
}
