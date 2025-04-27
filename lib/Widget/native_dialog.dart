import 'package:flutter/material.dart';

void showFlutterDialog(BuildContext context, Map<String, dynamic> payload) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: payload['title'] == null
          ? const Text("Flutter on Rails")
          : Text(payload['title']),
      content: (payload['content'] == null || payload['content'] == "")
          ? const Text("This is a default text from Flutter on Rails")
          : Text(payload['content']),
    ),
  );
}
