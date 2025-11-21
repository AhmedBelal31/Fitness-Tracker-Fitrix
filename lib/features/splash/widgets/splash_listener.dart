import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:fitrix/core/routing/routes.dart';
import 'package:fitrix/core/routing/page_transitions.dart';
import '../../../core/networking/token_manager.dart';
import '../../auth/presentation/cubits/auth_check/auth_check_cubit.dart';
import '../../auth/presentation/screens/login_screen.dart';
import '../../host/presentation/screens/trainer_host_screen.dart';
import '../../host/presentation/screens/user_host_screen.dart';
import 'splash_animation_controller.dart';

class SplashListener {
  static final TokenManager _tokenManager = TokenManager.instance;

  static Future<void> handleStateChange(
    BuildContext context,
    AuthCheckState state,
    SplashAnimationController animationController,
  ) async {
    if (state is AuthCheckAuthenticated) {
      await _handleAuthenticated(context, state, animationController);
    } else if (state is AuthCheckUnauthenticated) {
      await _handleUnauthenticated(context, animationController);
    }
  }

  static Future<void> _handleAuthenticated(
    BuildContext context,
    AuthCheckAuthenticated state,
    SplashAnimationController animationController,
  ) async {
    await animationController.startAnimationSequence();

    final userProfile = state.user;
    final cachedRole = await _tokenManager.getUserRole();

    // Validate cached role matches profile role
    if (cachedRole != userProfile.role) {
      dev.log(
        '⚠️ Role mismatch! Cached: $cachedRole, Profile: ${userProfile.role}',
        name: 'SplashListener',
      );
      if (userProfile.role != null) {
        await _tokenManager.saveUserRole(userProfile.role!);
      }
    }

    // Determine route based on role
    final route = _determineHomeRoute(userProfile.role);

    dev.log(
      '🎯 Navigating to ${userProfile.roleString} home',
      name: 'SplashListener',
    );

    await _navigateToRoute(context, route, animationController);
  }

  static Future<void> _handleUnauthenticated(
    BuildContext context,
    SplashAnimationController animationController,
  ) async {
    await animationController.startAnimationSequence();

    dev.log(
      '🔒 No authentication, navigating to login',
      name: 'SplashListener',
    );

    await _navigateToRoute(context, Routes.loginScreen, animationController);
  }

  static String _determineHomeRoute(int? role) {
    if (role == 1) {
      return Routes.userHostScreen;
    } else if (role == 2) {
      return Routes.trainerHostScreen;
    } else {
      dev.log(
        '⚠️ Unknown role: $role, defaulting to User home',
        name: 'SplashListener',
      );
      return Routes.userHostScreen;
    }
  }

  static Future<void> _navigateToRoute(
    BuildContext context,
    String route,
    SplashAnimationController animationController,
  ) async {
    if (animationController.hasNavigated) return;

    await animationController.startExitAnimation();

    if (!context.mounted || animationController.hasNavigated) return;

    animationController.markAsNavigated();

    final destinationScreen = _getScreenForRoute(route);

    Navigator.of(context).pushReplacement(
      PageTransitions.slideWithLocale(
        destinationScreen,
        settings: RouteSettings(name: route),
      ),
    );
  }

  static Widget _getScreenForRoute(String route) {
    switch (route) {
      case Routes.userHostScreen:
        return UserHostScreen();
      case Routes.trainerHostScreen:
        return TrainerHostScreen();
      case Routes.loginScreen:
      default:
        return const LoginScreen();
    }
  }
}
