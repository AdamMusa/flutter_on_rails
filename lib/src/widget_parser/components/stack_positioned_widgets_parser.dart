import 'package:flutter_on_rails/src/widget_parser/entry_widget_parser.dart';
import 'package:flutter_on_rails/src/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class PositionedWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Positioned(
      top: map.containsKey("top") ? map["top"]?.toDouble() : null,
      right: map.containsKey("right") ? map["right"]?.toDouble() : null,
      bottom: map.containsKey("bottom") ? map["bottom"]?.toDouble() : null,
      left: map.containsKey("left") ? map["left"]?.toDouble() : null,
      width: map.containsKey("width") ? map["width"]?.toDouble() : null,
      height: map.containsKey("height") ? map["height"]?.toDouble() : null,
      child:
          WidgetParserBuilder.buildFromMap(
            map["child"],
            buildContext,
            listener,
          )!,
    );
  }

  @override
  String get widgetName => "Positioned";

  @override
  Type get widgetType => Positioned;
}

class StackWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    return Stack(
      alignment:
          map.containsKey("alignment")
              ? parseAlignment(map["alignment"])!
              : AlignmentDirectional.topStart,
      textDirection:
          map.containsKey("textDirection")
              ? parseTextDirection(map["textDirection"])
              : null,
      fit: map.containsKey("fit") ? parseStackFit(map["fit"])! : StackFit.loose,
      clipBehavior:
          map.containsKey("clipBehavior")
              ? parseClip(map["clipBehavior"])!
              : Clip.hardEdge,
      children: WidgetParserBuilder.buildWidgets(
        map['children'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "Stack";

  @override
  Type get widgetType => Stack;
}
