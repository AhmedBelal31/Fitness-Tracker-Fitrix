// lib/features/trainer/presentation/widgets/active_trainees_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/routing/routes.dart';
import '../cubits/trainer_dashboard_cubit.dart';

class ActiveTraineesSection extends StatelessWidget {
  const ActiveTraineesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).recent_clients,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.getPrimaryText(context),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.trainerClients);
              },
              child: Text(S.of(context).view_all),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        BlocBuilder<TrainerDashboardCubit, TrainerDashboardState>(
          builder: (context, state) {
            if (state is TrainerDashboardLoaded) {
              final recentTrainees = state.dashboard.recentTrainees ?? [];

              if (recentTrainees.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.h),
                    child: Text(
                      S.of(context).no_clients_yet,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentTrainees.take(5).length,
                itemBuilder: (context, index) {
                  final trainee = recentTrainees[index];
                  return _TraineeListItem(trainee: trainee);
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

class _TraineeListItem extends StatelessWidget {
  final dynamic trainee;

  const _TraineeListItem({required this.trainee});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.2),
            child: Text(
              '${trainee.firstName[0]}${trainee.lastName[0]}'.toUpperCase(),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.getPrimaryGreen(context),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${trainee.firstName} ${trainee.lastName}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
                Text(
                  trainee.email,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
