import 'package:flutter/material.dart';

// class AnimatedCardWrapper extends StatelessWidget {
//   final Widget child;
//   final int index;
//   final AnimationController controller;
//
//   const AnimatedCardWrapper({
//     super.key,
//     required this.child,
//     required this.index,
//     required this.controller,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // ✅ Fix: Ensure intervals stay within 0.0 to 1.0
//     final double delayFactor = index * 0.05; // Smaller delay
//     final double startFade = (0.2 + delayFactor).clamp(0.0, 0.8);
//     final double endFade = (0.6 + delayFactor).clamp(startFade + 0.1, 1.0);
//     final double startSlide = (0.2 + delayFactor).clamp(0.0, 0.7);
//     final double endSlide = (0.8 + delayFactor).clamp(startSlide + 0.1, 1.0);
//
//     final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Interval(startFade, endFade, curve: Curves.easeOut),
//       ),
//     );
//
//     final slideAnimation =
//         Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
//           CurvedAnimation(
//             parent: controller,
//             curve: Interval(startSlide, endSlide, curve: Curves.easeOutCubic),
//           ),
//         );
//
//     return FadeTransition(
//       opacity: fadeAnimation,
//       child: SlideTransition(position: slideAnimation, child: child),
//     );
//   }
// }
class AnimatedCardWrapper extends StatelessWidget {
  final Widget child;
  final int index;
  final AnimationController controller;

  const AnimatedCardWrapper({
    super.key,
    required this.child,
    required this.index,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double delayFactor = index * 0.05;
    final double startFade = (0.2 + delayFactor).clamp(0.0, 0.8);
    final double endFade = (0.6 + delayFactor).clamp(startFade + 0.1, 1.0);
    final double startSlide = (0.2 + delayFactor).clamp(0.0, 0.7);
    final double endSlide = (0.8 + delayFactor).clamp(startSlide + 0.1, 1.0);

    final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(startFade, endFade, curve: Curves.easeOut),
      ),
    );

    final slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(startSlide, endSlide, curve: Curves.easeOutCubic),
          ),
        );

    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(position: slideAnimation, child: child),
    );
  }
}
