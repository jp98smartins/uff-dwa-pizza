import 'package:flutter/material.dart';

import 'app_transition.dart';

/// Class that implements a slide up transition.
final class SlideUpTransition implements AppTransition {
  /// The default duration for the transition.
  final Duration _defaultDuration;

  const SlideUpTransition([
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
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => _defaultDuration;
}
