import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class OpacityWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Opacity(
      opacity: map["opacity"]?.toDouble(),
      alwaysIncludeSemantics:
          map.containsKey("alwaysIncludeSemantics")
              ? map["alwaysIncludeSemantics"]
              : false,
      child: WidgetParserBuilder.buildFromMap(
        map["child"],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Opacity";

  @override
  Type get widgetType => Opacity;
}
