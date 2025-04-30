import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../enum/transition_dialog.dart';
import '../Widget/native_dialog.dart';

class DialogAnimation {
  static TransitionDialog? _getTransitionFromString(String? animate) {
    if (animate == null || animate.isEmpty) return TransitionDialog.none;
    switch (animate.toLowerCase()) {
      case 'rotate':
        return TransitionDialog.rotate;
      case 'scale':
        return TransitionDialog.scale;
      case 'right':
        return TransitionDialog.right;
      case 'left':
        return TransitionDialog.left;
      case 'downtoup':
        return TransitionDialog.downToUp;
      case 'toptodown':
        return TransitionDialog.topToDown;
      default:
        return TransitionDialog.none;
    }
  }

  static Future<void> openDialog(
    BuildContext context,
    Map<String, dynamic> payload,
  ) async {
    final dialogTransition = _getTransitionFromString(payload['animate']);

    if (dialogTransition == TransitionDialog.none) {
      showFlutterDialog(context, payload);
      return;
    }

    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (ctx, a1, a2) {
        return _buildDialog(ctx, payload);
      },
      transitionBuilder: (ctx, a1, a2, child) {
        Widget animatedChild;

        switch (dialogTransition) {
          case TransitionDialog.rotate:
            animatedChild = Transform.rotate(
              angle: math.pi * 2 * a1.value,
              child: child,
            );
            break;
          case TransitionDialog.scale:
            var curve = Curves.easeInOut.transform(a1.value);
            animatedChild = Transform.scale(scale: curve, child: child);
            break;
          case TransitionDialog.right:
            animatedChild = SlideTransition(
              transformHitTests: false,
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOut)).animate(a1),
              child: child,
            );
            break;
          case TransitionDialog.left:
            animatedChild = SlideTransition(
              transformHitTests: false,
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOut)).animate(a1),
              child: child,
            );
            break;
          case TransitionDialog.downToUp:
            animatedChild = SlideTransition(
              transformHitTests: false,
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOut)).animate(a1),
              child: child,
            );
            break;
          case TransitionDialog.topToDown:
            animatedChild = SlideTransition(
              transformHitTests: false,
              position: Tween<Offset>(
                begin: const Offset(0.0, -1.0),
                end: Offset.zero,
              ).chain(CurveTween(curve: Curves.easeOut)).animate(a1),
              child: child,
            );
            break;
          default:
            animatedChild = child;
        }

        return animatedChild;
      },
    );
  }

  static Widget _buildDialog(
    BuildContext context,
    Map<String, dynamic> payload,
  ) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    if (isIOS) {
      return CupertinoAlertDialog(
        title:
            payload['title'] == null
                ? const Text("Flutter on Rails")
                : Text(payload['title']),
        content:
            (payload['content'] == null || payload['content'] == "")
                ? const Text("This is a default text from Flutter on Rails")
                : Text(payload['content']),
        actions: _buildActions(payload, context, isIOS),
      );
    } else {
      return AlertDialog(
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
        actionsPadding: payload['actionsPadding'] ?? const EdgeInsets.all(8.0),
        buttonPadding: payload['buttonPadding'] ?? const EdgeInsets.all(8.0),
        insetPadding:
            payload['insetPadding'] ??
            const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      );
    }
  }

  static List<Widget> _buildActions(
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
}
