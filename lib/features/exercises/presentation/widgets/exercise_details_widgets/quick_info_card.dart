import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import 'exercise_detail_animated_value.dart';

// class QuickInfoCard extends StatefulWidget {
//   final IconData icon;
//   final String title;
//   final String value;
//   final Color color;
//   final int index;
//
//   const QuickInfoCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.value,
//     required this.color,
//     this.index = 0,
//   });
//
//   @override
//   State<QuickInfoCard> createState() => _QuickInfoCardState();
// }
//
// class _QuickInfoCardState extends State<QuickInfoCard>
//     with TickerProviderStateMixin {
//   late AnimationController _entryController;
//   late AnimationController _continuousController;
//
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//   late Animation<double> _continuousPulse;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _startAnimations();
//   }
//
//   void _setupAnimations() {
//     // Entry animation controller (plays once)
//     _entryController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     // Continuous animation controller (loops forever)
//     _continuousController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     // Entry animations
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
//     );
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));
//
//     _slideAnimation = Tween<double>(
//       begin: 30.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));
//
//     // Continuous pulse animation
//     _continuousPulse = Tween<double>(begin: 1.0, end: 1.15).animate(
//       CurvedAnimation(parent: _continuousController, curve: Curves.easeInOut),
//     );
//   }
//
//   void _startAnimations() {
//     Future.delayed(Duration(milliseconds: widget.index * 150), () {
//       if (mounted) {
//         _entryController.forward();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _entryController.dispose();
//     _continuousController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: ScaleTransition(
//         scale: _scaleAnimation,
//         child: AnimatedBuilder(
//           animation: _slideAnimation,
//           builder: (context, child) {
//             return Transform.translate(
//               offset: Offset(0, _slideAnimation.value),
//               child: child,
//             );
//           },
//           child: Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: ColorsManager.cardBackground,
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(
//                 color: widget.color.withValues(alpha: 0.3),
//                 width: 1,
//               ),
//               boxShadow: ColorsManager.softShadow,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Continuously animated icon
//                 _buildAnimatedIcon(),
//                 SizedBox(height: 8.h),
//
//                 // Title
//                 Text(
//                   widget.title,
//                   style: TextStyles.caption.copyWith(
//                     color: ColorsManager.lightText,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//
//                 // Animated value
//                 ExerciseDetailAnimatedValue(
//                   value: widget.value,
//                   color: widget.color,
//                   controller: _entryController,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAnimatedIcon() {
//     return AnimatedBuilder(
//       animation: _continuousPulse,
//       builder: (context, child) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             // Pulsing glow effect
//             Container(
//               width: 40.w * _continuousPulse.value,
//               height: 40.w * _continuousPulse.value,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: widget.color.withValues(
//                       alpha: 0.3 * (2 - _continuousPulse.value),
//                     ),
//                     blurRadius: 20,
//                     spreadRadius: 2,
//                   ),
//                 ],
//               ),
//             ),
//
//             // Icon with scale and rotation
//             Transform.scale(
//               scale: _continuousPulse.value,
//               child: TweenAnimationBuilder<double>(
//                 tween: Tween(begin: 0, end: 1),
//                 duration: const Duration(milliseconds: 800),
//                 curve: Curves.elasticOut,
//                 builder: (context, value, child) {
//                   return Transform.rotate(
//                     angle: value * 0.1,
//                     child: Icon(widget.icon, color: widget.color, size: 24.sp),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import 'exercise_detail_animated_value.dart';

class QuickInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;
  final int index;

  const QuickInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    this.index = 0,
  });

  @override
  State<QuickInfoCard> createState() => _QuickInfoCardState();
}

class _QuickInfoCardState extends State<QuickInfoCard>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _continuousController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _continuousPulse;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _continuousController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _entryController, curve: Curves.easeOut));

    _continuousPulse = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _continuousController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() {
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _entryController.forward();
      }
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _continuousController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedBuilder(
          animation: _slideAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _slideAnimation.value),
              child: child,
            );
          },
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: widget.color.withValues(alpha: isDark ? 0.4 : 0.3),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAnimatedIcon(),
                SizedBox(height: 8.h),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                ),
                SizedBox(height: 4.h),
                ExerciseDetailAnimatedValue(
                  value: widget.value,
                  color: widget.color,
                  controller: _entryController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return AnimatedBuilder(
      animation: _continuousPulse,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 40.w * _continuousPulse.value,
              height: 40.w * _continuousPulse.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withValues(
                      alpha: 0.3 * (2 - _continuousPulse.value),
                    ),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: _continuousPulse.value,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.elasticOut,
                builder: (context, value, child) {
                  return Transform.rotate(
                    angle: value * 0.1,
                    child: Icon(widget.icon, color: widget.color, size: 24.sp),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
