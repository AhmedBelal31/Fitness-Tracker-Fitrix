import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../cubits/trainer_dashboard_cubit.dart';

class TrainerStatsCard extends StatelessWidget {
  const TrainerStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<TrainerDashboardCubit, TrainerDashboardState>(
      builder: (context, state) {
        if (state is TrainerDashboardLoaded) {
          return Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        icon: Icons.people,
                        label: S.of(context).total_clients,
                        value: '${state.dashboard.totalTrainees}',
                        color: ColorsManager.getPrimaryGreen(context),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _StatItem(
                        icon: Icons.fitness_center,
                        label: S.of(context).workouts,
                        value: '${state.dashboard.totalWorkoutsCreated}',
                        color: ColorsManager.info,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: _StatItem(
                        icon: Icons.check_circle,
                        label: S.of(context).active,
                        value: '${state.dashboard.activeTrainees}',
                        color: ColorsManager.success,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _StatItem(
                        icon: Icons.pending_actions,
                        label: S.of(context).pending,
                        value: '${state.dashboard.pendingRequests}',
                        color: ColorsManager.warning,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.sp,
            color: ColorsManager.getSecondaryText(context),
          ),
        ),
      ],
    );
  }
}
