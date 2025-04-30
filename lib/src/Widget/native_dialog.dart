import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

void showFlutterDialog(BuildContext context, Map<String, dynamic> payload) {
  final isIOS = Platform.isIOS;

  if (isIOS) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title:
                payload['title'] == null
                    ? const Text("Flutter on Rails")
                    : Text(payload['title']),
            content:
                (payload['content'] == null || payload['content'] == "")
                    ? const Text("This is a default text from Flutter on Rails")
                    : Text(payload['content']),
            actions: _buildActions(payload, context, isIOS),
          ),
    );
  } else {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title:
                payload['title'] == null
                    ? const Text("Flutter on Rails")
                    : Text(payload['title']),
            content:
                (payload['content'] == null || payload['content'] == "")
                    ? const Text("This is a default text from Flutter on Rails")
                    : Text(payload['content']),
            actions: _buildActions(payload, context, isIOS),
            backgroundColor:
                payload['backgroundColor'] ??
                Theme.of(context).dialogBackgroundColor,
            elevation: payload['elevation']?.toDouble() ?? 24.0,
            shape:
                payload['shape'] ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    payload['borderRadius']?.toDouble() ?? 8.0,
                  ),
                ),
            titlePadding: payload['titlePadding'] ?? const EdgeInsets.all(24.0),
            contentPadding:
                payload['contentPadding'] ??
                const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
            actionsPadding:
                payload['actionsPadding'] ?? const EdgeInsets.all(8.0),
            buttonPadding:
                payload['buttonPadding'] ?? const EdgeInsets.all(8.0),
            insetPadding:
                payload['insetPadding'] ??
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          ),
    );
  }
}

List<Widget> _buildActions(
  Map<String, dynamic> payload,
  BuildContext context,
  bool isIOS,
) {
  final actions = <Widget>[];

  if (payload['actions'] != null && payload['actions'] is List) {
    final actionList = payload['actions'] as List;
    for (var action in actionList) {
      if (action is Map<String, dynamic>) {
        if (isIOS) {
          actions.add(
            CupertinoDialogAction(
              child: Text(action['text'] ?? ''),
              onPressed: () {
                Navigator.of(context).pop();
                if (action['onPressed'] != null) {
                  action['onPressed']();
                }
              },
              isDefaultAction: action['isDefaultAction'] ?? false,
              isDestructiveAction: action['isDestructiveAction'] ?? false,
            ),
          );
        } else {
          actions.add(
            TextButton(
              child: Text(action['text'] ?? ''),
              onPressed: () {
                Navigator.of(context).pop();
                if (action['onPressed'] != null) {
                  action['onPressed']();
                }
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    action['isDestructiveAction'] == true
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
              ),
            ),
          );
        }
      }
    }
  }

  // Add default dismiss action if no actions are provided
  if (actions.isEmpty) {
    if (isIOS) {
      actions.add(
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    } else {
      actions.add(
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
    }
  }

  return actions;
}
