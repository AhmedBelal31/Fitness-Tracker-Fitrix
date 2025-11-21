import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter/services.dart';

class UserHomeCustomExercises extends StatefulWidget {
  const UserHomeCustomExercises({super.key});

  @override
  State<UserHomeCustomExercises> createState() =>
      _UserHomeCustomExercisesState();
}

class _UserHomeCustomExercisesState extends State<UserHomeCustomExercises>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _shineController;
  late Animation<double> _glowAnimation;
  late Animation<double> _shineAnimation;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _shineController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _glowAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _shineAnimation = Tween<double>(
      begin: -1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _shineController, curve: Curves.linear));
  }

  @override
  void dispose() {
    _glowController.dispose();
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_glowController, _shineController]),
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.pushNamed(context, Routes.customExercises);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryGreen.withValues(
                      alpha: 0.3 * _glowAnimation.value,
                    ),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(
                  children: [
                    // Base gradient
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ColorsManager.primaryGreen,
                            ColorsManager.secondaryGreen,
                            ColorsManager.success,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Animated icon with glow
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withValues(
                                    alpha: 0.3 * _glowAnimation.value,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.fitness_center_rounded,
                              color: Colors.white,
                              size: 30.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),

                          // Text content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  s.my_custom_exercises,
                                  style: GoogleFonts.aBeeZee(
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  s.create_your_own_exercises,
                                  style: TextStyles.font13Regular.copyWith(
                                    color: Colors.white.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 4.w),
                          // Arrow with pulse
                          Transform.scale(
                            scale: 0.9 + (0.1 * _glowAnimation.value),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 24.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Shine effect
                    Positioned.fill(
                      child: Transform.translate(
                        offset: Offset(
                          MediaQuery.of(context).size.width *
                              _shineAnimation.value,
                          0,
                        ),
                        child: Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.2),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
