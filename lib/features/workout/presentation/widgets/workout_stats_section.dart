import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/workout_session_entity.dart';
import 'workout_detail_widgets.dart';

class WorkoutStatsSection extends StatelessWidget {
  final WorkoutSessionEntity workout;

  const WorkoutStatsSection({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final totalSets = workout.workoutExercises.fold(
      0,
      (sum, exercise) => sum + exercise.sets.length,
    );

    return Row(
      children: [
        Expanded(
          child: WorkoutStatCard(
            icon: Icons.fitness_center,
            value: workout.workoutExercises.length.toString(),
            label: s.exercises,
            color: ColorsManager.primaryGreen,
            index: 0,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: WorkoutStatCard(
            icon: Icons.repeat,
            value: totalSets.toString(),
            label: s.total_sets,
            color: ColorsManager.info,
            index: 1,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: WorkoutStatCard(
            icon: Icons.timer,
            value: workout.durationMinutes?.toString() ?? '0',
            label: s.minutes,
            color: ColorsManager.success,
            index: 2,
          ),
        ),
      ],
    );
  }
}
