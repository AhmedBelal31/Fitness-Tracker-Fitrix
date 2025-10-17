import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/workout_session_entity.dart';
import '../cubit/workouts_cubit.dart';
import 'workout_timer_manager.dart';

class WorkoutActionsSection extends StatelessWidget {
  final WorkoutSessionEntity workout;
  final String workoutId;
  final WorkoutTimerManager timerManager;

  const WorkoutActionsSection({
    super.key,
    required this.workout,
    required this.workoutId,
    required this.timerManager,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: AnimatedBuilder(
            animation: timerManager,
            builder: (context, child) {
              if (workout.isCompleted) {
                return _buildCompletedBadge(s);
              }

              if (!timerManager.isRunning) {
                return _buildStartButton(context, s);
              }

              return _buildCompleteButton(context, s);
            },
          ),
        );
      },
    );
  }

  Widget _buildStartButton(BuildContext context, S s) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          await timerManager.startWorkout();
          if (context.mounted) {
            context.read<WorkoutsCubit>().startWorkoutSession(workoutId);
          }
        },
        icon: const Icon(Icons.play_arrow, color: Colors.white),
        label: Text(
          s.start_workout,
          style: GoogleFonts.aBeeZee(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteButton(BuildContext context, S s) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          await timerManager.stopWorkout();
          if (context.mounted) {
            context.read<WorkoutsCubit>().completeWorkoutSession(
              workoutId,
              null,
            );
          }
        },
        icon: const Icon(Icons.check_circle, color: Colors.white),
        label: Text(
          '${timerManager.elapsedTime} - ${s.complete_workout}',
          style: GoogleFonts.aBeeZee(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.success,
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  Widget _buildCompletedBadge(S s) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorsManager.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.success),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: ColorsManager.success),
          SizedBox(width: 8.w),
          Text(
            s.workout_completed,
            style: TextStyles.bodyMedium.copyWith(
              color: ColorsManager.success,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
