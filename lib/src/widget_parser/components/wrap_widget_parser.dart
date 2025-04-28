import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class WrapWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Wrap(
      direction:
          map.containsKey("direction")
              ? parseAxis(map["direction"])
              : Axis.horizontal,
      alignment:
          map.containsKey("alignment")
              ? parseWrapAlignment(map["alignment"])
              : WrapAlignment.start,
      spacing: map.containsKey("spacing") ? map["spacing"]?.toDouble() : 0.0,
      runAlignment:
          map.containsKey("runAlignment")
              ? parseWrapAlignment(map["runAlignment"])
              : WrapAlignment.start,
      runSpacing:
          map.containsKey("runSpacing") ? map["runSpacing"]?.toDouble() : 0.0,
      crossAxisAlignment:
          map.containsKey("crossAxisAlignment")
              ? parseWrapCrossAlignment(map["crossAxisAlignment"])
              : WrapCrossAlignment.start,
      textDirection:
          map.containsKey("textDirection")
              ? parseTextDirection(map["textDirection"])
              : null,
      verticalDirection:
          map.containsKey("verticalDirection")
              ? parseVerticalDirection(map["verticalDirection"])
              : VerticalDirection.down,
      children: WidgetParserBuilder.buildWidgets(
        map['children'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Wrap";

  @override
  Type get widgetType => Wrap;
}
