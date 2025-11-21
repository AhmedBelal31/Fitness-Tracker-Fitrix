import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../host/presentation/widgets/stat_card.dart';
import '../../../data/mock_data.dart';

class UserHomeStats extends StatelessWidget {
  const UserHomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = MockData.getMockUserDashboard().workoutStats;
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            StatCard(
              icon: Icons.fitness_center,
              title: s.workouts,
              value: stats?.thisMonth.toString() ?? '0',
              subtitle: s.this_month,
              color: ColorsManager.info,
              index: 0,
            ),
            SizedBox(width: 12.w),
            StatCard(
              icon: Icons.timer,
              title: s.avg_duration,
              value: '${stats?.averageDuration ?? 0}',
              subtitle: s.minutes,
              color: ColorsManager.success,
              index: 1,
            ),
            SizedBox(width: 12.w),
            StatCard(
              icon: Icons.check_circle,
              title: s.completion,
              value: '${stats?.completionRate ?? 0}%',
              subtitle: s.rate,
              color: ColorsManager.warning,
              index: 2,
            ),
          ],
        ),
      ),
    );
  }
}
