import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/exercise_model.dart';

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;

  const ExerciseCard({required this.exercise, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
          border: exercise.isCustom
              ? Border.all(color: ColorsManager.primaryGreen, width: 2)
              : null,
        ),
        child: Row(
          children: [
            // Exercise Icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                gradient: ColorsManager.cardGradient,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 30.sp,
              ),
            ),
            SizedBox(width: 16.w),

            // Exercise Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getExerciseName(s, exercise.name),
                          style: TextStyles.font16PrimaryTextRegular,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (exercise.isCustom)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            s.custom,
                            style: TextStyles.caption.copyWith(
                              color: ColorsManager.primaryGreen,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _getEquipmentName(s, exercise.equipment),
                    style: TextStyles.bodySmall,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _buildDifficultyBadge(s, exercise.difficulty),
                      SizedBox(width: 8.w),
                      if (exercise.muscleGroups.isNotEmpty)
                        Expanded(
                          child: Text(
                            _getLocalizedMuscleGroups(s, exercise.muscleGroups),
                            style: TextStyles.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  String _getExerciseName(S s, String exerciseName) {
    // Map exercise names to localization keys
    final nameMap = {
      'Bench Press': s.bench_press,
      'Incline Dumbbell Press': s.incline_dumbbell_press,
      'Cable Flyes': s.cable_flyes,
      'Push-ups': s.push_ups,
      'Dumbbell Flyes': s.dumbbell_flyes,
      'Deadlift': s.deadlift,
      'Pull-ups': s.pull_ups,
      'Barbell Rows': s.barbell_rows,
      'Lat Pulldown': s.lat_pulldown,
      'Squats': s.squats,
      'Leg Press': s.leg_press,
      'Romanian Deadlift': s.romanian_deadlift,
      'Leg Curls': s.leg_curls,
      'Calf Raises': s.calf_raises,
      'Overhead Press': s.overhead_press,
      'Lateral Raises': s.lateral_raises,
      'Front Raises': s.front_raises,
      'Barbell Curls': s.barbell_curls,
      'Tricep Dips': s.tricep_dips,
      'Hammer Curls': s.hammer_curls,
      'Overhead Tricep Extension': s.overhead_tricep_extension,
      'Planks': s.planks,
      'Crunches': s.crunches,
      'Russian Twists': s.russian_twists,
      'Leg Raises': s.leg_raises,
    };

    return nameMap[exerciseName] ?? exerciseName;
  }

  String _getEquipmentName(S s, String equipment) {
    switch (equipment.toLowerCase()) {
      case 'barbell':
        return s.barbell;
      case 'dumbbells':
        return s.dumbbells;
      case 'cable machine':
        return s.cable_machine;
      case 'bodyweight':
        return s.bodyweight;
      case 'machine':
        return s.machine;
      case 'pull-up bar':
        return s.pull_up_bar;
      default:
        return equipment;
    }
  }

  String _getLocalizedMuscleGroups(S s, List<String> muscleGroups) {
    return muscleGroups.map((muscle) => _getMuscleName(s, muscle)).join(', ');
  }

  String _getMuscleName(S s, String muscle) {
    final muscleMap = {
      'Chest': s.chest,
      'Upper Chest': s.upper_chest,
      'Triceps': s.triceps,
      'Shoulders': s.shoulders,
      'Lats': s.lats,
      'Biceps': s.biceps,
      'Back': s.back,
      'Lower Back': s.lower_back,
      'Glutes': s.glutes,
      'Hamstrings': s.hamstrings,
      'Quads': s.quads,
      'Side Delts': s.side_delts,
      'Front Delts': s.front_delts,
      'Forearms': s.forearms,
      'Core': s.core,
      'Abs': s.abs,
      'Obliques': s.obliques,
      'Lower Abs': s.lower_abs,
      'Calves': s.calves,
    };

    return muscleMap[muscle] ?? muscle;
  }

  Widget _buildDifficultyBadge(S s, String difficulty) {
    final difficultyName = _getDifficultyName(s, difficulty);
    final color = _getDifficultyColor(difficulty);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        difficultyName,
        style: TextStyles.caption.copyWith(color: color),
      ),
    );
  }

  String _getDifficultyName(S s, String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return s.beginner;
      case 'intermediate':
        return s.intermediate;
      case 'advanced':
        return s.advanced;
      default:
        return difficulty;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return ColorsManager.beginnerLevel;
      case 'intermediate':
        return ColorsManager.intermediateLevel;
      case 'advanced':
        return ColorsManager.advancedLevel;
      default:
        return ColorsManager.info;
    }
  }
}
