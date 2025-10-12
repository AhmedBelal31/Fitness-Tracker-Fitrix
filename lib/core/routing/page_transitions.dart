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

  // Locale-aware slide transition (RTL/LTR)
  static PageRouteBuilder slideWithLocale(
    Widget screen, {
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 650),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Get text direction from context - available in transitionsBuilder
        final isRtl = Directionality.of(context) == TextDirection.ltr;

        // For RTL: slide from right (1.0, 0.0)
        // For LTR: slide from left (-1.0, 0.0)
        final beginOffset = isRtl
            ? const Offset(1.0, 0.0) // Slide from right for RTL
            : const Offset(-1.0, 0.0); // Slide from left for LTR

        final slideTween = Tween(
          begin: beginOffset,
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOutCubic));

        final fadeTween = Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn));

        final scaleTween = Tween(
          begin: 0.92,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOutQuart));

        return SlideTransition(
          position: animation.drive(slideTween),
          // child: FadeTransition(
          //   opacity: animation.drive(fadeTween),
          //   child: ScaleTransition(
          //     scale: animation.drive(scaleTween),
          //     child: child,
          //   ),
          // ),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
      settings: settings,
    );
  }
}
