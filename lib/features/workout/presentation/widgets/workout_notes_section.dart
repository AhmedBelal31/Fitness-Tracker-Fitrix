import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class WorkoutNotesSection extends StatelessWidget {
  final String notes;

  const WorkoutNotesSection({super.key, required this.notes});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: ColorsManager.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.notes,
                      color: ColorsManager.primaryGreen,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(s.notes, style: TextStyles.subtitle1),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(notes, style: TextStyles.bodyMedium),
              ],
            ),
          ),
        );
      },
    );
  }
}
