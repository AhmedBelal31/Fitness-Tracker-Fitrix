import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:fitrix/core/routing/routes.dart';
import 'package:fitrix/features/auth/data/models/login_profile_model.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/profile_cubit/complete_profile_state.dart';

class CompleteProfileListener {
  static void handleStateChange(
    BuildContext context,
    CompleteProfileState state,
  ) {
    if (state.isSuccess) {
      _handleSuccess(context, state);
    } else if (state.errorMessage != null) {
      _handleError(context, state);
    }
  }

  static void _handleSuccess(BuildContext context, CompleteProfileState state) {
    final s = S.of(context);
    final profile = state.userProfile;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.profileCompletedWelcome(profile?.firstName ?? 'User')),
        backgroundColor: ColorsManager.primaryGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        final route = _getHomeRouteForProfile(profile);

        dev.log(
          '🎯 Profile completed for ${profile?.roleString ?? "Unknown"} '
          '(${profile?.firstName} ${profile?.lastName})',
          name: 'CompleteProfileListener',
        );
        dev.log('🚀 Navigating to: $route', name: 'CompleteProfileListener');

        Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
      }
    });
  }

  static void _handleError(BuildContext context, CompleteProfileState state) {
    final s = S.of(context);

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
          label: s.dismiss,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static String _getHomeRouteForProfile(LoginProfileModel? profile) {
    if (profile == null) {
      dev.log(
        '⚠️ No profile data, defaulting to user home',
        name: 'CompleteProfileListener',
      );
      return Routes.userHostScreen;
    }

    if (profile.isUser) {
      return Routes.userHostScreen;
    } else if (profile.isTrainer) {
      return Routes.trainerHostScreen;
    } else {
      dev.log(
        '⚠️ Unknown role (${profile.role}), defaulting to user home',
        name: 'CompleteProfileListener',
      );
      return Routes.userHostScreen;
    }
  }
}
