import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/mock_data.dart';
import '../../../host/presentation/widgets/recent_workout_card.dart';

class TrainerWorkoutsScreen extends StatefulWidget {
  const TrainerWorkoutsScreen({super.key});

  @override
  State<TrainerWorkoutsScreen> createState() => _TrainerWorkoutsScreenState();
}

class _TrainerWorkoutsScreenState extends State<TrainerWorkoutsScreen> {
  String _selectedFilter = 'all';

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // Mock workout from all trainees
    final workouts = MockData.getMockUserDashboard().recentWorkouts ?? [];

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.workouts, style: TextStyles.headline2),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: ColorsManager.primaryGreen,
            ),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        color: ColorsManager.primaryGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Row
              _buildStatsRow(s),
              SizedBox(height: 24.h),

              // Filter Chips
              _buildFilterChips(s),
              SizedBox(height: 24.h),

              // Workouts List
              Text(s.recent_workouts, style: TextStyles.subtitle1),
              SizedBox(height: 16.h),

              if (workouts.isNotEmpty)
                ...workouts
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: RecentWorkoutCard(
                          workout: entry.value,
                          index: entry.key,
                        ),
                      ),
                    )
                    .toList()
              else
                _buildEmptyState(s),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'create_workout_trainer_fab',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.create_workout),
              backgroundColor: ColorsManager.success,
            ),
          );
        },
        backgroundColor: ColorsManager.primaryGreen,
        foregroundColor: ColorsManager.whiteText,
        icon: const Icon(Icons.add),
        label: Text(s.create_workout, style: TextStyles.buttonMedium),
      ),
    );
  }

  Widget _buildStatsRow(S s) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.fitness_center,
            value: '156',
            label: s.total_workouts,
            color: ColorsManager.info,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            icon: Icons.people,
            value: '4',
            label: s.active_trainees,
            color: ColorsManager.success,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32.sp),
          SizedBox(height: 8.h),
          Text(value, style: TextStyles.font24PrimaryTextBold),
          SizedBox(height: 4.h),
          Text(label, style: TextStyles.bodySmall, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildFilterChips(S s) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(s.all, 'all'),
          SizedBox(width: 8.w),
          _buildChip(s.today, 'today'),
          SizedBox(width: 8.w),
          _buildChip(s.this_week, 'week'),
          SizedBox(width: 8.w),
          _buildChip(s.this_month, 'month'),
        ],
      ),
    );
  }

  Widget _buildChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = value;
        });
      },
      backgroundColor: ColorsManager.cardBackground,
      selectedColor: ColorsManager.primaryGreen,
      labelStyle: TextStyles.bodyMedium.copyWith(
        color: isSelected ? ColorsManager.whiteText : ColorsManager.primaryText,
      ),
    );
  }

  Widget _buildEmptyState(S s) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.fitness_center_outlined,
              size: 64.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 16.h),
            Text(s.no_workouts_found, style: TextStyles.headline3),
            SizedBox(height: 8.h),
            Text(
              s.start_tracking,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    final s = S.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(s.filter, style: TextStyles.headline3),
              SizedBox(height: 20.h),
              ListTile(
                leading: const Icon(
                  Icons.all_inclusive,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.all),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: ColorsManager.success,
                ),
                title: Text(s.completed),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.pending, color: ColorsManager.info),
                title: Text(s.in_progress),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
