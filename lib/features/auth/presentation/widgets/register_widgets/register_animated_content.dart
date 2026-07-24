import 'package:flutter/material.dart';
import 'register_form_content.dart';
import 'register_animation_mixin.dart';

class RegisterAnimatedContent extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onNavigateToLogin;

  const RegisterAnimatedContent({
    super.key,
    required this.isLoading,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterAnimatedContent> createState() =>
      _RegisterAnimatedContentState();
}

class _RegisterAnimatedContentState extends State<RegisterAnimatedContent>
    with TickerProviderStateMixin, RegisterAnimationMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          physics: BouncingScrollPhysics(),
          child: RegisterFormContent(
            isLoading: widget.isLoading,
            onNavigateToLogin: widget.onNavigateToLogin,
          ),
        );
      },
    );
  }
}
