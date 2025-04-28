import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class PlaceholderWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Placeholder(
      color:
          map.containsKey('color')
              ? parseHexColor(map['color'])!
              : const Color(0xFF455A64),
      strokeWidth:
          map.containsKey('strokeWidth') ? map['strokeWidth']?.toDouble() : 2.0,
      fallbackWidth:
          map.containsKey('fallbackWidth')
              ? map['fallbackWidth']?.toDouble()
              : 400.0,
      fallbackHeight:
          map.containsKey('fallbackHeight')
              ? map['fallbackHeight']?.toDouble()
              : 400.0,
    );
  }

  @override
  String get widgetName => "Placeholder";

  @override
  Type get widgetType => Placeholder;
}
