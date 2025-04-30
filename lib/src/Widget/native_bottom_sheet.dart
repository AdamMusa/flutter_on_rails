import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

void showFlutterBottomSheet(
  BuildContext context,
  Map<String, dynamic> payload,
) {
  final isIOS = Platform.isIOS;

  if (isIOS) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: payload['isDismissible'] ?? true,
      builder:
          (BuildContext context) => CupertinoActionSheet(
            title: payload['title'] != null ? Text(payload['title']) : null,
            message:
                (payload['content'] == null || payload['content'] == "")
                    ? const Text('This is a Bottom Sheet')
                    : Text(payload['content']),
            actions:
                payload['actions'] != null
                    ? [
                      for (var action in payload['actions'])
                        CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context);
                            if (action['onPressed'] != null) {
                              action['onPressed']();
                            }
                          },
                          child: Text(action['text'] ?? ''),
                          isDefaultAction: action['isDefaultAction'] ?? false,
                          isDestructiveAction:
                              action['isDestructiveAction'] ?? false,
                        ),
                    ]
                    : null,
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ),
    );
  } else {
    showModalBottomSheet(
      isDismissible: payload['isDismissible'] ?? true,
      elevation: payload['elevation'] ?? 8.0,
      context: context,
      builder:
          (_) => Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child:
                (payload['content'] == null || payload['content'] == "")
                    ? const Center(child: Text('This is a Bottom Sheet'))
                    : Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (payload['title'] != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              payload['title'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        Text(payload['content']),
                        if (payload['actions'] != null)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                for (var action in payload['actions'])
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        if (action['onPressed'] != null) {
                                          action['onPressed']();
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            action['isDestructiveAction'] ==
                                                    true
                                                ? Theme.of(
                                                  context,
                                                ).colorScheme.error
                                                : null,
                                      ),
                                      child: Text(action['text'] ?? ''),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
          ),
    );
  }
}
