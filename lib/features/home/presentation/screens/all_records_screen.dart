import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:fitrix/core/di/get_it.dart';
import 'package:fitrix/core/theming/app_colors.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../data/achievements_models.dart';
import '../cubit/achievements_cubit.dart';
import '../cubit/achievements_state.dart';
import 'record_detail_screen.dart';

class AllRecordsScreen extends StatelessWidget {
  const AllRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: di<AchievementsCubit>(),
      child: const _AllRecordsView(),
    );
  }
}

class _AllRecordsView extends StatelessWidget {
  const _AllRecordsView();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.all_records, style: TextStyles.headline3),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<AchievementsCubit, AchievementsState>(
        builder: (context, state) {
          if (state is AchievementsLoading) {
            return _buildLoadingState(context);
          }

          if (state is AchievementsError) {
            return _buildErrorState(context, state.message, s);
          }

          if (state is AchievementsLoaded || state is AchievementsRefreshing) {
            final achievements = state is AchievementsLoaded
                ? state.achievements
                : (state as AchievementsRefreshing).currentAchievements;

            if (achievements.milestones.isEmpty) {
              return _buildEmptyState(s.no_personal_records_yet);
            }

            return RefreshIndicator(
              color: ColorsManager.primaryGreen,
              onRefresh: () async {
                await context.read<AchievementsCubit>().refreshAchievements();
              },
              child: _buildRecordsList(context, achievements),
            );
          }

          if (state is AchievementsEmpty) {
            return _buildEmptyState(state.message);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRecordsList(
    BuildContext context,
    AchievementsResponse achievements,
  ) {
    return ListView(
      padding: EdgeInsets.all(20.w),
      children: [
        // Stats Summary
        _buildStatsSummary(achievements, context),
        SizedBox(height: 24.h),

        // All Milestones
        ...achievements.milestones.asMap().entries.map((entry) {
          final index = entry.key;
          final milestone = entry.value;

          return TweenAnimationBuilder(
            duration: Duration(milliseconds: 400 + (index * 100)),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.easeOutCubic,
            builder: (context, double value, child) {
              final clampedValue = value.clamp(0.0, 1.0);
              return Opacity(
                opacity: clampedValue,
                child: Transform.translate(
                  offset: Offset(30 * (1 - clampedValue), 0),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: _buildMilestoneCard(context, milestone, index),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStatsSummary(AchievementsResponse achievements, context) {
    final s = S.of(context); // ✅ Add localization

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            Icons.emoji_events_rounded,
            achievements.totalRecords.toString(),
            s.total, // ✅ Localized
          ),
          _buildDivider(),
          _buildStatItem(
            Icons.fitness_center_rounded,
            achievements.weightRecords.toString(),
            s.weight, // ✅ Localized
          ),
          _buildDivider(),
          _buildStatItem(
            Icons.repeat_rounded,
            achievements.repsRecords.toString(),
            s.reps, // ✅ Localized
          ),
          _buildDivider(),
          _buildStatItem(
            Icons.timeline_rounded,
            achievements.volumeRecords.toString(),
            s.volume, // ✅ Localized
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final s = S.of(context); // ✅ Add localization

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50.w,
            height: 50.h,
            child: CircularProgressIndicator(
              color: ColorsManager.primaryGreen,
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 16.h),
          Text(s.loading_records, style: TextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24.sp),
        SizedBox(height: 8.h),
        Text(value, style: TextStyles.font20Bold.copyWith(color: Colors.white)),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyles.font12Regular.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1.w,
      height: 60.h,
      color: Colors.white.withValues(alpha: 0.3),
    );
  }

  Widget _buildMilestoneCard(
    BuildContext context,
    MilestoneModel milestone,
    int index,
  ) {
    final colors = [
      ColorsManager.warning,
      ColorsManager.primaryGreen,
      ColorsManager.info,
    ];
    final color = colors[index % colors.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecordDetailScreen(milestone: milestone),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.04),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -10.w,
              top: -10.h,
              child: Opacity(
                opacity: 0.08,
                child: Text(milestone.icon, style: TextStyle(fontSize: 60.sp)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withValues(alpha: 0.7)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      milestone.icon,
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          milestone.title,
                          style: TextStyles.font16Bold.copyWith(color: color),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          milestone.description,
                          style: TextStyles.font13Regular.copyWith(
                            color: ColorsManager.primaryText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 11.sp,
                              color: ColorsManager.secondaryText,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              DateFormat('MMM d, yyyy').format(milestone.date),
                              style: TextStyles.font11Regular.copyWith(
                                color: ColorsManager.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: color, size: 24.sp),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, S s) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
            SizedBox(height: 16.h),
            Text(
              message,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                context.read<AchievementsCubit>().loadAchievements();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(s.retry, style: TextStyles.font14WhiteSemiBold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 80.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 24.h),
            Text(
              message,
              style: TextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
