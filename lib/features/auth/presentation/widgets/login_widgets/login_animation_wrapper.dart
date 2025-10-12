import 'package:flutter/material.dart';

class LoginAnimationWrapper extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController animationController;
  final Widget child;

  const LoginAnimationWrapper({
    super.key,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.animationController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
    );
  }
}
