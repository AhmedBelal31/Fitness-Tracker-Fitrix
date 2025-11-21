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

class _WorkoutDetailsScreenState extends State<WorkoutDetailsScreen>
    with TickerProviderStateMixin {
  late final WorkoutTimerManager _timerManager;
  late AnimationController _fabController;
  late AnimationController _headerController;
  late Animation<double> _fabScaleAnimation;
  WorkoutSessionEntity? _cachedWorkout;

  @override
  void initState() {
    super.initState();
    _timerManager = WorkoutTimerManager(workoutId: widget.workoutId);
    _timerManager.initialize();
    _setupAnimations();
    _loadWorkoutDetails();
  }

  void _setupAnimations() {
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // ✅ Add header animation controller
    _headerController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _fabScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fabController, curve: Curves.elasticOut),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _fabController.forward();
    });
  }

  @override
  void dispose() {
    _timerManager.dispose();
    _fabController.dispose();
    _headerController.dispose();
    super.dispose();
  }

  void _loadWorkoutDetails() {
    context.read<WorkoutsCubit>().loadSessionById(widget.workoutId);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: BlocBuilder<WorkoutsCubit, WorkoutsState>(
        buildWhen: (previous, current) =>
            current is WorkoutSessionLoaded ||
            current is WorkoutSessionCompleted ||
            current is WorkoutsUpdating,
        builder: (context, state) {
          WorkoutSessionEntity? workout;

          if (state is WorkoutSessionLoaded) {
            workout = state.session;
          } else if (state is WorkoutsUpdating) {
            workout = state.currentSession;
          } else {
            workout = _cachedWorkout;
          }

          if (workout != null && !workout.isCompleted) {
            return ScaleTransition(
              scale: _fabScaleAnimation,
              child: _buildAddExerciseFAB(s),
            );
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
              return Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.getPrimaryGreen(context),
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

  Widget _buildAddExerciseFAB(S s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton.extended(
      onPressed: () => _showAddExerciseOptions(s),
      backgroundColor: ColorsManager.getPrimaryGreen(context),
      icon: Icon(
        Icons.add,
        color: isDark ? ColorsManager.darkScaffold : Colors.white,
      ),
      label: Text(
        s.add_exercise,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isDark ? ColorsManager.darkScaffold : Colors.white,
        ),
      ),
    );
  }

  void _showAddExerciseOptions(S s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardTheme.color,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.get<SectionsCubit>()..loadSections()),
          BlocProvider.value(value: context.read<WorkoutsCubit>()),
        ],
        child: AddExerciseBottomSheet(
          workoutId: widget.workoutId,
          onExerciseAdded: () => _loadWorkoutDetails(),
        ),
      ),
    );
  }

  Widget _buildContent(WorkoutSessionEntity workout, S s, bool isUpdating) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            // ✅ Use the new header with animation
            SliverPersistentHeader(
              pinned: true,
              delegate: WorkoutHeaderSection(
                workout: workout,
                animation: _headerController,
              ),
            ),
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
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return CustomPaint(
                  size: Size(double.infinity, 3.h),
                  painter: AnimatedProgressPainter(
                    progress: value,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildEmptyState(S s) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 600),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(
              scale: value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    s.workout_not_found,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
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
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
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

// ✨ Custom Paint for Animated Progress Indicator
class AnimatedProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  AnimatedProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          color.withValues(alpha: 0.3),
          color,
          color.withValues(alpha: 0.3),
        ],
        stops: [0.0, progress, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width * progress, size.height / 2),
      paint..strokeWidth = size.height,
    );
  }

  @override
  bool shouldRepaint(AnimatedProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
