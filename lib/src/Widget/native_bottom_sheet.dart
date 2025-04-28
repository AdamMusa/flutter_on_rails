import 'package:flutter/material.dart';

void showFlutterBottomSheet(BuildContext context, payload) {
  showModalBottomSheet(
    isDismissible: payload['isDismissible'] ?? true,
    elevation: payload['elevation'],
    context: context,
    builder: (_) => SizedBox(
      height: 300,
      width: double.infinity,
      child: (payload["content"] == null || payload['content'] == "")
          ? const Center(
              child: Text('This is a Bottom Sheet'),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                Text(payload["title"]),
                Text(payload["content"]),
              ],
            ),
    ),
  );
}
