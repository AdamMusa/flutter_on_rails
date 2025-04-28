/// route Transition type.
/// pick one and apply transition between the screen
library flutter_on_rails.transition_type;

enum Transition {
  fade,
  fadeIn,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
  // topLevel,
  cupertino,
  size,
  circularReveal,
  // native,
}
