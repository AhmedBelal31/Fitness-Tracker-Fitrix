import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/register/register_cubit.dart';

class RegisterBlocListener {
  static void handleStateChanges(BuildContext context, RegisterState state) {
    if (state.isSuccess) {
      _handleSuccess(context, state);
    } else if (state.hasFieldErrors) {
      _handleFieldErrors(context);
    } else if (state.hasError && !state.hasFieldErrors) {
      _handleGeneralError(context, state);
    }
  }

  static void _handleSuccess(BuildContext context, RegisterState state) {
    final s = S.of(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(s.registrationSuccess(state.user!.userName)),
        backgroundColor: ColorsManager.primaryGreen,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (context.mounted) {
        context.pushReplacementNamed(Routes.loginScreen);
      }
    });
  }

  static void _handleFieldErrors(BuildContext context) {
    Future.microtask(() {
      if (context.mounted) {
        final formKey = _findFormKey(context);
        formKey?.currentState?.validate();
      }
    });
  }

  static void _handleGeneralError(BuildContext context, RegisterState state) {
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

  static GlobalKey<FormState>? _findFormKey(BuildContext context) {
    return null;
  }
}
