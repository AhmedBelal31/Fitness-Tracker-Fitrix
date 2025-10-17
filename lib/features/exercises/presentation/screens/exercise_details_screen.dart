import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common_ui/widgets/animations/staggered_animation_mixin.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';
import '../../../workout/presentation/cubit/workouts_cubit.dart';
import '../../../workout/presentation/cubit/workouts_state.dart';
import '../../../workout/presentation/widgets/workout_session_selector.dart';
import '../../data/models/exercise_model.dart';
import '../widgets/exercise_details_widgets/animated_card_wrapper.dart';
import '../widgets/exercise_details_widgets/custom_badge.dart';
import '../widgets/exercise_details_widgets/info_card.dart';
import '../widgets/exercise_details_widgets/quick_info_card.dart';
import '../widgets/exercise_details_widgets/section_title.dart';
import '../widgets/hero_exercise_image.dart';

class ExerciseDetailsScreen extends StatefulWidget {
  final ExerciseModel exercise;

  const ExerciseDetailsScreen({super.key, required this.exercise});

  @override
  State<ExerciseDetailsScreen> createState() => _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends State<ExerciseDetailsScreen>
    with SingleTickerProviderStateMixin, StaggeredAnimationMixin {
  @override
  void initState() {
    super.initState();
    setupStaggeredAnimations();
  }

  @override
  void dispose() {
    disposeAnimations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          _buildHeroAppBar(),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTitleSection(s),
                      SizedBox(height: 24.h),
                      _buildInfoCards(s),
                      SizedBox(height: 24.h),
                      _buildDescriptionSection(s),
                      _buildInstructionsSection(s),
                      _buildActionButtons(s),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== HERO APP BAR ==========
  Widget _buildHeroAppBar() {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      backgroundColor: ColorsManager.primaryGreen,
      leading: _buildBackButton(),
      flexibleSpace: FlexibleSpaceBar(
        background: HeroExerciseImage(
          heroTag: 'exercise_image_${widget.exercise.id}',
          imageUrl: widget.exercise.imageUrl,
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Container(
        width: 36.w,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.4),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
      ),
    );
  }

  // ========== TITLE SECTION ==========
  Widget _buildTitleSection(S s) {
    return AnimatedCardWrapper(
      controller: animationController,
      index: 0,
      child: Row(
        children: [
          Expanded(
            child: Text(widget.exercise.name, style: TextStyles.headline1),
          ),
          if (widget.exercise.isCustomExercise) CustomBadge(text: s.custom),
        ],
      ),
    );
  }

  // ========== INFO CARDS ==========
  Widget _buildInfoCards(S s) {
    return AnimatedCardWrapper(
      controller: animationController,
      index: 1,
      child: Row(
        children: [
          if (widget.exercise.difficultyLevel != null)
            Expanded(
              child: QuickInfoCard(
                icon: Icons.trending_up,
                title: s.difficulty,
                value: widget.exercise.difficultyLevel!,
                color: _getDifficultyColor(widget.exercise.difficultyLevel!),
                index: 0,
              ),
            ),
          if (widget.exercise.equipment != null) ...[
            SizedBox(width: 12.w),
            Expanded(
              child: QuickInfoCard(
                icon: Icons.fitness_center,
                title: s.equipment,
                value: widget.exercise.equipment!,
                color: ColorsManager.info,
                index: 1,
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ========== DESCRIPTION SECTION ==========
  Widget _buildDescriptionSection(S s) {
    if (widget.exercise.description == null) return const SizedBox.shrink();

    return AnimatedCardWrapper(
      controller: animationController,
      index: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: s.description),
          SizedBox(height: 12.h),
          InfoCard(content: widget.exercise.description!),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ========== INSTRUCTIONS SECTION ==========
  Widget _buildInstructionsSection(S s) {
    if (widget.exercise.instructions == null) return const SizedBox.shrink();

    return AnimatedCardWrapper(
      controller: animationController,
      index: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: s.instructions),
          SizedBox(height: 12.h),
          InfoCard(content: widget.exercise.instructions!),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  // ========== ACTION BUTTONS ==========
  Widget _buildActionButtons(S s) {
    return AnimatedCardWrapper(
      controller: animationController,
      index: 4,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: SizedBox(
          width: double.infinity,
          child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
            listener: (context, state) {
              if (state is ExerciseAddedToWorkout) {
                Navigator.pop(context); // Close bottom sheet
                _showSuccessSnackBar(s.exercise_added_successfully);
              }

              if (state is WorkoutsError) {
                _showErrorSnackBar(_formatErrorMessage(state.message, s));
              }
            },
            builder: (context, state) {
              final isLoading = state is WorkoutsLoading;

              return ElevatedButton.icon(
                onPressed: isLoading ? null : () => _showWorkoutSessions(s),
                icon: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.add_circle_outline),
                label: Text(isLoading ? s.adding : s.add_to_workout),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  disabledBackgroundColor: ColorsManager.primaryGreen
                      .withValues(alpha: 0.6),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ========== SHOW WORKOUT SESSIONS ==========
  void _showWorkoutSessions(S s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => WorkoutSessionSelector(
        exercise: widget.exercise,
        onSessionSelected: (sessionId) {
          _addExerciseToSession(sessionId);
        },
      ),
    );
  }

  void _addExerciseToSession(String sessionId) {
    context.read<WorkoutsCubit>().addExerciseToWorkout(
      sessionId: sessionId,
      exerciseId: widget.exercise.isCustomExercise ? null : widget.exercise.id,
      customExerciseId: widget.exercise.isCustomExercise
          ? widget.exercise.id
          : null,
    );
  }

  // ========== SUCCESS & ERROR SNACKBARS ==========
  void _showSuccessSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: ColorsManager.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
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
              child: Text(
                message,
                style: TextStyles.bodyMedium.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: S.of(context).dismiss,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // ========== HELPERS ==========
  String _formatErrorMessage(String error, S s) {
    if (error.contains('completed session')) {
      return s.cannot_add_to_completed_session;
    }
    if (error.contains('network')) {
      return s.network_error;
    }
    if (error.contains('Failed to add exercise')) {
      return s.failed_to_add_exercise;
    }
    return s.something_went_wrong;
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
