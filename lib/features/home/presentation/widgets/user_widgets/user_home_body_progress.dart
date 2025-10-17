import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../host/presentation/widgets/progress_chart_widget.dart';
import '../../../data/mock_data.dart';
import 'user_home_section_header.dart';

class UserHomeBodyProgress extends StatelessWidget {
  const UserHomeBodyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final bodyProgress = MockData.getMockUserDashboard().bodyProgress;
    final s = S.of(context);

    if (bodyProgress == null) return const SizedBox.shrink();

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserHomeSectionHeader(
            title: s.body_progress,
            onSeeAll: () {
              // Navigate to full progress screen
            },
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: ColorsManager.cardShadow,
            ),
            child: Column(
              children: [
                _buildProgressItem(
                  s.current_weight,
                  '${bodyProgress.currentWeight} ${s.kg}',
                  bodyProgress.weightChange.toString(),
                  Icons.monitor_weight_outlined,
                  ColorsManager.info,
                ),
                SizedBox(height: 16.h),
                _buildProgressItem(
                  s.body_fat,
                  '${bodyProgress.bodyFatChange}%',
                  bodyProgress.bodyFatChange.toString(),
                  Icons.percent,
                  ColorsManager.warning,
                ),
                SizedBox(height: 16.h),
                _buildProgressItem(
                  s.muscle_mass,
                  '${bodyProgress.muscleMassChange} ${s.kg}',
                  bodyProgress.muscleMassChange.toString(),
                  Icons.fitness_center,
                  ColorsManager.success,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressItem(
    String label,
    String value,
    String change,
    IconData icon,
    Color color,
  ) {
    final isPositive = change.startsWith('+');
    final changeColor = isPositive
        ? ColorsManager.success
        : ColorsManager.error;

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: color, size: 24.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyles.bodySmall),
              Text(value, style: TextStyles.font16PrimaryTextSemiBold),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: changeColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            change,
            style: TextStyles.bodySmall.copyWith(
              color: changeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
