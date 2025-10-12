import 'dart:developer' as dev;
import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/login_profile_model.dart';
import '../../cubits/login/login_cubit.dart';

class LoginListener {
  static void handleStateChange(BuildContext context, LoginState state) async {
    final l10n = S.of(context);

    if (state.shouldNavigateToHome) {
      _handleSuccessfulLogin(context, state, l10n);
    } else if (state.shouldNavigateToCompleteProfile) {
      _handleProfileCompletion(context, l10n);
    } else if (state.hasError) {
      _handleError(context, state);
    }
  }

  static void _handleSuccessfulLogin(
    BuildContext context,
    LoginState state,
    S l10n,
  ) {
    final userProfile = state.userProfile;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.welcomeBackUser(userProfile?.firstName ?? 'User')),
        backgroundColor: ColorsManager.primaryGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        final route = _getHomeRouteForProfile(userProfile);
        dev.log(
          '🎯 Navigating to ${userProfile?.roleString ?? "User"} home',
          name: 'LoginListener',
        );
        context.pushReplacementNamed(route);
      }
    });
  }

  static void _handleProfileCompletion(BuildContext context, S l10n) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.completeProfileMessage),
        backgroundColor: ColorsManager.primaryGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        context.pushReplacementNamed(Routes.completeProfileScreen);
      }
    });
  }

  static void _handleError(BuildContext context, LoginState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static String _getHomeRouteForProfile(LoginProfileModel? profile) {
    if (profile?.isUser == true) {
      return Routes.userHostScreen;
    } else if (profile?.isTrainer == true) {
      return Routes.trainerHostScreen;
    } else {
      return Routes.userHostScreen;
    }
  }
}
