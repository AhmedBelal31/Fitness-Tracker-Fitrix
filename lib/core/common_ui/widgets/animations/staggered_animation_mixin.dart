import 'package:flutter/material.dart';

mixin StaggeredAnimationMixin<T extends StatefulWidget>
    on SingleTickerProviderStateMixin<T> {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  void setupStaggeredAnimations({
    Duration duration = const Duration(milliseconds: 800),
  }) {
    animationController = AnimationController(duration: duration, vsync: this);

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
          ),
        );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    animationController.forward();
  }

  void disposeAnimations() {
    animationController.dispose();
  }
}
