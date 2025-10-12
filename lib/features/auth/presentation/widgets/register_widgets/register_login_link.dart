import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

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
        Text(s.alreadyHaveAccount, style: TextStyles.font16LightTextRegular),
        TextButton(
          onPressed: isLoading ? null : onPressed,
          child: Text(
            s.login,
            style: TextStyles.font16PrimaryGreenRegular.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
