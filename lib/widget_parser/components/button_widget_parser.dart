import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class ElevatedButtonParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    return ElevatedButton(
      onPressed: () {
        listener!.onClicked(clickEvent);
      },
      style: ButtonStyle(
        foregroundColor:
            map.containsKey("foregroundColor")
                ? WidgetStateProperty.all(parseHexColor(map["foregroundColor"]))
                : null,
        backgroundColor:
            map.containsKey("backgroundColor")
                ? WidgetStateProperty.all(parseHexColor(map["backgroundColor"]))
                : null,
        overlayColor:
            map.containsKey("overlayColor")
                ? WidgetStateProperty.all(parseHexColor(map["overlayColor"]))
                : null,
        shadowColor:
            map.containsKey("shadowColor")
                ? WidgetStateProperty.all(parseHexColor(map["shadowColor"]))
                : null,
        elevation:
            map.containsKey("elevation")
                ? WidgetStateProperty.all(map["elevation"])
                : null,
        padding:
            map.containsKey("padding")
                ? WidgetStateProperty.all(
                  parseEdgeInsetsGeometry(map["padding"]),
                )
                : null,
        textStyle:
            map.containsKey("textStyle")
                ? WidgetStateProperty.all(parseTextStyle(map["textStyle"]))
                : null,
        alignment:
            map.containsKey("alignment")
                ? parseAlignment(map["alignment"])
                : null,
      ),
      child: WidgetParserBuilder.buildFromMap(
        map['child'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "ElevatedButton";

  @override
  Type get widgetType => ElevatedButton;
}

class TextButtonParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    return TextButton(
      onPressed: () {
        listener!.onClicked(clickEvent);
      },
      style: ButtonStyle(
        foregroundColor:
            map.containsKey("foregroundColor")
                ? WidgetStateProperty.all(parseHexColor(map["foregroundColor"]))
                : null,
        backgroundColor:
            map.containsKey("backgroundColor")
                ? WidgetStateProperty.all(parseHexColor(map["backgroundColor"]))
                : null,
        overlayColor:
            map.containsKey("overlayColor")
                ? WidgetStateProperty.all(parseHexColor(map["overlayColor"]))
                : null,
        shadowColor:
            map.containsKey("shadowColor")
                ? WidgetStateProperty.all(parseHexColor(map["shadowColor"]))
                : null,
        elevation:
            map.containsKey("elevation")
                ? WidgetStateProperty.all(map["elevation"])
                : null,
        padding:
            map.containsKey("padding")
                ? WidgetStateProperty.all(
                  parseEdgeInsetsGeometry(map["padding"]),
                )
                : null,
        textStyle:
            map.containsKey("textStyle")
                ? WidgetStateProperty.all(parseTextStyle(map["textStyle"]))
                : null,
        alignment:
            map.containsKey("alignment")
                ? parseAlignment(map["alignment"])
                : null,
      ),
      child:
          WidgetParserBuilder.buildFromMap(
            map['child'],
            buildContext,
            listener,
          )!,
    );
  }

  @override
  String get widgetName => "TextButton";

  @override
  Type get widgetType => TextButton;
}
