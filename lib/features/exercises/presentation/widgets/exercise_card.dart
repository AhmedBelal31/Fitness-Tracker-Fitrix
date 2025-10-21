import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/exercise_model.dart';

// class ExerciseCard extends StatelessWidget {
//   final ExerciseModel exercise;
//   final VoidCallback onTap;
//   final Widget? trailing;
//
//   const ExerciseCard({
//     super.key,
//     required this.exercise,
//     required this.onTap,
//     this.trailing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16.r),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardTheme.color,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: [
//             BoxShadow(
//               color: isDark
//                   ? Colors.black.withValues(alpha: 0.3)
//                   : Colors.black.withValues(alpha: 0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//           border: Border.all(
//             color: exercise.isCustomExercise
//                 ? ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.3)
//                 : ColorsManager.info.withValues(alpha: isDark ? 0.3 : 0.2),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             _buildExerciseImage(context, isDark),
//             SizedBox(width: 12.w),
//             _buildExerciseInfo(context, isDark),
//             SizedBox(width: 8.w),
//             _buildTrailing(context, isDark),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildExerciseImage(BuildContext context, bool isDark) {
//     return Container(
//       width: 60.w,
//       height: 60.w,
//       decoration: BoxDecoration(
//         color: exercise.isCustomExercise
//             ? ColorsManager.getPrimaryGreen(
//                 context,
//               ).withValues(alpha: isDark ? 0.2 : 0.1)
//             : ColorsManager.info.withValues(alpha: isDark ? 0.2 : 0.1),
//         borderRadius: BorderRadius.circular(12.r),
//       ),
//       child: exercise.imageUrl != null && exercise.imageUrl!.isNotEmpty
//           ? ClipRRect(
//               borderRadius: BorderRadius.circular(12.r),
//               child: CachedNetworkImage(
//                 imageUrl: exercise.imageUrl!,
//                 fit: BoxFit.cover,
//                 placeholder: (context, url) => Center(
//                   child: CircularProgressIndicator(
//                     color: ColorsManager.getPrimaryGreen(context),
//                     strokeWidth: 2,
//                   ),
//                 ),
//                 errorWidget: (context, url, error) => Icon(
//                   Icons.fitness_center,
//                   color: exercise.isCustomExercise
//                       ? ColorsManager.getPrimaryGreen(context)
//                       : ColorsManager.info,
//                   size: 30.sp,
//                 ),
//               ),
//             )
//           : Icon(
//               Icons.fitness_center,
//               color: exercise.isCustomExercise
//                   ? ColorsManager.getPrimaryGreen(context)
//                   : ColorsManager.info,
//               size: 30.sp,
//             ),
//     );
//   }
//
//   Widget _buildExerciseInfo(BuildContext context, bool isDark) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   exercise.name,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: ColorsManager.getPrimaryText(context),
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//               if (exercise.isCustomExercise) _buildCustomBadge(context, isDark),
//             ],
//           ),
//           SizedBox(height: 4.h),
//           if (exercise.difficultyLevel != null)
//             _buildDifficultyRow(context, isDark),
//           if (exercise.equipment != null && exercise.equipment!.isNotEmpty) ...[
//             SizedBox(height: 4.h),
//             _buildEquipmentRow(context, isDark),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCustomBadge(BuildContext context, bool isDark) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
//       decoration: BoxDecoration(
//         color: ColorsManager.getPrimaryGreen(
//           context,
//         ).withValues(alpha: isDark ? 0.2 : 0.1),
//         borderRadius: BorderRadius.circular(4.r),
//       ),
//       child: Text(
//         'Custom',
//         style: TextStyle(
//           color: ColorsManager.getPrimaryGreen(context),
//           fontWeight: FontWeight.bold,
//           fontSize: 10.sp,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDifficultyRow(BuildContext context, bool isDark) {
//     return Row(
//       children: [
//         Icon(
//           Icons.trending_up,
//           size: 14.sp,
//           color: _getDifficultyColor(exercise.difficultyLevel!, context),
//         ),
//         SizedBox(width: 4.w),
//         Text(
//           exercise.difficultyLevel!,
//           style: TextStyle(
//             fontSize: 12,
//             color: _getDifficultyColor(exercise.difficultyLevel!, context),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildEquipmentRow(BuildContext context, bool isDark) {
//     return Row(
//       children: [
//         Icon(
//           Icons.fitness_center,
//           size: 14.sp,
//           color: ColorsManager.getSecondaryText(context),
//         ),
//         SizedBox(width: 4.w),
//         Expanded(
//           child: Text(
//             exercise.equipment!,
//             style: TextStyle(
//               fontSize: 12,
//               color: ColorsManager.getSecondaryText(context),
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTrailing(BuildContext context, bool isDark) {
//     return trailing ??
//         Icon(
//           Icons.chevron_right,
//           color: ColorsManager.getSecondaryText(context),
//           size: 24.sp,
//         );
//   }
//
//   Color _getDifficultyColor(String difficulty, context) {
//     switch (difficulty.toLowerCase()) {
//       case 'beginner':
//         return ColorsManager.success;
//       case 'intermediate':
//         return ColorsManager.warning;
//       case 'advanced':
//         return ColorsManager.error;
//       default:
//         return ColorsManager.getSecondaryText(context);
//     }
//   }
// }
class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final Widget? trailing;

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: exercise.isCustomExercise
                ? ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.3)
                : ColorsManager.info.withValues(alpha: isDark ? 0.3 : 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            _buildExerciseImage(context, isDark),
            SizedBox(width: 12.w),
            _buildExerciseInfo(context, isDark),
            SizedBox(width: 8.w),
            _buildTrailing(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseImage(BuildContext context, bool isDark) {
    return Hero(
      tag: 'exercise_image_${exercise.id}',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: exercise.isCustomExercise
                ? ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.2 : 0.1)
                : ColorsManager.info.withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: exercise.imageUrl != null && exercise.imageUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: CachedNetworkImage(
                    imageUrl: exercise.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.getPrimaryGreen(context),
                        strokeWidth: 2,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.fitness_center,
                      color: exercise.isCustomExercise
                          ? ColorsManager.getPrimaryGreen(context)
                          : ColorsManager.info,
                      size: 30.sp,
                    ),
                  ),
                )
              : Icon(
                  Icons.fitness_center,
                  color: exercise.isCustomExercise
                      ? ColorsManager.getPrimaryGreen(context)
                      : ColorsManager.info,
                  size: 30.sp,
                ),
        ),
      ),
    );
  }

  Widget _buildExerciseInfo(BuildContext context, bool isDark) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (exercise.isCustomExercise) _buildCustomBadge(context, isDark),
            ],
          ),
          SizedBox(height: 4.h),
          if (exercise.difficultyLevel != null)
            _buildDifficultyRow(context, isDark),
          if (exercise.equipment != null && exercise.equipment!.isNotEmpty) ...[
            SizedBox(height: 4.h),
            _buildEquipmentRow(context, isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildCustomBadge(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: ColorsManager.getPrimaryGreen(
          context,
        ).withValues(alpha: isDark ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        S.of(context).custom,
        style: TextStyle(
          color: ColorsManager.getPrimaryGreen(context),
          fontWeight: FontWeight.bold,
          fontSize: 10.sp,
        ),
      ),
    );
  }

  Widget _buildDifficultyRow(BuildContext context, bool isDark) {
    return Row(
      children: [
        Icon(
          Icons.trending_up,
          size: 14.sp,
          color: _getDifficultyColor(exercise.difficultyLevel!, context),
        ),
        SizedBox(width: 4.w),
        Text(
          exercise.difficultyLevel!,
          style: TextStyle(
            fontSize: 12,
            color: _getDifficultyColor(exercise.difficultyLevel!, context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentRow(BuildContext context, bool isDark) {
    return Row(
      children: [
        Icon(
          Icons.fitness_center,
          size: 14.sp,
          color: ColorsManager.getSecondaryText(context),
        ),
        SizedBox(width: 4.w),
        Expanded(
          child: Text(
            exercise.equipment!,
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.getSecondaryText(context),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildTrailing(BuildContext context, bool isDark) {
    return trailing ??
        Icon(
          Icons.chevron_right,
          color: ColorsManager.getSecondaryText(context),
          size: 24.sp,
        );
  }

  Color _getDifficultyColor(String difficulty, context) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return ColorsManager.success;
      case 'intermediate':
        return ColorsManager.warning;
      case 'advanced':
        return ColorsManager.error;
      default:
        return ColorsManager.getSecondaryText(context);
    }
  }
}
