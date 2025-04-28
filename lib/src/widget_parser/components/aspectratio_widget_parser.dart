import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class AspectRatioWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return AspectRatio(
      aspectRatio: map["aspectRatio"]?.toDouble(),
      child: WidgetParserBuilder.buildFromMap(
        map["child"],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "AspectRatio";

  @override
  Type get widgetType => AspectRatio;
}
