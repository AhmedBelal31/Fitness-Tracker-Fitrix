import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/theming/app_colors.dart';

class RegisterLoginLink extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterLoginLink({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s.alreadyHaveAccount,
          style: TextStyle(
            fontSize: 16,
            color: ColorsManager.getSecondaryText(context),
          ),
        ),
        TextButton(
          onPressed: isLoading ? null : onPressed,
          child: Text(
            s.login,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorsManager.getPrimaryGreen(context),
            ),
          ),
        ),
      ],
    );
  }
}
