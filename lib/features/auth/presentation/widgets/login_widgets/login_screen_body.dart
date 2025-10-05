import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/common_ui/widgets/custom_checkbox.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../cubits/login/login_cubit.dart';
import 'animated_fitness_icon.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimation();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );
  }

  void _startAnimation() {
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      // Navigate to home screen after successful login_widgets
      context.pushNamedAndRemoveUntil(Routes.hostScreen, (route) => false);
    }
  }

  void _navigateToRegister() {
    context.pushNamed(Routes.registerScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorsManager.appBackgroundGradient,
        ),
        child: SafeArea(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),

                          // Logo and welcome section
                          _buildHeader(),

                          const SizedBox(height: 48),

                          // Login form
                          _buildLoginForm(),

                          const SizedBox(height: 32),

                          // Login button
                          _buildLoginButton(),

                          const SizedBox(height: 24),

                          // Forgot password link
                          _buildForgotPasswordLink(),

                          // Sign up link
                          _buildSignUpLink(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        // Logo
        PulsingFitnessIcon(),
        const SizedBox(height: 24),

        // Welcome text - Using headline1 for main title
        Text('Welcome Back!', style: TextStyles.headline1),

        const SizedBox(height: 8),

        // Subtitle - Using subtitle2 for description
        Text(
          'Sign in to continue your fitness journey',
          style: TextStyles.subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        // Email field
        CustomTextField(
          controller: _emailController,
          label: 'Email Address',
          hint: 'Enter your email',
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),

        const SizedBox(height: 24),

        // Password field
        CustomTextField(
          controller: _passwordController,
          label: 'Password',
          hint: 'Enter your password',
          prefixIcon: Icons.lock_outlined,
          isPassword: true,
          validator: _validatePassword,
        ),

        const SizedBox(height: 20),

        // Remember me checkbox
        BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            return CustomCheckbox(
              value: state.rememberMe,
              onChanged: (_) => context.read<LoginCubit>().toggleRememberMe(),
              label: 'Remember me',
            );
          },
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Sign In',
          onPressed: state.isLoading ? null : _handleLogin,
          isLoading: state.isLoading,
          icon: Icons.login,
        );
      },
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: () {
          // Handle forgot password
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Forgot password feature coming soon!',
                style: TextStyles.font14WhiteMedium,
              ),
              backgroundColor: ColorsManager.primaryGreen,
            ),
          );
        },
        child: Text(
          'Forgot Password?',
          style: TextStyles.font16PrimaryGreenRegular.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyles.font16LightTextRegular,
        ),
        TextButton(
          onPressed: _navigateToRegister,
          child: Text(
            'Register',
            style: TextStyles.font16PrimaryGreenRegular.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
