import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class IndexedStackWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return IndexedStack(
      index: map.containsKey("index") ? map["index"] : 0,
      alignment:
          map.containsKey("alignment")
              ? parseAlignment(map["alignment"])!
              : AlignmentDirectional.topStart,
      textDirection:
          map.containsKey("textDirection")
              ? parseTextDirection(map["textDirection"])
              : null,
      children: WidgetParserBuilder.buildWidgets(
        map['children'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "IndexedStack";

  @override
  Type get widgetType => IndexedStack;
}
