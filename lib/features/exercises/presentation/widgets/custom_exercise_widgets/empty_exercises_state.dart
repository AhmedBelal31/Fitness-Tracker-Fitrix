import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class EmptyExercisesState extends StatelessWidget {
  final VoidCallback onCreateTap;

  const EmptyExercisesState({super.key, required this.onCreateTap});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(
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
            _buildCreateButton(s),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        color: ColorsManager.lightGreen.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.fitness_center_outlined,
        size: 60.sp,
        color: ColorsManager.primaryGreen,
      ),
    );
  }

  Widget _buildTitle(S s) {
    return Text(
      s.no_custom_exercises_yet,
      style: TextStyles.headline3,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription(S s) {
    return Text(
      s.create_your_own_exercises,
      style: TextStyles.bodyMedium.copyWith(color: ColorsManager.secondaryText),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildCreateButton(S s) {
    return ElevatedButton.icon(
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
        elevation: 2,
      ),
    );
  }
}
