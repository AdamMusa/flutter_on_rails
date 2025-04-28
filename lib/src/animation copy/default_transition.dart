import 'package:flutter/material.dart';
import 'circular_reveal_clipper.dart';

/// custom transition
class CircularRevealTransition {
  Widget buildTransitions(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ClipPath(
      clipper: CircularRevealClipper(
        fraction: animation.value,
        centerAlignment: Alignment.center,
        centerOffset: Offset.zero,
        minRadius: 0,
        maxRadius: 800,
      ),
      child: child,
    );
  }
}
