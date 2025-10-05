import 'package:fitrix/core/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../domain/repositories/auth_repository_impl.dart';
import '../cubits/forget_password/forgot_password_cubit.dart';
import '../cubits/forget_password/forgot_password_state.dart';
import '../widgets/login_widgets/animated_fitness_icon.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<ForgotPasswordCubit>(),
      child: ForgotPasswordScreenBody(),
    );
  }
}

class ForgotPasswordScreenBody extends StatefulWidget {
  const ForgotPasswordScreenBody({super.key});

  @override
  State<ForgotPasswordScreenBody> createState() =>
      _ForgotPasswordScreenBodyState();
}

class _ForgotPasswordScreenBodyState extends State<ForgotPasswordScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() != true) return;
    final email = _emailController.text.trim();
    context.read<ForgotPasswordCubit>().submit(email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('A password reset link was sent to your email.'),
              backgroundColor: ColorsManager.primaryGreen,
            ),
          );
          Navigator.of(context).pop(); // Return to Login screen
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackground,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const PulsingFitnessIcon(),
                  const SizedBox(height: 24),
                  Text('Forgot Password?', style: TextStyles.headline2),
                  const SizedBox(height: 8),
                  Text(
                    'Enter your registered email and we’ll send a reset link.',
                    style: TextStyles.subtitle2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 32),
                  BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: 'Send Reset Link',
                        icon: Icons.send,
                        isLoading: state.isLoading,
                        onPressed: state.isLoading
                            ? null
                            : () => _submit(context),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
