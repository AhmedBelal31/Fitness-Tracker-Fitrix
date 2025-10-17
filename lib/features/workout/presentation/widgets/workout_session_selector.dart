import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../exercises/data/models/exercise_model.dart';
import '../../data/workout_session_model.dart';
import '../cubit/workouts_cubit.dart';
import '../cubit/workouts_state.dart';

class WorkoutSessionSelector extends StatefulWidget {
  final ExerciseModel exercise;
  final Function(String sessionId) onSessionSelected;

  const WorkoutSessionSelector({
    super.key,
    required this.exercise,
    required this.onSessionSelected,
  });

  @override
  State<WorkoutSessionSelector> createState() => _WorkoutSessionSelectorState();
}

class _WorkoutSessionSelectorState extends State<WorkoutSessionSelector> {
  @override
  void initState() {
    super.initState();
    context.read<WorkoutsCubit>().loadWorkoutHistory();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.select_workout, style: TextStyles.headline3),
                      SizedBox(height: 4.h),
                      Text(
                        widget.exercise.name,
                        style: TextStyles.bodyMedium.copyWith(
                          color: ColorsManager.lightText,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => _createNewSession(s),
                    icon: Icon(
                      Icons.add_circle,
                      color: ColorsManager.primaryGreen,
                      size: 28.sp,
                    ),
                  ),
                ],
              ),
            ),

            Divider(height: 1, color: Colors.grey[300]),

            // Sessions List
            Expanded(
              child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
                builder: (context, state) {
                  if (state is WorkoutsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.primaryGreen,
                      ),
                    );
                  }

                  if (state is WorkoutHistoryLoaded) {
                    if (state.sessions.isEmpty) {
                      return _buildEmptyState(s);
                    }

                    return ListView.separated(
                      controller: scrollController,
                      padding: EdgeInsets.all(20.w),
                      itemCount: state.sessions.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final session = state.sessions[index];
                        return _buildSessionCard(session, s);
                      },
                    );
                  }

                  return _buildEmptyState(s);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSessionCard(WorkoutSessionModel session, S s) {
    final dateFormat = DateFormat('EEEE, MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');
    final isCompleted = session.isCompleted;

    return InkWell(
      onTap: isCompleted
          ? null // ✅ Disable tapping on completed sessions
          : () {
              widget.onSessionSelected(session.id);
              Navigator.pop(context);
            },
      borderRadius: BorderRadius.circular(12.r),
      child: Opacity(
        opacity: isCompleted ? 0.6 : 1.0, // ✅ Show as disabled
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isCompleted
                  ? Colors.grey[300]!
                  : ColorsManager.primaryGreen,
              width: isCompleted ? 1 : 2,
            ),
            boxShadow: isCompleted ? [] : ColorsManager.softShadow,
          ),
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.grey[200]
                      : ColorsManager.primaryGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle : Icons.fitness_center,
                  color: isCompleted
                      ? Colors.grey[600]
                      : ColorsManager.primaryGreen,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateFormat.format(session.date),
                      style: TextStyles.subtitle1.copyWith(
                        color: isCompleted
                            ? Colors.grey[600]
                            : ColorsManager.primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        if (session.startTime != null) ...[
                          Icon(
                            Icons.schedule,
                            size: 14.sp,
                            color: ColorsManager.lightText,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            timeFormat.format(session.startTime!),
                            style: TextStyles.bodySmall.copyWith(
                              color: ColorsManager.lightText,
                            ),
                          ),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          '${session.workoutExercises.length} ${s.exercises}',
                          style: TextStyles.bodySmall.copyWith(
                            color: ColorsManager.lightText,
                          ),
                        ),
                        if (isCompleted) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              s.completed,
                              style: TextStyles.caption.copyWith(
                                color: Colors.grey[700],
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                isCompleted ? Icons.lock : Icons.chevron_right,
                color: ColorsManager.lightText,
                size: 24.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(S s) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center_outlined,
              size: 64.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 16.h),
            Text(s.no_workout_sessions, style: TextStyles.headline3),
            SizedBox(height: 8.h),
            Text(
              s.create_new_session_to_start,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => _createNewSession(s),
              icon: const Icon(Icons.add),
              label: Text(s.create_session),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void _createNewSession(S s) {
  //   context.read<WorkoutsCubit>().createWorkoutSession(
  //     date: DateTime.now(),
  //     notes: null,
  //   );
  //
  //   // Show success and reload
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(s.session_created),
  //       backgroundColor: ColorsManager.success,
  //     ),
  //   );
  // }

  Future<void> _createNewSession(S s) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.confirm_create_session),
        content: Text(s.are_you_sure),
        actions: [
          TextButton(
            child: Text(s.cancel),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            child: Text(s.confirm),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      // Optionally, await any animation or async process here (e.g. reverse _controller)
      // await _controller.reverse();

      // Call the cubit method to create the workout session
      context.read<WorkoutsCubit>().createWorkoutSession(
        date: DateTime.now(),
        notes: null,
      );

      // Show confirmation message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.session_created),
            backgroundColor: ColorsManager.success,
          ),
        );
      }

      // If this method itself is called within a dialog, you can close it here
      Navigator.of(context).pop();
    }
  }
}
