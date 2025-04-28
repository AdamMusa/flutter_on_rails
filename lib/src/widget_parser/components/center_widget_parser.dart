import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class CenterWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Center(
      widthFactor:
          map.containsKey("widthFactor")
              ? map["widthFactor"]?.toDouble()
              : null,
      heightFactor:
          map.containsKey("heightFactor")
              ? map["heightFactor"]?.toDouble()
              : null,
      child: WidgetParserBuilder.buildFromMap(
        map["child"],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Center";

  @override
  Type get widgetType => Center;
}
