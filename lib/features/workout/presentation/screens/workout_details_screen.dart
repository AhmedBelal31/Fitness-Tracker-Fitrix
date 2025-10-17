import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../domain/entities/workout_session_entity.dart';
import '../cubit/workouts_cubit.dart';
import '../cubit/workouts_state.dart';
import '../widgets/add_exercise_bottom_sheet.dart';
import '../widgets/workout_actions_section.dart';
import '../widgets/workout_exercises_list.dart';
import '../widgets/workout_header_section.dart';
import '../widgets/workout_notes_section.dart';
import '../widgets/workout_stats_section.dart';
import '../widgets/workout_timer_manager.dart';

class WorkoutDetailsScreen extends StatefulWidget {
  final String workoutId;

  const WorkoutDetailsScreen({super.key, required this.workoutId});

  @override
  State<WorkoutDetailsScreen> createState() => _WorkoutDetailsScreenState();
}

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen> {
  late final WorkoutTimerManager _timerManager;
  WorkoutSessionEntity? _cachedWorkout;

  @override
  void initState() {
    super.initState();
    _timerManager = WorkoutTimerManager(workoutId: widget.workoutId);
    _timerManager.initialize();
    _loadWorkoutDetails();
  }

  void _loadWorkoutDetails() {
    context.read<WorkoutsCubit>().loadSessionById(widget.workoutId);
  }

  @override
  void dispose() {
    _timerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      // ✅ Use BlocBuilder to make FAB reactive to state changes
      floatingActionButton: BlocBuilder<WorkoutsCubit, WorkoutsState>(
        buildWhen: (previous, current) =>
            current is WorkoutSessionLoaded ||
            current is WorkoutSessionCompleted ||
            current is WorkoutsUpdating,
        builder: (context, state) {
          // Get workout from state or cache
          WorkoutSessionEntity? workout;

          if (state is WorkoutSessionLoaded) {
            workout = state.session;
          } else if (state is WorkoutsUpdating) {
            workout = state.currentSession;
          } else {
            workout = _cachedWorkout;
          }

          // Show FAB only if workout exists and is not completed
          if (workout != null && !workout.isCompleted) {
            return _buildAddExerciseFAB(s);
          }

          return const SizedBox.shrink();
        },
      ),
      body: BlocListener<WorkoutsCubit, WorkoutsState>(
        listenWhen: (previous, current) =>
            current is WorkoutSessionStarted ||
            current is WorkoutSessionCompleted ||
            current is WorkoutsError,
        listener: (context, state) {
          if (state is WorkoutsError) {
            _showErrorSnackBar(state.message);
          } else if (state is WorkoutSessionStarted) {
            _showSuccessSnackBar(s.workout_started);
            _cachedWorkout = state.session;
          } else if (state is WorkoutSessionCompleted) {
            _showSuccessSnackBar(s.workout_completed_success);
            _loadWorkoutDetails();
          }
        },
        child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
          buildWhen: (previous, current) {
            if (current is WorkoutSessionStarted ||
                current is WorkoutSessionCompleted ||
                current is SetAddedToExercise ||
                current is SetUpdated ||
                current is ExerciseAddedToWorkout) {
              return false;
            }

            if (current is WorkoutsLoading) {
              return previous is! WorkoutSessionLoaded &&
                  previous is! WorkoutsUpdating;
            }

            return true;
          },
          builder: (context, state) {
            if (state is WorkoutSessionLoaded) {
              _cachedWorkout = state.session;
            }

            if (state is WorkoutsLoading && _cachedWorkout == null) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryGreen,
                ),
              );
            }

            if (state is WorkoutSessionLoaded ||
                state is WorkoutsUpdating ||
                _cachedWorkout != null) {
              final workout = state is WorkoutSessionLoaded
                  ? state.session
                  : state is WorkoutsUpdating
                  ? state.currentSession
                  : _cachedWorkout!;

              return _buildContent(workout, s, state is WorkoutsUpdating);
            }

            return _buildEmptyState(s);
          },
        ),
      ),
    );
  }

  // ✅ Add Exercise FAB
  Widget _buildAddExerciseFAB(S s) {
    return FloatingActionButton.extended(
      onPressed: () => _showAddExerciseOptions(s),
      backgroundColor: ColorsManager.primaryGreen,
      icon: const Icon(Icons.add, color: Colors.white),
      label: Text(s.add_exercise, style: TextStyles.buttonMedium),
    );
  }

  void _showAddExerciseOptions(S s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) => MultiBlocProvider(
        providers: [
          // ✅ Provide SectionsCubit
          BlocProvider(create: (_) => di.get<SectionsCubit>()..loadSections()),
          // ✅ Provide existing WorkoutsCubit from parent
          BlocProvider.value(value: context.read<WorkoutsCubit>()),
        ],
        child: AddExerciseBottomSheet(
          workoutId: widget.workoutId,
          onExerciseAdded: () {
            // ✅ Reload workout details when coming back
            _loadWorkoutDetails();
          },
        ),
      ),
    );
  }

  Widget _buildContent(WorkoutSessionEntity workout, S s, bool isUpdating) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            WorkoutHeaderSection(workout: workout),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkoutStatsSection(workout: workout),
                    SizedBox(height: 24.h),
                    WorkoutActionsSection(
                      workout: workout,
                      workoutId: widget.workoutId,
                      timerManager: _timerManager,
                    ),
                    SizedBox(height: 24.h),
                    if (workout.notes != null && workout.notes!.isNotEmpty) ...[
                      WorkoutNotesSection(notes: workout.notes!),
                      SizedBox(height: 24.h),
                    ],
                    WorkoutExercisesList(
                      workout: workout,
                      workoutId: widget.workoutId,
                    ),
                    SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (isUpdating)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 3.h,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorsManager.primaryGreen,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(S s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.sp,
            color: ColorsManager.lightText,
          ),
          SizedBox(height: 16.h),
          Text(s.workout_not_found, style: TextStyles.headline3),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: ColorsManager.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
