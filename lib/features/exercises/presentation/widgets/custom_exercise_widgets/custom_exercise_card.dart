import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
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
          onDelete();
          return false;
        }
        return false;
      },
      background: _buildDismissBackground(context),
      child: _buildCard(context),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context, S s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          s.delete_exercise_confirmation,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        content: Text(
          s.delete_exercise_message,
          style: TextStyle(
            fontSize: 14,
            color: ColorsManager.getSecondaryText(context),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              s.cancel,
              style: TextStyle(
                fontSize: 14,
                color: ColorsManager.getSecondaryText(context),
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
            child: Text(
              s.delete,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
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
          Icon(Icons.delete_outline, color: Colors.white, size: 32.sp),
          SizedBox(height: 4.h),
          Text(
            'Delete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
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
          child: Row(
            children: [
              _buildExerciseIcon(context, isDark),
              SizedBox(width: 16.w),
              Expanded(child: _buildExerciseInfo(context)),
              _buildChevronIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseIcon(BuildContext context, bool isDark) {
    return Container(
      width: 56.w,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                colors: [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                ],
              )
            : ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.fitness_center,
        color: isDark ? ColorsManager.darkScaffold : Colors.white,
        size: 28.sp,
      ),
    );
  }

  Widget _buildExerciseInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorsManager.getPrimaryText(context),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (exercise.sectionName.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            exercise.sectionName,
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.getSecondaryText(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildChevronIcon(BuildContext context) {
    return Icon(
      Icons.chevron_right,
      color: ColorsManager.getSecondaryText(context),
      size: 24.sp,
    );
  }
}
