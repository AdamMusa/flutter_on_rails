import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class DividerWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Divider(
      height: map["height"],
      thickness: map["thickness"],
      indent: map["indent"],
      endIndent: map["endIndent"],
      color: parseHexColor(map['color']),
    );
  }

  @override
  String get widgetName => "Divider";

  @override
  Type get widgetType => Divider;
}
