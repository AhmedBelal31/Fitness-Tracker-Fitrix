import 'package:flutter/material.dart';

class AnimatedItem extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const AnimatedItem({
    super.key,
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final delay = index * 0.1;
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, delay + 0.4, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
