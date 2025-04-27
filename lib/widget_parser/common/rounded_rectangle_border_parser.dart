import 'package:flutterx/widget_parser/utils.dart';
import 'package:flutter/material.dart';

class RoundedRectangleBorderParser {
  static RoundedRectangleBorder? parse(Map<String, dynamic>? map) {
    if (map == null) return null;
    return RoundedRectangleBorder(
      side: parseBorderSide(map['side']),
      borderRadius: parseBorderRadius(map['borderRadius']),
    );
  }
}
