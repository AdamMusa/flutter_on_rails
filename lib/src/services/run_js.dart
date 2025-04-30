import 'package:flutter_on_rails/src/animation/dialog_animation.dart';
import 'package:flutter_on_rails/src/imports/exports.dart';

class RunJs {
  Future<void> runJavaScriptAndHideBottomNav(AppNotifier provider) async {
    try {
      String? result =
          await provider.state.controller!.evaluateJavascript(
                source: """
      (() => {
        const nav = document.querySelector('[data-frails-bottom-tabs]');
        if (!nav) return JSON.stringify([]);
        const links = nav.querySelectorAll('a');

        return JSON.stringify([...links].map(link => {
          const iconData = link.dataset.icon ? JSON.parse(link.dataset.icon) : {};

          // Use the spread operator to combine essential link attributes and the icon data
          return Object.assign({
            text: link.textContent.trim(),
            url: link.href
          }, iconData);
        }));
      })();
    """,
              )
              as String?;

      if (result != null) {
        // Ensure both the keys and values are cast to String
        List<Map<String, dynamic>> links = List<Map<String, dynamic>>.from(
          (json.decode(result) as List).map(
            (link) => Map<String, dynamic>.from(
              link as Map<dynamic, dynamic>,
            ), // Cast each entry to Map<String, String>
          ),
        );

        if (links.length > 1) {
          provider.setLinks(links);
        }
      }

      // Hide the bottom navigation if it exists
      await provider.state.controller!.evaluateJavascript(
        source: """
        (() => {
          const nav = document.querySelector('[data-frails-bottom-tabs]');
          if (nav) {
            nav.style.display = 'none';
          }
        })();
      """,
      );
    } catch (e) {
      debugPrint('Error in runJavaScriptAndHideBottomNav: $e');
    }
  }

  void handleJavaScriptMessages(
    BuildContext context,
    Map<String, dynamic> payload,
  ) {
    if (payload.isNotEmpty) {
      final String? component = payload['component'];

      // Handle based on the component field in the message
      final actions = {
        "licence":
            () => showAboutDialog(
              context: context,
              applicationName: "Flutter on Rails",
            ),
        "bottomsheet": () => showFlutterBottomSheet(context, payload),
        "snackbar": () => openSnackBar(context, payload),
        "dialog": () => DialogAnimation.openDialog(context, payload),
        "share": () => share(payload),
      };

      // If the component matches, call the corresponding function.
      // Check if the component exists and call the corresponding function
      if (actions.containsKey(component)) {
        actions[component]?.call(); // Call the function if it exists
      } else {
        // Show error page if no match is found
      }
    }
  }

  handleForm(InAppWebViewController controller, AppNotifier provider) async {
    try {
      String? result =
          await controller.evaluateJavascript(
                source: """
    (() => {
      const div = document.querySelector('[data-frails-form]');
      if (!div) return null;

      const dataAttr = div.getAttribute('data-frails-form');
      if (!dataAttr) return null;

      try {
        return JSON.stringify(JSON.parse(dataAttr));
      } catch (e) {
        return null;
      }
    })();
    """,
              )
              as String?;

      if (result != null) {
        Map<String, dynamic> formData = Map<String, dynamic>.from(
          json.decode(result),
        );

        // You can now use formData, for example:
        debugPrint('SnackBar enabled: ${formData["snackBar"]}');
        debugPrint('Content:  ${formData["content"]}');

        // You can also store it in a Provider
        provider.setFormData(formData);

        // // // Hide the button if it exists
        // controller.evaluateJavascript(
        //   source: """
        //  (function() {
        //   const style = document.createElement('style');
        //   style.innerHTML = "#${formData["btn-id"]} { display: none !important; }";
        //   document.head.appendChild(style);
        // })();
        // """,
        // );
      }
    } catch (e) {
      debugPrint('Error in handleForm: \$e');
    }
  }

  handleNav(AppNotifier provider) {
    provider.state.controller!.evaluateJavascript(
      source: """
    (function() {
      document.addEventListener("click", function(event) {
        const link = event.target.closest("a[data_frails_navigation]");
        console.log("Link clicked:", link);
        if (!link) return;
        const action = link.getAttribute("data_frails_navigation");
        console.log("Ok i get the response here ...;:", action); 
        if (window.flutter_on_rails && window.flutter_on_rails.callHandler) {
          window.flutter_on_rails.callHandler('actionHandler', action);
        } else {
          console.warn("flutter_on_rails or callHandler is not defined");
        }
      });
    })();
    """,
    );
  }

  // Inject keyboard focus handling JavaScript
  // await provider.state.controller!.evaluateJavascript(
  //   source: """
  //     (function() {
  //       document.addEventListener('focus', function(e) {
  //         if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') {
  //           window.flutter_on_rails.callHandler('inputFocus');
  //         }
  //       }, true);
  //     })();
  //   """,
  // );
}
