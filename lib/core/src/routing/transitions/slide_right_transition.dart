import 'package:flutter/material.dart';

import 'app_transition.dart';

/// Class that implements a slide right transition.
final class SlideRightTransition implements AppTransition {
  /// The default duration for the transition.
  final Duration _defaultDuration;

  const SlideRightTransition([
    this._defaultDuration = const Duration(milliseconds: 500),
  ]);

  @override
  Widget transitionBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => _defaultDuration;
}
