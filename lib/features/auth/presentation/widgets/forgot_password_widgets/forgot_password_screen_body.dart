import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/forget_password/forgot_password_cubit.dart';
import '../../cubits/forget_password/forgot_password_state.dart';
import '../login_widgets/animated_fitness_icon.dart';
import 'forgot_password_form.dart';

class ForgotPasswordScreenBody extends StatefulWidget {
  const ForgotPasswordScreenBody({super.key});

  @override
  State<ForgotPasswordScreenBody> createState() =>
      _ForgotPasswordScreenBodyState();
}

class _ForgotPasswordScreenBodyState extends State<ForgotPasswordScreenBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() != true) return;
    final email = _emailController.text.trim();
    context.read<ForgotPasswordCubit>().submit(email);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          decoration: BoxDecoration(
            color: ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(12),
            boxShadow: ColorsManager.softShadow,
          ),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.primaryGreen,
            ),
          ),
        ),
      ),
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
                Text(s.forgotPasswordTitle, style: TextStyles.headline2),
                const SizedBox(height: 8),
                Text(
                  s.forgotPasswordSubtitle,
                  style: TextStyles.subtitle2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ForgotPasswordForm(emailController: _emailController),
                const SizedBox(height: 32),
                BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: s.sendResetLink,
                      icon: Icons.send,
                      isLoading: state.isLoading,
                      onPressed: state.isLoading ? null : _submit,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
