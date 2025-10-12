import 'package:flutter/material.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import 'forgot_password_validators.dart';

class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailController;

  const ForgotPasswordForm({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return CustomTextField(
      controller: emailController,
      label: s.emailAddress,
      hint: s.enterYourEmail,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => ForgotPasswordValidators.validateEmail(value, s),
    );
  }
}
