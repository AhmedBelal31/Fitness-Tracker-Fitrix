import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/exercise_model.dart';

// class ExerciseCard extends StatelessWidget {
//   final ExerciseModel exercise;
//   final VoidCallback onTap;
//
//   const ExerciseCard({required this.exercise, required this.onTap, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16.r),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: ColorsManager.cardBackground,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: ColorsManager.cardShadow,
//           border: exercise.isCustomExercise
//               ? Border.all(color: ColorsManager.primaryGreen, width: 2)
//               : null,
//         ),
//         child: Row(
//           children: [
//             // ✅ Hero Animation for Image
//             Hero(
//               tag: 'exercise_image_${exercise.id}', // Unique hero tag
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12.r),
//                 child:
//                     exercise.imageUrl != null && exercise.imageUrl!.isNotEmpty
//                     ? CachedNetworkImage(
//                         imageUrl: exercise.imageUrl!,
//                         width: 60.w,
//                         height: 60.w,
//                         fit: BoxFit.cover,
//                         placeholder: (context, url) => Container(
//                           width: 60.w,
//                           height: 60.w,
//                           decoration: BoxDecoration(
//                             gradient: ColorsManager.cardGradient,
//                           ),
//                           child: const Center(
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         errorWidget: (context, url, error) => Container(
//                           width: 60.w,
//                           height: 60.w,
//                           decoration: BoxDecoration(
//                             gradient: ColorsManager.cardGradient,
//                           ),
//                           child: Icon(
//                             Icons.fitness_center,
//                             color: Colors.white,
//                             size: 30.sp,
//                           ),
//                         ),
//                       )
//                     : Container(
//                         width: 60.w,
//                         height: 60.w,
//                         decoration: BoxDecoration(
//                           gradient: ColorsManager.cardGradient,
//                         ),
//                         child: Icon(
//                           Icons.fitness_center,
//                           color: Colors.white,
//                           size: 30.sp,
//                         ),
//                       ),
//               ),
//             ),
//             SizedBox(width: 16.w),
//
//             // Exercise Info
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           exercise.name,
//                           style: TextStyles.font16PrimaryTextRegular,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       if (exercise.isCustomExercise)
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8.w,
//                             vertical: 4.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: ColorsManager.primaryGreen.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(12.r),
//                           ),
//                           child: Text(
//                             s.custom,
//                             style: TextStyles.caption.copyWith(
//                               color: ColorsManager.primaryGreen,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   SizedBox(height: 4.h),
//                   if (exercise.equipment != null)
//                     Text(exercise.equipment!, style: TextStyles.bodySmall),
//                   SizedBox(height: 8.h),
//                   Row(
//                     children: [
//                       if (exercise.difficultyLevel != null)
//                         _buildDifficultyBadge(exercise.difficultyLevel!),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Arrow Icon
//             Icon(
//               Icons.chevron_right,
//               color: ColorsManager.lightText,
//               size: 24.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDifficultyBadge(String difficulty) {
//     final color = _getDifficultyColor(difficulty);
//
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: color, width: 1),
//       ),
//       child: Text(difficulty, style: TextStyles.caption.copyWith(color: color)),
//     );
//   }
//
//   Color _getDifficultyColor(String difficulty) {
//     switch (difficulty.toLowerCase()) {
//       case 'beginner':
//       case 'easy':
//         return ColorsManager.beginnerLevel;
//       case 'intermediate':
//       case 'medium':
//         return ColorsManager.intermediateLevel;
//       case 'advanced':
//       case 'hard':
//         return ColorsManager.advancedLevel;
//       default:
//         return ColorsManager.info;
//     }
//   }
// }
// presentation/widgets/exercise_card.dart

class ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;
  final VoidCallback onTap;
  final Widget? trailing; // ✅ Add trailing parameter

  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.onTap,
    this.trailing, // ✅ Optional trailing widget
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
          border: Border.all(
            color: exercise.isCustomExercise
                ? ColorsManager.primaryGreen.withOpacity(0.3)
                : ColorsManager.info.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            // Exercise Image or Icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: exercise.isCustomExercise
                    ? ColorsManager.primaryGreen.withOpacity(0.1)
                    : ColorsManager.info.withOpacity(0.1),
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
                            color: ColorsManager.primaryGreen,
                            strokeWidth: 2,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.fitness_center,
                          color: exercise.isCustomExercise
                              ? ColorsManager.primaryGreen
                              : ColorsManager.info,
                          size: 30.sp,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.fitness_center,
                      color: exercise.isCustomExercise
                          ? ColorsManager.primaryGreen
                          : ColorsManager.info,
                      size: 30.sp,
                    ),
            ),
            SizedBox(width: 12.w),

            // Exercise Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          exercise.name,
                          style: TextStyles.font16PrimaryTextSemiBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (exercise.isCustomExercise)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Custom',
                            style: TextStyles.caption.copyWith(
                              color: ColorsManager.primaryGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Difficulty Level
                  if (exercise.difficultyLevel != null)
                    Row(
                      children: [
                        Icon(
                          Icons.trending_up,
                          size: 14.sp,
                          color: _getDifficultyColor(exercise.difficultyLevel!),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          exercise.difficultyLevel!,
                          style: TextStyles.bodySmall.copyWith(
                            color: _getDifficultyColor(
                              exercise.difficultyLevel!,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  // Equipment
                  if (exercise.equipment != null &&
                      exercise.equipment!.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          size: 14.sp,
                          color: ColorsManager.lightText,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            exercise.equipment!,
                            style: TextStyles.caption.copyWith(
                              color: ColorsManager.lightText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // ✅ Trailing widget (if provided) or default arrow
            SizedBox(width: 8.w),
            trailing ??
                Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                  size: 24.sp,
                ),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return ColorsManager.success;
      case 'intermediate':
        return ColorsManager.warning;
      case 'advanced':
        return ColorsManager.error;
      default:
        return ColorsManager.lightText;
    }
  }
}
