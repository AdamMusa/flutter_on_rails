import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class AlignWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Align(
      alignment:
          map.containsKey("alignment")
              ? parseAlignment(map["alignment"])!
              : Alignment.center,
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
  String get widgetName => "Align";

  @override
  Type get widgetType => Align;
}
