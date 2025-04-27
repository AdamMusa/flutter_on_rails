import 'package:flutterx/widget_parser/entry_widget_parser.dart';
import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/widgets.dart';

class AssetImageWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    String name = map['name'];
    String? semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics =
        map.containsKey('excludeFromSemantics')
            ? map['excludeFromSemantics']
            : false;
    double? scale = map.containsKey("scale") ? map['scale']?.toDouble() : null;
    double? width = map.containsKey('width') ? map['width']?.toDouble() : null;
    double? height =
        map.containsKey('height') ? map['height']?.toDouble() : null;
    Color? color =
        map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode? colorBlendMode =
        map.containsKey('colorBlendMode')
            ? parseBlendMode(map['colorBlendMode'])
            : null;
    BoxFit? fit = map.containsKey('fit') ? parseBoxFit(map['fit']) : null;
    Alignment alignment =
        map.containsKey('alignment')
            ? parseAlignment(map['alignment'])!
            : Alignment.center;
    ImageRepeat repeat =
        map.containsKey('repeat')
            ? parseImageRepeat(map['repeat'])!
            : ImageRepeat.noRepeat;
    Rect? centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection =
        map.containsKey('matchTextDirection')
            ? map['matchTextDirection']
            : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality =
        map.containsKey('filterQuality')
            ? parseFilterQuality(map['filterQuality'])!
            : FilterQuality.low;

    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var widget = Image.asset(
      name,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  String get widgetName => "AssetImage";

  @override
  Type get widgetType => AssetImage;

  bool _isMatchAssetImageType(Widget? widget) {
    if (widget is Image) {
      if (widget.image is AssetImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var resizeImage = widget.image as ResizeImage;
        return resizeImage.imageProvider is AssetImage;
      }
    }
    return false;
  }

  bool _isMatchExactAssetImageType(Widget? widget) {
    if (widget is Image) {
      if (widget.image is ExactAssetImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var resizeImage = widget.image as ResizeImage;
        return resizeImage.imageProvider is ExactAssetImage;
      }
    }
    return false;
  }

  @override
  bool matchWidgetForExport(Widget? widget) =>
      _isMatchAssetImageType(widget) || _isMatchExactAssetImageType(widget);
}

class NetworkImageWidgetParser extends WidgetParser {
  @override
  Widget parse(
    Map<String, dynamic> map,
    BuildContext buildContext,
    ClickListener? listener,
  ) {
    String src = map['src'];
    String? semanticLabel =
        map.containsKey('semanticLabel') ? map['semanticLabel'] : null;
    bool excludeFromSemantics =
        map.containsKey('excludeFromSemantics')
            ? map['excludeFromSemantics']
            : false;
    double scale = map.containsKey("scale") ? map['scale']?.toDouble() : 1.0;
    double? width = map.containsKey('width') ? map['width']?.toDouble() : null;
    double? height =
        map.containsKey('height') ? map['height']?.toDouble() : null;
    Color? color =
        map.containsKey('color') ? parseHexColor(map['color']) : null;
    BlendMode? colorBlendMode =
        map.containsKey('colorBlendMode')
            ? parseBlendMode(map['colorBlendMode'])
            : null;
    BoxFit? fit = map.containsKey('fit') ? parseBoxFit(map['fit']) : null;
    Alignment alignment =
        map.containsKey('alignment')
            ? parseAlignment(map['alignment'])!
            : Alignment.center;
    ImageRepeat repeat =
        map.containsKey('repeat')
            ? parseImageRepeat(map['repeat'])!
            : ImageRepeat.noRepeat;
    Rect? centerSlice =
        map.containsKey('centerSlice') ? parseRect(map['centerSlice']) : null;
    bool matchTextDirection =
        map.containsKey('matchTextDirection')
            ? map['matchTextDirection']
            : false;
    bool gaplessPlayback =
        map.containsKey('gaplessPlayback') ? map['gaplessPlayback'] : false;
    FilterQuality filterQuality =
        map.containsKey('filterQuality')
            ? parseFilterQuality(map['filterQuality'])!
            : FilterQuality.low;

    String? clickEvent =
        map.containsKey("click_event") ? map['click_event'] : "";

    var widget = Image.network(
      src,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      filterQuality: filterQuality,
    );

    if (listener != null && (clickEvent != null && clickEvent.isNotEmpty)) {
      return GestureDetector(
        onTap: () {
          listener.onClicked(clickEvent);
        },
        child: widget,
      );
    }
    return widget;
  }

  @override
  String get widgetName => "NetworkImage";

  @override
  Type get widgetType => NetworkImage;

  @override
  bool matchWidgetForExport(Widget? widget) {
    if (widget is Image) {
      if (widget.image is NetworkImage) {
        return true;
      }
      if (widget.image is ResizeImage) {
        var t = widget.image as ResizeImage;
        return t.imageProvider is NetworkImage;
      }
    }
    return false;
  }
}
