import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/update_profile_cubit/update_profile_state.dart';

class UpdateProfileListener {
  static void handleStateChange(
    BuildContext context,
    UpdateProfileState state,
  ) {
    if (state.isSuccess) {
      _handleSuccess(context);
    } else if (state.errorMessage != null) {
      _handleError(context, state);
    }
  }

  static void _handleSuccess(BuildContext context) {
    final s = S.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.profileUpdatedSuccess),
        backgroundColor: ColorsManager.success,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    });
  }

  static void _handleError(BuildContext context, UpdateProfileState state) {
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
}
