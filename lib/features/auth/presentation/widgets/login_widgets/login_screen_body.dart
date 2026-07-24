import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../cubits/login/login_cubit.dart';
import 'language_toggle_button.dart';
import 'login_animation_wrapper.dart';
import 'login_footer.dart';
import 'login_form.dart';
import 'login_header.dart';

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
    _loadSavedEmail();
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

  void _loadSavedEmail() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<LoginCubit>().state;
      if (state.hasSavedEmail) {
        _emailController.text = state.savedEmail!;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    // 🎨 Detect theme
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      // 🎨 Adaptive background color
      backgroundColor: ColorsManager.getScaffoldBackground(context),
      body: Container(
        decoration: BoxDecoration(
          // 🎨 Adaptive gradient background
          gradient: ColorsManager.getBackgroundGradient(context),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 🌟 Optional: Decorative glow effect for dark mode
              if (isDark)
                Positioned(
                  top: -100,
                  right: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorsManager.darkPrimaryGreen.withOpacity(0.06),
                          ColorsManager.darkSecondaryGreen.withOpacity(0.03),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

              // Main Login Content
              LoginAnimationWrapper(
                fadeAnimation: _fadeAnimation,
                slideAnimation: _slideAnimation,
                animationController: _animationController,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),
                        const LoginHeader(),
                        const SizedBox(height: 48),
                        LoginForm(
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        const SizedBox(height: 32),
                        LoginButton(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        const SizedBox(height: 24),
                        const LoginFooter(),
                      ],
                    ),
                  ),
                ),
              ),

              // Language toggle button
              const Positioned(
                top: 16,
                right: 16,
                child: LanguageToggleButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
