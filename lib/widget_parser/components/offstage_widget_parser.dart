import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutter/cupertino.dart';

class OffstageWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Offstage(
      offstage: map.containsKey("offstage") ? map['offstage'] : true,
      child: WidgetParserBuilder.buildFromMap(
        map['child'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Offstage";

  @override
  Type get widgetType => Offstage;
}
