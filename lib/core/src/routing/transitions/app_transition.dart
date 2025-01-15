import 'package:flutter/material.dart';

/// Class that handles the transitions of the module's routes.
abstract interface class AppTransition {
  /// Getter that returns the duration of the transition.
  Duration get transitionDuration;

  /// Method that builds the transition.
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  );
}
