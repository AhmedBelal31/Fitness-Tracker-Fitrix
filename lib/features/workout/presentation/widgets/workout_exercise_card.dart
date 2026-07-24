import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/exercise_set_entity.dart';
import '../../domain/entities/workout_exercise_entity.dart';
import 'add_set_dialog.dart';
import 'workout_detail_widgets.dart';

class WorkoutExerciseCard extends StatelessWidget {
  final WorkoutExerciseEntity workoutExercise;
  final String workoutId;
  final bool isWorkoutCompleted;

  const WorkoutExerciseCard({
    super.key,
    required this.workoutExercise,
    required this.workoutId,
    required this.isWorkoutCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Sort sets by setNumber
    final sortedSets = List<ExerciseSetEntity>.from(workoutExercise.sets)
      ..sort((a, b) => (a.setNumber ?? 0).compareTo(b.setNumber ?? 0));

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: 12.h),
          _buildSetsList(context, s, sortedSets),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color:
                      (workoutExercise.isCustomExercise
                              ? ColorsManager.info
                              : ColorsManager.getPrimaryGreen(context))
                          .withValues(alpha: isDark ? 0.15 : 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  workoutExercise.isCustomExercise
                      ? Icons.person
                      : Icons.fitness_center,
                  color: workoutExercise.isCustomExercise
                      ? ColorsManager.info
                      : ColorsManager.getPrimaryGreen(context),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workoutExercise.displayName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (workoutExercise.isCustomExercise)
                      Text(
                        'Custom Exercise',
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.info,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isWorkoutCompleted)
          IconButton(
            onPressed: () => _showAddSetDialog(context),
            icon: Icon(
              Icons.add_circle,
              color: ColorsManager.getPrimaryGreen(context),
              size: 28.sp,
            ),
          ),
      ],
    );
  }

  Widget _buildSetsList(
    BuildContext context,
    S s,
    List<ExerciseSetEntity> sortedSets,
  ) {
    if (sortedSets.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Text(
            s.no_sets_yet,
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.getSecondaryText(context),
            ),
          ),
        ),
      );
    }

    // Use indexed list to show 1, 2, 3... instead of actual setNumber
    return Column(
      children: sortedSets.asMap().entries.map((entry) {
        final index = entry.key;
        final set = entry.value;

        return SetRow(
          setNumber: index + 1, // Display as 1, 2, 3... (1-based)
          reps: set.reps,
          weight: set.weightKg,
          isCompleted: set.isCompleted,
          isPersonalRecord: set.isPersonalRecord,
          onTap: isWorkoutCompleted
              ? null
              : () => _showEditSetDialog(context, set),
        );
      }).toList(),
    );
  }

  void _showAddSetDialog(BuildContext context) {
    // Get next set number based on sorted list
    final sortedSets = List<ExerciseSetEntity>.from(workoutExercise.sets)
      ..sort((a, b) => (a.setNumber ?? 0).compareTo(b.setNumber ?? 0));

    final nextSetNumber = sortedSets.isEmpty
        ? 1
        : (sortedSets.last.setNumber ?? 0) + 1;

    showDialog(
      context: context,
      builder: (context) => AddSetDialog(
        sessionId: workoutId,
        exerciseId: workoutExercise.id,
        setNumber: nextSetNumber,
        onSetAdded: () => Navigator.pop(context),
      ),
    );
  }

  void _showEditSetDialog(BuildContext context, ExerciseSetEntity set) {
    showDialog(
      context: context,
      builder: (context) => AddSetDialog(
        sessionId: workoutId,
        exerciseId: workoutExercise.id,
        setNumber: set.setNumber,
        initialReps: set.reps,
        initialWeight: set.weightKg,
        initialRestTime: set.restTimeSeconds,
        initialNotes: set.notes,
        setId: set.id,
        isEdit: true,
        onSetAdded: () => Navigator.pop(context),
      ),
    );
  }
}
