import 'package:flutter/material.dart';

import 'app_transition.dart';

/// Class that implements a fade out transition.
final class FadeOutTransition implements AppTransition {
  /// The default duration for the transition.
  final Duration _defaultDuration;

  const FadeOutTransition([
    this._defaultDuration = const Duration(milliseconds: 500),
  ]);

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  Duration get transitionDuration => _defaultDuration;
}
