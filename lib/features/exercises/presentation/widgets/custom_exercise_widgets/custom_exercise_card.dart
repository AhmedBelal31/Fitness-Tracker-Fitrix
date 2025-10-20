import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/exercise_model.dart';

class CustomExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const CustomExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Dismissible(
      key: Key(exercise.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        final confirmed = await _confirmDelete(context, s);
        if (confirmed == true) {
          // Call delete but return false to prevent automatic dismissal
          // Let the state management handle the UI update
          onDelete();
          return false; // Important: prevents automatic dismissal
        }
        return false;
      },
      background: _buildDismissBackground(),
      child: _buildCard(),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, S s) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorsManager.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          s.delete_exercise_confirmation,
          style: TextStyles.headline3,
        ),
        content: Text(s.delete_exercise_message, style: TextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              s.cancel,
              style: TextStyles.bodyMedium.copyWith(
                color: ColorsManager.secondaryText,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(s.delete, style: TextStyles.buttonMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.w),
      decoration: BoxDecoration(
        color: ColorsManager.error,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.delete_outline,
            color: ColorsManager.whiteText,
            size: 32.sp,
          ),
          SizedBox(height: 4.h),
          Text(
            'Delete',
            style: TextStyles.bodySmall.copyWith(
              color: ColorsManager.whiteText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: ColorsManager.cardShadow,
          ),
          child: Row(
            children: [
              _buildExerciseIcon(),
              SizedBox(width: 16.w),
              Expanded(child: _buildExerciseInfo()),
              _buildChevronIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseIcon() {
    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.fitness_center,
        color: ColorsManager.whiteText,
        size: 28.sp,
      ),
    );
  }

  Widget _buildExerciseInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.name,
          style: TextStyles.exerciseName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        // SizedBox(height: 4.h),
        // if (exercise.targetMuscle != null)
        //   Text(
        //     exercise.targetMuscle!,
        //     style: TextStyles.bodySmall.copyWith(
        //       color: ColorsManager.primaryGreen,
        //     ),
        //     maxLines: 1,
        //     overflow: TextOverflow.ellipsis,
        //   ),
        if (exercise.sectionName.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            exercise.sectionName,
            style: TextStyles.caption,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildChevronIcon() {
    return Icon(
      Icons.chevron_right,
      color: ColorsManager.lightText,
      size: 24.sp,
    );
  }
}
