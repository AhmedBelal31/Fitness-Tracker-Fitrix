import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../exercises/data/models/exercise_model.dart';
import '../../../../exercises/presentation/widgets/custom_exercise_widgets/custom_exercise_card.dart';

class CustomExercisesList extends StatelessWidget {
  final List<ExerciseModel> exercises;
  final Function(ExerciseModel) onExerciseTap;
  final Function(String) onExerciseDelete;
  final VoidCallback onRefresh;
  final AnimationController animationController;

  const CustomExercisesList({
    super.key,
    required this.exercises,
    required this.onExerciseTap,
    required this.onExerciseDelete,
    required this.onRefresh,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => onRefresh(),
      color: ColorsManager.getPrimaryGreen(context),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final delay = index * 60;

          return TweenAnimationBuilder(
            key: ValueKey(exercises[index].id),
            duration: Duration(milliseconds: 500 + delay),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.easeOutCubic,
            builder: (context, double value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(30 * (1 - value), 0),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: CustomExerciseCard(
                exercise: exercises[index],
                onTap: () => onExerciseTap(exercises[index]),
                onDelete: () => onExerciseDelete(exercises[index].id),
              ),
            ),
          );
        },
      ),
    );
  }
}
