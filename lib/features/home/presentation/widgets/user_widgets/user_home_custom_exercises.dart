import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1100),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic, // ✅ Changed from easeOutBack to easeOutCubic
      builder: (context, double value, child) {
        final clampedValue = value.clamp(0.0, 1.0); // ✅ Clamp value

        return Transform.scale(
          scale: 0.95 + (0.05 * clampedValue),
          child: Opacity(
            opacity: clampedValue, // ✅ Use clamped value
            child: child,
          ),
        );
      },
      child: ScaleTransition(
        scale: _pulseAnimation,
        child: InkWell(
          onTap: () {
            HapticFeedback.mediumImpact();
            Navigator.pushNamed(context, Routes.customExercises);
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [ColorsManager.primaryGreen, ColorsManager.success],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.primaryGreen.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 32.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.my_custom_exercises,
                        style: TextStyles.font16WhiteRegular.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        s.create_your_own_exercises,
                        style: TextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
