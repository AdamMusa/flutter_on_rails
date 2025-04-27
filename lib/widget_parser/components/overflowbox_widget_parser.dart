import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/cupertino.dart';

class OverflowBoxWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return OverflowBox(
      alignment:
          map.containsKey("alignment")
              ? parseAlignment(map["alignment"])!
              : Alignment.center,
      minWidth: map.containsKey("minWidth") ? map['minWidth'] : null,
      maxWidth: map.containsKey("maxWidth") ? map['maxWidth'] : null,
      minHeight: map.containsKey("minHeight") ? map['minHeight'] : null,
      maxHeight: map.containsKey("maxHeight") ? map['maxHeight'] : null,
      child: WidgetParserBuilder.buildFromMap(
        map['child'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "OverflowBox";

  @override
  Type get widgetType => OverflowBox;
}
