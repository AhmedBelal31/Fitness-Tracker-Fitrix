import 'package:flutter/material.dart';

class PageTransitions {
  // Slide from bottom with fade animation
  static PageRouteBuilder slideFromBottom(
    Widget screen, {
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => screen,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (_, animation, __, child) {
        final slideTween = Tween(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        final fadeTween = Tween(begin: 0.0, end: 1.0);

        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
      settings: settings,
    );
  }
}
