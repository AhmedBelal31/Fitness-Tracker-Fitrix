import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyles.font16LightTextRegular,
        ),
        TextButton(
          onPressed: isLoading ? null : onPressed,
          child: Text(
            'Login',
            style: TextStyles.font16PrimaryGreenRegular.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
