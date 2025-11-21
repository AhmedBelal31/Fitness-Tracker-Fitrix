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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ColorsManager.getScaffoldBackground(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorsManager.getBackgroundGradient(context),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              if (isDark)
                Positioned(
                  top: -150,
                  left: -100,
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorsManager.darkPrimaryGreen.withOpacity(0.05),
                          ColorsManager.darkSecondaryGreen.withOpacity(0.02),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        const PulsingFitnessIcon(),
                        const SizedBox(height: 24),
                        Text(
                          s.forgotPasswordTitle,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryText(context),
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            s.forgotPasswordSubtitle,
                            style: TextStyle(
                              fontSize: 15,
                              color: ColorsManager.getSecondaryText(context),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark
                                ? ColorsManager.darkSurface.withValues(
                                    alpha: 0.6,
                                  )
                                : ColorsManager.info.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? ColorsManager.darkPrimaryGreen.withValues(
                                      alpha: 0.3,
                                    )
                                  : ColorsManager.info.withValues(alpha: 0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: isDark
                                    ? ColorsManager.darkPrimaryGreen
                                    : ColorsManager.info,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  s.resetPasswordInfo,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: ColorsManager.getSecondaryText(
                                      context,
                                    ),
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
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
                        const SizedBox(height: 24),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 18,
                                color: ColorsManager.getPrimaryGreen(context),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                s.backToLogin,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: ColorsManager.getPrimaryGreen(context),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark
                        ? ColorsManager.darkSurface.withValues(alpha: 0.9)
                        : ColorsManager.cardBackground.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isDark
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 12,
                              spreadRadius: 0,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: ColorsManager.getPrimaryGreen(context),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
