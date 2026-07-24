import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class EmptyExercisesState extends StatelessWidget {
  final VoidCallback onCreateTap;
  final bool hasFilters;
  final VoidCallback? onClearFilters;

  const EmptyExercisesState({
    super.key,
    required this.onCreateTap,
    this.hasFilters = false,
    this.onClearFilters,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic, // Changed from elasticOut to easeOutCubic
      builder: (context, double value, child) {
        // Clamp opacity to valid range
        final clampedOpacity = value.clamp(0.0, 1.0);

        return Opacity(
          opacity: clampedOpacity,
          child: Transform.scale(scale: 0.8 + (0.2 * value), child: child),
        );
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              SizedBox(height: 24.h),
              _buildTitle(s),
              SizedBox(height: 12.h),
              _buildDescription(s),
              SizedBox(height: 32.h),
              if (hasFilters)
                _buildClearFiltersButton(s)
              else
                _buildCreateButton(s),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutBack, // Changed from elasticOut to easeOutBack
      builder: (context, double value, child) {
        return Transform.rotate(
          angle: (1 - value) * 0.5,
          child: Transform.scale(
            scale: value.clamp(0.0, 1.0), // Clamp scale value
            child: child,
          ),
        );
      },
      child: Container(
        width: 120.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: ColorsManager.primaryGreen.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          hasFilters ? Icons.search_off : Icons.fitness_center_outlined,
          size: 60.sp,
          color: ColorsManager.primaryGreen,
        ),
      ),
    );
  }

  Widget _buildTitle(S s) {
    return Text(
      hasFilters ? s.no_exercises_found : s.no_custom_exercises_yet,
      style: TextStyles.headline3,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(S s) {
    return Text(
      hasFilters ? s.try_different_filters : s.create_your_own_exercises,
      style: TextStyles.bodyMedium.copyWith(color: ColorsManager.secondaryText),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCreateButton(S s) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value.clamp(0.8, 1.0), // Clamp scale value
          child: child,
        );
      },
      child: ElevatedButton.icon(
        onPressed: onCreateTap,
        icon: const Icon(Icons.add, size: 20),
        label: Text(s.create_your_first_exercise),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          foregroundColor: ColorsManager.whiteText,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
        ),
      ),
    );
  }

  Widget _buildClearFiltersButton(S s) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Transform.scale(
          scale: value.clamp(0.8, 1.0), // Clamp scale value
          child: child,
        );
      },
      child: ElevatedButton.icon(
        onPressed: onClearFilters,
        icon: const Icon(Icons.clear, size: 20),
        label: Text(s.clear_filters),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          foregroundColor: ColorsManager.whiteText,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
