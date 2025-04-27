// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutterx/widget_parser/entry_widget_parser.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.payload});
  String payload;
  @override
  Widget build(BuildContext context) {
    try {
      return WidgetParserBuilder.build(
        payload,
        context,
        DefaultClickListener(),
      )!;
    } catch (e) {
      debugPrint("Error parsing JSON payload: $e");
      return AppBar(title: const Text("Error Parsing AppBar"));
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DefaultClickListener implements ClickListener {
  @override
  void onClicked(String? event) {
    debugPrint("Receive click event: ${event ?? ""}");
  }
}
