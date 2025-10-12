import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/dashboard_model.dart';

class UserWorkoutsScreen extends StatefulWidget {
  const UserWorkoutsScreen({super.key});

  @override
  State<UserWorkoutsScreen> createState() => _UserWorkoutsScreenState();
}

class _UserWorkoutsScreenState extends State<UserWorkoutsScreen> {
  String _selectedFilter = 'all';

  // Mock workout data
  final List<RecentWorkoutModel> _workouts = [
    RecentWorkoutModel(
      id: '1',
      date: '2025-10-08',
      duration: 50,
      exercises: ['Bench Press', 'Incline Press', 'Cable Flyes'],
      totalSets: 12,
      isCompleted: true,
    ),
    RecentWorkoutModel(
      id: '2',
      date: '2025-10-07',
      duration: 45,
      exercises: ['Squats', 'Leg Press', 'Leg Curls', 'Calf Raises'],
      totalSets: 15,
      isCompleted: true,
    ),
    RecentWorkoutModel(
      id: '3',
      date: '2025-10-05',
      duration: 40,
      exercises: ['Deadlift', 'Rows', 'Pull-ups'],
      totalSets: 10,
      isCompleted: false,
    ),
    RecentWorkoutModel(
      id: '4',
      date: '2025-10-03',
      duration: 55,
      exercises: ['Shoulder Press', 'Lateral Raises', 'Front Raises'],
      totalSets: 14,
      isCompleted: true,
    ),
    RecentWorkoutModel(
      id: '5',
      date: '2025-10-01',
      duration: 35,
      exercises: ['Biceps Curls', 'Triceps Extensions', 'Hammer Curls'],
      totalSets: 9,
      isCompleted: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.my_workouts, style: TextStyles.headline2),
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

              // Workout List
              Text(s.workout_history, style: TextStyles.subtitle1),
              SizedBox(height: 16.h),
              ..._workouts.map(
                (workout) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _buildWorkoutCard(workout),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'create_workout_fab', // Add unique tag
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
            value: '48',
            label: s.total_workouts,
            color: ColorsManager.info,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            icon: Icons.timer,
            value: '45',
            label: '${s.avg_duration} (${s.minutes})',
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

  Widget _buildWorkoutCard(RecentWorkoutModel workout) {
    final s = S.of(context);
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening workout details'),
            backgroundColor: ColorsManager.info,
          ),
        );
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: workout.isCompleted
                            ? ColorsManager.success.withOpacity(0.1)
                            : ColorsManager.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        workout.isCompleted
                            ? Icons.check_circle
                            : Icons.pending,
                        color: workout.isCompleted
                            ? ColorsManager.success
                            : ColorsManager.info,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      _formatDate(workout.date),
                      style: TextStyles.font16PrimaryTextRegular,
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                  size: 24.sp,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: ColorsManager.lightBorder, height: 1),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 16.sp,
                  color: ColorsManager.primaryGreen,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${workout.exercises.length} ${s.exercises}',
                  style: TextStyles.bodySmall,
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.list,
                  size: 16.sp,
                  color: ColorsManager.primaryGreen,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${workout.totalSets} ${s.sets}',
                  style: TextStyles.bodySmall,
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.timer,
                  size: 16.sp,
                  color: ColorsManager.primaryGreen,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${workout.duration} ${s.minutes}',
                  style: TextStyles.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) return S.of(context).today;
      if (difference == 1) return 'Yesterday';
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        final s = S.of(context);
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(s.filter, style: TextStyles.headline3),
              SizedBox(height: 20.h),
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
              ListTile(
                leading: const Icon(
                  Icons.all_inclusive,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.all),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }
}
