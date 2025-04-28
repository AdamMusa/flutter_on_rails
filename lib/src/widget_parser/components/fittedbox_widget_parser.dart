import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class FittedBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return FittedBox(
      alignment:
          map.containsKey("alignment")
              ? parseAlignment(map["alignment"])!
              : Alignment.center,
      fit: map.containsKey("fit") ? parseBoxFit(map["fit"])! : BoxFit.contain,
      child: WidgetParserBuilder.buildFromMap(
        map["child"],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "FittedBox";

  @override
  Type get widgetType => FittedBox;
}
