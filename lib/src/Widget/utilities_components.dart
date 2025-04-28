import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void openSnackBar(BuildContext context, Map<String, dynamic> payload) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        payload['title'] ?? "Default Snackbar",
      ),
    ),
  );
}

void share(Map<String, dynamic> payload) {
  Share.share(payload['title'], subject: payload['content'] ?? '');
}

// SystemChannels.textInput.invokeMethod('TextInput.show')
