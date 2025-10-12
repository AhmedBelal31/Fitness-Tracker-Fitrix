import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../home/data/body_progress_model.dart';

class ProgressChartWidget extends StatelessWidget {
  final BodyProgressModel bodyProgress;

  const ProgressChartWidget({required this.bodyProgress, super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Weight
          _buildProgressItem(
            context,
            icon: Icons.monitor_weight,
            title: s.current_weight,
            value: '${bodyProgress.currentWeight} ${s.kg}',
            change: bodyProgress.weightChange,
            color: ColorsManager.info,
          ),
          SizedBox(height: 16.h),

          // Body Fat
          if (bodyProgress.currentBodyFat != null)
            _buildProgressItem(
              context,
              icon: Icons.speed,
              title: s.body_fat,
              value: '${bodyProgress.currentBodyFat}%',
              change: bodyProgress.bodyFatChange,
              color: ColorsManager.caloriesBurned,
            ),
          if (bodyProgress.currentBodyFat != null) SizedBox(height: 16.h),

          // Muscle Mass
          if (bodyProgress.muscleMassChange != null)
            _buildProgressItem(
              context,
              icon: Icons.fitness_center,
              title: s.muscle_mass,
              value: '+${bodyProgress.muscleMassChange} ${s.kg}',
              change: bodyProgress.muscleMassChange,
              color: ColorsManager.success,
            ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required double? change,
    required Color color,
  }) {
    final isPositive = change != null && change > 0;
    final isNegative = change != null && change < 0;

    return Row(
      children: [
        // Icon
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(width: 12.w),

        // Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyles.bodyMedium),
              SizedBox(height: 2.h),
              Text(value, style: TextStyles.font18PrimaryTextMedium),
            ],
          ),
        ),

        // Change Indicator
        if (change != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isPositive
                  ? ColorsManager.success.withValues(alpha: 0.1)
                  : isNegative
                  ? ColorsManager.error.withValues(alpha: 0.1)
                  : ColorsManager.grey200,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPositive
                      ? Icons.arrow_upward
                      : isNegative
                      ? Icons.arrow_downward
                      : Icons.remove,
                  size: 14.sp,
                  color: isPositive
                      ? ColorsManager.success
                      : isNegative
                      ? ColorsManager.error
                      : ColorsManager.lightText,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${change.abs()} ${S.of(context).kg}',
                  style: TextStyles.caption.copyWith(
                    color: isPositive
                        ? ColorsManager.success
                        : isNegative
                        ? ColorsManager.error
                        : ColorsManager.lightText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
