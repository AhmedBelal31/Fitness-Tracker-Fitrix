import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
//
// class AnimatedFitnessIcon extends StatefulWidget {
//   final double size;
//   final double iconSize;
//   final Duration animationDuration;
//   final bool enableAnimation;
//
//   const AnimatedFitnessIcon({
//     super.key,
//     this.size = 100,
//     this.iconSize = 50,
//     this.animationDuration = const Duration(seconds: 3),
//     this.enableAnimation = true,
//   });
//
//   @override
//   State<AnimatedFitnessIcon> createState() => _AnimatedFitnessIconState();
// }
//
// class _AnimatedFitnessIconState extends State<AnimatedFitnessIcon>
//     with TickerProviderStateMixin {
//   late AnimationController _rotationController;
//   late Animation<double> _rotationAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     if (widget.enableAnimation) {
//       _startAnimation();
//     }
//   }
//
//   void _setupAnimations() {
//     _rotationController = AnimationController(
//       duration: widget.animationDuration,
//       vsync: this,
//     );
//
//     _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _rotationController, curve: Curves.linear),
//     );
//   }
//
//   void _startAnimation() {
//     _rotationController.repeat();
//   }
//
//   @override
//   void dispose() {
//     _rotationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.size,
//       height: widget.size,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         gradient: ColorsManager.primaryGradient,
//         boxShadow: ColorsManager.primaryShadow,
//       ),
//       child: widget.enableAnimation
//           ? AnimatedBuilder(
//               animation: _rotationAnimation,
//               builder: (context, child) {
//                 return Transform.rotate(
//                   angle:
//                       _rotationAnimation.value * 2 * 3.14159, // Full rotation
//                   child: Icon(
//                     Icons.fitness_center,
//                     size: widget.iconSize,
//                     color: ColorsManager.whiteText,
//                   ),
//                 );
//               },
//             )
//           : Icon(
//               Icons.fitness_center,
//               size: widget.iconSize,
//               color: ColorsManager.whiteText,
//             ),
//     );
//   }
// }
// widgets/pulsing_fitness_icon.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PulsingFitnessIcon extends StatefulWidget {
  final double size;
  final double iconSize;

  const PulsingFitnessIcon({Key? key, this.size = 100, this.iconSize = 50})
    : super(key: key);

  @override
  State<PulsingFitnessIcon> createState() => _PulsingFitnessIconState();
}

class _PulsingFitnessIconState extends State<PulsingFitnessIcon>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_rotationController, _pulseController]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: ColorsManager.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.primaryGreen.withOpacity(
                    0.3 * _pulseAnimation.value,
                  ),
                  blurRadius: 25 * _pulseAnimation.value,
                  spreadRadius: 3 * _pulseAnimation.value,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Transform.rotate(
              angle: _rotationAnimation.value,
              child: Icon(
                Icons.fitness_center,
                size: widget.iconSize,
                color: ColorsManager.whiteText,
              ),
            ),
          ),
        );
      },
    );
  }
}
