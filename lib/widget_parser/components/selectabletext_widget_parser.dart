import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SelectableTextWidgetParser implements WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    // String? data = map['data'];
    String? textAlignString = map['textAlign'];
    int? maxLines = map['maxLines'];
    String? textDirectionString = map['textDirection'];
    //    double textScaleFactor = map['textScaleFactor'];
    TextSpan textSpan = const TextSpan();
    var textSpanParser = SelectableTextSpanParser();
    if (map.containsKey("textSpan")) {
      textSpan = textSpanParser.parse(map['textSpan'], listener);
    }

    return SelectableText.rich(
      textSpan,
      textAlign: parseTextAlign(textAlignString),
      maxLines: maxLines,
      textDirection: parseTextDirection(textDirectionString),
      style: map.containsKey('style') ? parseTextStyle(map['style']) : null,
      //        textScaleFactor: textScaleFactor,
    );
  }

  @override
  String get widgetName => "SelectableText";
  @override
  bool matchWidgetForExport(Widget? widget) => widget is SelectableText;

  @override
  Type get widgetType => SelectableText;
}

class SelectableTextSpanParser {
  TextSpan parse(Map<String, dynamic> map, ClickListener? listener) {
    String? clickEvent = map.containsKey("recognizer") ? map['recognizer'] : "";
    var textSpan = TextSpan(
      text: map['text'],
      style: parseTextStyle(map['style']),
      recognizer:
          TapGestureRecognizer()
            ..onTap = () {
              listener!.onClicked(clickEvent);
            },
      children: const [],
    );

    if (map.containsKey('children')) {
      parseChildren(textSpan, map['children'], listener);
    }

    return textSpan;
  }

  void parseChildren(
    TextSpan textSpan,
    List<dynamic> childrenSpan,
    ClickListener? listener,
  ) {
    for (var childmap in childrenSpan) {
      textSpan.children!.add(parse(childmap, listener));
    }
  }
}
