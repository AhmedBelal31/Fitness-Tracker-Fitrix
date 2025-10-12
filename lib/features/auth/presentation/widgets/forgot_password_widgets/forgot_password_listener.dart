import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/forget_password/forgot_password_state.dart';

class ForgotPasswordListener {
  static void handleStateChange(
    BuildContext context,
    ForgotPasswordState state,
  ) {
    final s = S.of(context);

    if (state.isSuccess) {
      _handleSuccess(context, s);
    } else if (state.errorMessage != null) {
      _handleError(context, state);
    }
  }

  static void _handleSuccess(BuildContext context, dynamic s) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.resetLinkSent),
        backgroundColor: ColorsManager.primaryGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );

    // Return to Login screen after showing success message
    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  static void _handleError(BuildContext context, ForgotPasswordState state) {
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
}
