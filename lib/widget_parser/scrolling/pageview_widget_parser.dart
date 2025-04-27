import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutter/widgets.dart';

class PageViewWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    var scrollDirection = Axis.vertical;
    if (map.containsKey("scrollDirection") &&
        "horizontal" == map["scrollDirection"]) {
      scrollDirection = Axis.horizontal;
    }
    return PageView(
      scrollDirection: scrollDirection,
      reverse: map.containsKey("reverse") ? map["reverse"] : false,
      pageSnapping:
          map.containsKey("pageSnapping") ? map["pageSnapping"] : true,
      children: WidgetParserBuilder.buildWidgets(
        map['children'],
        buildContext,
        listener,
      ),
    );
  }

  @override
  String get widgetName => "PageView";

  @override
  Type get widgetType => PageView;
}
