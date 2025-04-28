// ignore_for_file: deprecated_member_use

import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class TextWidgetParser implements WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    String? data = map['data'];
    String? textAlignString = map['textAlign'];
    String? overflow = map['overflow'];
    int? maxLines = map['maxLines'];
    String? semanticsLabel = map['semanticsLabel'];
    bool? softWrap = map['softWrap'];
    String? textDirectionString = map['textDirection'];
    double? textScaleFactor = map['textScaleFactor']?.toDouble();
    TextStyle? style =
        map.containsKey('style') ? parseTextStyle(map['style']) : null;

    TextSpan textSpan;

    if (map.containsKey("textSpan")) {
      // If textSpan data is provided, parse it
      textSpan = TextSpanParser().parse(map['textSpan'], listener);
    } else {
      // Fallback: Create a simple TextSpan using the `data` field
      textSpan = TextSpan(text: data, style: style);
    }

    return Text.rich(
      textSpan,
      textAlign: parseTextAlign(textAlignString),
      overflow: parseTextOverflow(overflow),
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      textDirection: parseTextDirection(textDirectionString),
      textScaleFactor: textScaleFactor,
    );
  }

  @override
  String get widgetName => "Text";
  @override
  Type get widgetType => Text;

  @override
  bool matchWidgetForExport(Widget? widget) => widget is Text;
}

class TextSpanParser {
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

    return textSpan;
  }
}
