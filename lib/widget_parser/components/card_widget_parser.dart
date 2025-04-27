import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/common/rounded_rectangle_border_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class CardParser extends WidgetParser {
  @override
  String get widgetName => 'Card';

  @override
  Type get widgetType => Card;

  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    final Color? color = parseHexColor(map['color']);
    final Color? shadowColor = parseHexColor(map['shadowColor']);
    final double? elevation = map['elevation'];
    final bool borderOnForeground = map['borderOnForeground'];
    final EdgeInsetsGeometry? margin = parseEdgeInsetsGeometry(map['margin']);
    final bool semanticContainer = map['semanticContainer'];
    final Clip clipBehavior = parseClipBehavior(map['clipBehavior']);
    final Map<String, dynamic>? childMap = map['child'];
    final Widget? child =
        childMap == null
            ? null
            : WidgetParserBuilder.buildFromMap(
              childMap,
              buildContext,
              listener,
            );
    final RoundedRectangleBorder? shape = RoundedRectangleBorderParser.parse(
      map['shape'],
    );

    var card = Card(
      color: color,
      shadowColor: shadowColor,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      margin: margin,
      semanticContainer: semanticContainer,
      clipBehavior: clipBehavior,
      child: child,
    );
    return card;
  }
}
