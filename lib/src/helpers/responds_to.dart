import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_on_rails/src/imports/exports.dart';

bool isValidHexColor(String hexColor) {
  // Regular expression to match hex color codes (either #RRGGBB or #AARRGGBB)
  final hexRegex = RegExp(r'^(#|0x)?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{8})$');
  return hexRegex.hasMatch(hexColor);
}

Color hexToColor(String hexCode) {
  // Remove the '#' if it is present
  final hexColor = hexCode.replaceFirst('#', '');

  // Parse the color code into a Color with full opacity (0xFF)
  return Color(int.parse('0xFF$hexColor'));
}

Color? setBackgroundColor(AppNotifier provider) {
  if (provider.state.navapi.containsKey("backgroundColor")) {
    return hexToColor(provider.state.navapi["backgroundColor"]);
  }
  return null;
}

String setTitle(AppNotifier provider) {
  if (provider.state.navapi.containsKey("title")) {
    return provider.state.navapi["title"];
  }
  return "Flutter on Rails";
}

Color? setLeadingColor(AppNotifier provider) {
  final color = setBackgroundColor(provider);
  if (provider.state.navapi.containsKey("leadingColor")) {
    final leadingColor = hexToColor(provider.state.navapi["leadingColor"]);
    if (color != leadingColor) return leadingColor;
    return Colors.white;
  }
  return null;
}

Future<void> sinkKeyboard(controller, AppNotifier provider) async {
  await provider.state.controller!.evaluateJavascript(
    source: """
      (function() {
        document.querySelectorAll('input, textarea').forEach(function(element) {
          element.addEventListener('focus', function(){
          
            window.flutter_on_rails.callHandler('inputFocus', JSON.stringify({
              "keyboard": true
            }));
          });
        });
      })();
    """,
  );
}

Future showNativeKeyboard(value) async {
  if (value["keyboard"]) {
    return await SystemChannels.textInput.invokeMethod('TextInput.show');
  }
}

Widget setActionWidgetForForm(
  InAppWebViewController controller,
  AppNotifier provider,
  payload,
) {
  if (Platform.isIOS) {
    return TextButton(
      onPressed: () async {
        await controller.evaluateJavascript(
          source: """
          (function() {
            const button = document.getElementById('${provider.state.form["btn-id"]}');
            if (button) {
              button.click();
            }
          })();
        """,
        );
      },
      child: Text(
        payload["btnText"],
        style: TextStyle(color: hexToColor(payload["btnTextColor"])),
      ),
    );
  }
  return const SizedBox.shrink();
}
