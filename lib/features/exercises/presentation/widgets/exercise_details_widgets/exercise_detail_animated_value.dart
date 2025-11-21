import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';

class ExerciseDetailAnimatedValue extends StatelessWidget {
  final String value;
  final Color color;
  final AnimationController controller;

  const ExerciseDetailAnimatedValue({
    super.key,
    required this.value,
    required this.color,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
          .animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
            ),
          ),
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
          ),
        ),
        child: Text(
          value,
          style: TextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
