import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/workout_session_entity.dart';
import '../cubit/workouts_cubit.dart';
import '../cubit/workouts_state.dart';
import 'workout_detail_widgets.dart';
import 'workout_exercise_card.dart';

// class WorkoutExercisesList extends StatelessWidget {
//   final WorkoutSessionEntity workout;
//   final String workoutId;
//
//   const WorkoutExercisesList({
//     super.key,
//     required this.workout,
//     required this.workoutId,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     if (workout.workoutExercises.isEmpty) {
//       return _buildEmptyState(s);
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(s.exercises, style: TextStyles.subtitle1),
//         SizedBox(height: 16.h),
//         // ✅ Wrap only the list in BlocBuilder to rebuild exercises independently
//         BlocBuilder<WorkoutsCubit, WorkoutsState>(
//           buildWhen: (previous, current) => current is WorkoutSessionLoaded,
//           builder: (context, state) {
//             if (state is! WorkoutSessionLoaded) {
//               return const SizedBox.shrink();
//             }
//
//             return Column(
//               children: state.session.workoutExercises.asMap().entries.map((
//                 entry,
//               ) {
//                 return AnimatedExerciseCard(
//                   index: entry.key,
//                   child: WorkoutExerciseCard(
//                     workoutExercise: entry.value,
//                     workoutId: workoutId,
//                     isWorkoutCompleted: state.session.isCompleted,
//                   ),
//                 );
//               }).toList(),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildEmptyState(S s) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(40.w),
//         child: Column(
//           children: [
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 800),
//               builder: (context, value, child) {
//                 return Transform.scale(
//                   scale: value,
//                   child: Icon(
//                     Icons.fitness_center_outlined,
//                     size: 64.sp,
//                     color: ColorsManager.lightText,
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 16.h),
//             Text(s.no_exercises_added, style: TextStyles.headline3),
//             SizedBox(height: 8.h),
//             Text(
//               s.exercises_will_appear_here,
//               style: TextStyles.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class WorkoutExercisesList extends StatelessWidget {
  final WorkoutSessionEntity workout;
  final String workoutId;

  const WorkoutExercisesList({
    super.key,
    required this.workout,
    required this.workoutId,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    if (workout.workoutExercises.isEmpty) {
      return _buildEmptyState(s);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.exercises, style: TextStyles.subtitle1),
        SizedBox(height: 16.h),
        BlocBuilder<WorkoutsCubit, WorkoutsState>(
          buildWhen: (previous, current) => current is WorkoutSessionLoaded,
          builder: (context, state) {
            if (state is! WorkoutSessionLoaded) {
              return const SizedBox.shrink();
            }

            return Column(
              children: state.session.workoutExercises.asMap().entries.map((
                entry,
              ) {
                // ✅ No need for copyWith - just pass the entity as is
                return AnimatedExerciseCard(
                  index: entry.key,
                  child: WorkoutExerciseCard(
                    workoutExercise: entry.value,
                    workoutId: workoutId,
                    isWorkoutCompleted: state.session.isCompleted,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState(S s) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    Icons.fitness_center_outlined,
                    size: 64.sp,
                    color: ColorsManager.lightText,
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            Text(s.no_exercises_added, style: TextStyles.headline3),
            SizedBox(height: 8.h),
            Text(
              s.exercises_will_appear_here,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
