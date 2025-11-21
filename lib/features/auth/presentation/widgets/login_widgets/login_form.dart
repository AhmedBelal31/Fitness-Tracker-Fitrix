import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/common_ui/widgets/custom_checkbox.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/login/login_cubit.dart';
import 'login_validators.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Column(
      children: [
        CustomTextField(
          controller: emailController,
          label: l10n.emailAddress,
          hint: l10n.enterYourEmail,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => LoginValidators.validateEmail(value, l10n),
        ),
        const SizedBox(height: 24),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.isPasswordVisible != current.isPasswordVisible,
          builder: (context, state) {
            return CustomTextField(
              controller: passwordController,
              label: l10n.password,
              hint: l10n.enterYourPassword,
              prefixIcon: Icons.lock_outlined,
              isPassword: !state.isPasswordVisible,
              validator: (value) =>
                  LoginValidators.validatePassword(value, l10n),
            );
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) =>
              previous.rememberMe != current.rememberMe,
          builder: (context, state) {
            return CustomCheckbox(
              value: state.rememberMe,
              onChanged: (_) => context.read<LoginCubit>().toggleRememberMe(),
              label: l10n.rememberMe,
            );
          },
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  void _handleLogin(BuildContext context) {
    context.read<LoginCubit>().clearError();

    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return CustomButton(
          text: l10n.signIn,
          onPressed: state.isLoading ? null : () => _handleLogin(context),
          isLoading: state.isLoading,
          icon: Icons.login,
        );
      },
    );
  }
}
