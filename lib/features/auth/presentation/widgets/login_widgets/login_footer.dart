import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/styles.dart';
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
            onPressed: () => context.pushNamed(Routes.forgotPasswordScreen),
            child: Text(
              l10n.forgotPassword,
              style: TextStyles.font16PrimaryGreenRegular.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.dontHaveAccount,
              style: TextStyles.font16LightTextRegular,
            ),
            TextButton(
              onPressed: () => context.pushNamed(Routes.registerScreen),
              child: Text(
                l10n.register,
                style: TextStyles.font16PrimaryGreenRegular.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
