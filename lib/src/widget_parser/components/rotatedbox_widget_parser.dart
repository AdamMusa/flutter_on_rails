import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class RotatedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return RotatedBox(
      quarterTurns: map['quarterTurns'],
      child: WidgetParserBuilder.buildFromMap(
        map["child"],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "RotatedBox";

  @override
  Type get widgetType => RotatedBox;
}
