import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class RowWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Row(
      crossAxisAlignment:
          map.containsKey('crossAxisAlignment')
              ? parseCrossAxisAlignment(map['crossAxisAlignment'])
              : CrossAxisAlignment.center,
      mainAxisAlignment:
          map.containsKey('mainAxisAlignment')
              ? parseMainAxisAlignment(map['mainAxisAlignment'])
              : MainAxisAlignment.start,
      mainAxisSize:
          map.containsKey('mainAxisSize')
              ? parseMainAxisSize(map['mainAxisSize'])
              : MainAxisSize.max,
      textBaseline:
          map.containsKey('textBaseline')
              ? parseTextBaseline(map['textBaseline'])
              : null,
      textDirection:
          map.containsKey('textDirection')
              ? parseTextDirection(map['textDirection'])
              : null,
      verticalDirection:
          map.containsKey('verticalDirection')
              ? parseVerticalDirection(map['verticalDirection'])
              : VerticalDirection.down,
      children: WidgetParserBuilder.buildWidgets(
        map['children'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Row";

  @override
  Type get widgetType => Row;
}

class ColumnWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Column(
      crossAxisAlignment:
          map.containsKey('crossAxisAlignment')
              ? parseCrossAxisAlignment(map['crossAxisAlignment'])
              : CrossAxisAlignment.center,
      mainAxisAlignment:
          map.containsKey('mainAxisAlignment')
              ? parseMainAxisAlignment(map['mainAxisAlignment'])
              : MainAxisAlignment.start,
      mainAxisSize:
          map.containsKey('mainAxisSize')
              ? parseMainAxisSize(map['mainAxisSize'])
              : MainAxisSize.max,
      textBaseline:
          map.containsKey('textBaseline')
              ? parseTextBaseline(map['textBaseline'])
              : null,
      textDirection:
          map.containsKey('textDirection')
              ? parseTextDirection(map['textDirection'])
              : null,
      verticalDirection:
          map.containsKey('verticalDirection')
              ? parseVerticalDirection(map['verticalDirection'])
              : VerticalDirection.down,
      children: WidgetParserBuilder.buildWidgets(
        map['children'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Column";

  @override
  Type get widgetType => Column;
}
