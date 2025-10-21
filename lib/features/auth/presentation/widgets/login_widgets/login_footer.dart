import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton(
            key: const ValueKey('forgot_password_button'),
            onPressed: () => context.pushNamed(Routes.forgotPasswordScreen),
            style: TextButton.styleFrom(
              foregroundColor: ColorsManager.getPrimaryGreen(context),
            ),
            child: Text(
              l10n.forgotPassword,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsManager.getPrimaryGreen(context),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.dontHaveAccount,
              style: TextStyle(
                fontSize: 16,
                color: ColorsManager.getSecondaryText(context),
              ),
            ),
            TextButton(
              key: const ValueKey('register_button'),
              onPressed: () => context.pushNamed(Routes.registerScreen),
              style: TextButton.styleFrom(
                foregroundColor: ColorsManager.getPrimaryGreen(context),
              ),
              child: Text(
                l10n.register,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
