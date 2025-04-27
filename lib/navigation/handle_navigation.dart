import 'package:flutter/material.dart' show BuildContext, Navigator, Widget;
import 'package:flutterx/animation/animate_route.dart';
import 'package:flutterx/enum/transition_type.dart';

class HandleNavigation {
  navigate({
    required BuildContext context,
    required String transition,
    required String action,
    required Widget child,
  }) {
    switch (action) {
      case "push":
        return Navigator.push(
          context,
          AnimateRoute(screen: child, transition: getAnimation(transition)),
        );
      case "replace":
        return Navigator.pushReplacement(
          context,
          AnimateRoute(screen: child, transition: getAnimation(transition)),
        );
      default:
    }
  }

  Object getAnimation(value) {
    switch (value) {
      case "fade":
        return Transition.fade;
      case "fadeIn":
        return Transition.fadeIn;
      case "leftToRight":
        return Transition.leftToRight;
      case "upToDown":
        return Transition.upToDown;
      case "downToUp":
        return Transition.downToUp;
      case "rightToLeftWithFade":
        return Transition.rightToLeftWithFade;
      case "leftToRightWithFade":
        return Transition.leftToRightWithFade;
      case "zoom":
        return Transition.zoom;
      case "cupertino":
        return Transition.cupertino;
      case "size":
        return Transition.size;
      case "circularReveal":
        return Transition.circularReveal;
      default:
        return Transition.values;
    }
  }
}
