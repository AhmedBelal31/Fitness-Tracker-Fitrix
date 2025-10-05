import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import 'export_routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;

    Widget screen;

    switch (name) {
      case Routes.splashScreen:
        screen = const SplashScreen();
        break;
      case Routes.loginScreen:
        screen = const LoginScreen();
        break;
      case Routes.registerScreen:
        screen = const RegisterScreen();
        break;
      default:
        screen = const ErrorScreen();
    }

    // Use the same beautiful animation from before
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 800),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Slide in from bottom with fade (same as splash to login_widgets)
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOutCubic;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        var fadeAnimation = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(opacity: fadeAnimation, child: child),
        );
      },
      settings: settings,
    );
  }
}
