import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class BaselineWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Baseline(
      baseline: map["baseline"]?.toDouble(),
      baselineType:
          map["baselineType"] == "alphabetic"
              ? TextBaseline.alphabetic
              : TextBaseline.ideographic,
      child: WidgetParserBuilder.buildFromMap(
        map["child"],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Baseline";

  @override
  Type get widgetType => Baseline;
}
