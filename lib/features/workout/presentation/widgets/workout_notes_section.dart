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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12.r),
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
                Row(
                  children: [
                    Icon(
                      Icons.notes,
                      color: ColorsManager.getPrimaryGreen(context),
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      s.notes,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  notes,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
