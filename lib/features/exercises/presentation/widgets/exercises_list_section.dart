import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../workout/presentation/cubit/workouts_cubit.dart';
import '../../data/models/exercise_model.dart';
import '../cubit/exercises_cubit.dart';
import '../cubit/exercises_state.dart';
import 'exercise_card.dart';
import 'exercise_helpers.dart';
import 'section_exercise_widgets.dart';

class ExercisesListSection extends StatelessWidget {
  final String sortBy;
  final bool isAddingToWorkout;
  final String? workoutId;

  const ExercisesListSection({
    super.key,
    required this.sortBy,
    required this.isAddingToWorkout,
    this.workoutId,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocBuilder<ExercisesCubit, ExercisesState>(
      builder: (context, state) {
        if (state is ExercisesLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: const CircularProgressIndicator(
                  color: ColorsManager.primaryGreen,
                ),
              ),
            ),
          );
        }

        if (state is ExercisesLoaded) {
          if (state.exercises.isEmpty) {
            return SliverToBoxAdapter(
              child: AnimatedEmptyState(
                message: s.no_exercises_found,
                subMessage: s.try_adjusting_search,
              ),
            );
          }

          final separated = ExerciseHelpers.separateExercises(
            state.exercises,
            sortBy,
          );

          return _buildExerciseSections(context, s, separated);
        }

        return SliverToBoxAdapter(
          child: AnimatedEmptyState(
            message: s.no_exercises_found,
            subMessage: s.try_adjusting_search,
          ),
        );
      },
    );
  }

  Widget _buildExerciseSections(
    BuildContext context,
    S s,
    Map<String, List<ExerciseModel>> separated,
  ) {
    final customExercises = separated['custom']!;
    final publicExercises = separated['public']!;

    return SliverList(
      delegate: SliverChildListDelegate([
        if (customExercises.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AnimatedSectionHeader(
              icon: Icons.stars,
              title: s.my_custom_exercises,
              count: customExercises.length,
              color: ColorsManager.primaryGreen,
              index: 0,
            ),
          ),
          SizedBox(height: 12.h),
          ...customExercises.asMap().entries.map((entry) {
            return _buildExerciseCard(context, entry.value, entry.key);
          }).toList(),
          SizedBox(height: 24.h),
        ],
        if (publicExercises.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AnimatedSectionHeader(
              icon: Icons.public,
              title: s.public_exercises,
              count: publicExercises.length,
              color: ColorsManager.info,
              index: 1,
            ),
          ),
          SizedBox(height: 12.h),
          ...publicExercises.asMap().entries.map((entry) {
            return _buildExerciseCard(context, entry.value, entry.key);
          }).toList(),
        ],
        SizedBox(height: 80.h),
      ]),
    );
  }

  Widget _buildExerciseCard(
    BuildContext context,
    ExerciseModel exercise,
    int index,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
      child: AnimatedExerciseCardWrapper(
        index: index,
        child: ExerciseCard(
          exercise: exercise,
          onTap: () => _handleExerciseTap(context, exercise),
          trailing: isAddingToWorkout
              ? Icon(
                  Icons.add_circle,
                  color: ColorsManager.primaryGreen,
                  size: 28.sp,
                )
              : null,
        ),
      ),
    );
  }

  void _handleExerciseTap(BuildContext context, ExerciseModel exercise) {
    if (isAddingToWorkout && workoutId != null) {
      context.read<WorkoutsCubit>().addExerciseToWorkout(
        sessionId: workoutId!,
        exerciseId: exercise.isCustomExercise ? null : exercise.id,
        customExerciseId: exercise.isCustomExercise ? exercise.id : null,
      );
    } else {
      Navigator.pushNamed(context, Routes.exerciseDetails, arguments: exercise);
    }
  }
}
