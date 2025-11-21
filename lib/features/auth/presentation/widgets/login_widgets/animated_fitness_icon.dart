import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class PulsingFitnessIcon extends StatefulWidget {
  final double size;
  final double iconSize;

  const PulsingFitnessIcon({super.key, this.size = 100, this.iconSize = 50});

  @override
  State<PulsingFitnessIcon> createState() => _PulsingFitnessIconState();
}

class _PulsingFitnessIconState extends State<PulsingFitnessIcon>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _particleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    // Slower rotation for smoother effect
    _rotationController = AnimationController(
      duration: const Duration(seconds: 8), // 👈 Slower rotation
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      // 👈 Reduced pulse range
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );
  }

  void _startAnimations() {
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _particleController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _particleController]),
      builder: (context, child) {
        return SizedBox(
          width: widget.size + 60,
          height: widget.size + 60,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 🌟 Rotating particles (dark mode only)
              if (isDark) ..._buildParticles(),

              // 🌟 Outer glow ring (more prominent in dark mode)
              if (isDark)
                Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: widget.size + 40,
                    height: widget.size + 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorsManager.darkPrimaryGreen.withValues(
                            alpha: 0.2 * _pulseAnimation.value,
                          ),
                          ColorsManager.darkSecondaryGreen.withValues(
                            alpha: 0.1 * _pulseAnimation.value,
                          ),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),

              // Main icon container with pulse (NO rotation here)
              Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: ColorsManager.getLogoGradient(context),
                    boxShadow: [
                      BoxShadow(
                        color: ColorsManager.getPrimaryGreen(context)
                            .withValues(
                              alpha: isDark
                                  ? 0.4 * _pulseAnimation.value
                                  : 0.3 * _pulseAnimation.value,
                            ),
                        blurRadius: isDark
                            ? 30 * _pulseAnimation.value
                            : 25 * _pulseAnimation.value,
                        spreadRadius: isDark
                            ? 4 * _pulseAnimation.value
                            : 3 * _pulseAnimation.value,
                        offset: isDark
                            ? const Offset(0, 0)
                            : const Offset(0, 8),
                      ),
                      if (isDark)
                        BoxShadow(
                          color: ColorsManager.darkAccentGreen.withValues(
                            alpha: 0.2 * _pulseAnimation.value,
                          ),
                          blurRadius: 15 * _pulseAnimation.value,
                          spreadRadius: 1 * _pulseAnimation.value,
                          offset: const Offset(0, 0),
                        ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: isDark
                          ? Border.all(
                              color: ColorsManager.darkAccentGreen.withValues(
                                alpha: 0.3,
                              ),
                              width: 2,
                            )
                          : null,
                    ),
                    // 🎯 Icon rotation in separate AnimatedBuilder
                    child: AnimatedBuilder(
                      animation: _rotationController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotationAnimation.value,
                          child: Icon(
                            Icons.fitness_center,
                            size: widget.iconSize,
                            color: isDark
                                ? ColorsManager.darkScaffold
                                : ColorsManager.whiteText,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🌟 Build decorative particles for dark mode
  List<Widget> _buildParticles() {
    return List.generate(4, (index) {
      final angle =
          (index * math.pi / 2) + (_particleAnimation.value * 2 * math.pi);
      final distance = widget.size / 2 + 30;
      final x = math.cos(angle) * distance;
      final y = math.sin(angle) * distance;

      return Transform.translate(
        offset: Offset(x, y),
        child: Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorsManager.darkAccentGreen.withValues(
              alpha: 0.4 * (1 - (_particleAnimation.value - 0.5).abs() * 2),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.darkAccentGreen.withValues(alpha: 0.6),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      );
    });
  }
}

//
// class PulsingFitnessIcon extends StatefulWidget {
//   final double size;
//   final double iconSize;
//
//   const PulsingFitnessIcon({super.key, this.size = 100, this.iconSize = 50});
//
//   @override
//   State<PulsingFitnessIcon> createState() => _PulsingFitnessIconState();
// }
//
// class _PulsingFitnessIconState extends State<PulsingFitnessIcon>
//     with TickerProviderStateMixin {
//   late AnimationController _rotationController;
//   late AnimationController _pulseController;
//   late Animation<double> _rotationAnimation;
//   late Animation<double> _pulseAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _startAnimations();
//   }
//
//   void _setupAnimations() {
//     _rotationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//
//     _pulseController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//
//     _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
//       CurvedAnimation(parent: _rotationController, curve: Curves.linear),
//     );
//
//     _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
//       CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
//     );
//   }
//
//   void _startAnimations() {
//     _rotationController.repeat();
//     _pulseController.repeat(reverse: true);
//   }
//
//   @override
//   void dispose() {
//     _rotationController.dispose();
//     _pulseController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 🎨 Detect current theme
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return AnimatedBuilder(
//       animation: Listenable.merge([_rotationController, _pulseController]),
//       builder: (context, child) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             // 🌟 Outer glow ring (more prominent in dark mode)
//             if (isDark)
//               Container(
//                 width: widget.size + 40,
//                 height: widget.size + 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: RadialGradient(
//                     colors: [
//                       ColorsManager.darkPrimaryGreen.withOpacity(
//                         0.2 * _pulseAnimation.value,
//                       ),
//                       ColorsManager.darkSecondaryGreen.withOpacity(
//                         0.1 * _pulseAnimation.value,
//                       ),
//                       Colors.transparent,
//                     ],
//                     stops: const [0.0, 0.6, 1.0],
//                   ),
//                 ),
//               ),
//
//             // Main icon container with adaptive styling
//             Transform.scale(
//               scale: _pulseAnimation.value,
//               child: Container(
//                 width: widget.size,
//                 height: widget.size,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   // 🎨 Adaptive gradient
//                   gradient: ColorsManager.getLogoGradient(context),
//                   // 🎨 Adaptive shadow/glow effect
//                   boxShadow: [
//                     BoxShadow(
//                       color: ColorsManager.getPrimaryGreen(context).withOpacity(
//                         isDark
//                             ? 0.4 * _pulseAnimation.value
//                             : 0.3 * _pulseAnimation.value,
//                       ),
//                       blurRadius: isDark
//                           ? 30 * _pulseAnimation.value
//                           : 25 * _pulseAnimation.value,
//                       spreadRadius: isDark
//                           ? 4 * _pulseAnimation.value
//                           : 3 * _pulseAnimation.value,
//                       offset: isDark ? const Offset(0, 0) : const Offset(0, 8),
//                     ),
//                     // Additional light glow for dark mode
//                     if (isDark)
//                       BoxShadow(
//                         color: ColorsManager.darkAccentGreen.withOpacity(
//                           0.2 * _pulseAnimation.value,
//                         ),
//                         blurRadius: 15 * _pulseAnimation.value,
//                         spreadRadius: 1 * _pulseAnimation.value,
//                         offset: const Offset(0, 0),
//                       ),
//                   ],
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     // 🎨 Subtle border for dark mode
//                     border: isDark
//                         ? Border.all(
//                             color: ColorsManager.darkAccentGreen.withOpacity(
//                               0.3,
//                             ),
//                             width: 2,
//                           )
//                         : null,
//                   ),
//                   child: Transform.rotate(
//                     angle: _rotationAnimation.value,
//                     child: Icon(
//                       Icons.fitness_center,
//                       size: widget.iconSize,
//                       // 🎨 Adaptive icon color
//                       color: isDark
//                           ? ColorsManager.darkScaffold
//                           : ColorsManager.whiteText,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
