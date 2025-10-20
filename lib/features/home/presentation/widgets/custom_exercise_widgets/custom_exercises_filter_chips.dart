import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

// class CustomExercisesFilterChips extends StatelessWidget {
//   final String? selectedDifficulty;
//   final Function(String?) onFilterChanged;
//   final VoidCallback onClearFilters;
//   final bool hasActiveFilters;
//
//   const CustomExercisesFilterChips({
//     super.key,
//     required this.selectedDifficulty,
//     required this.onFilterChanged,
//     required this.onClearFilters,
//     required this.hasActiveFilters,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return TweenAnimationBuilder(
//       duration: const Duration(milliseconds: 800),
//       tween: Tween<double>(begin: 0, end: 1),
//       curve: Curves.easeOutCubic,
//       builder: (context, double value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(30 * (1 - value), 0),
//             child: child,
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//         child: Row(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     _buildFilterChip(
//                       label: s.all,
//                       isSelected: selectedDifficulty == null,
//                       onTap: () => onFilterChanged(null),
//                     ),
//                     SizedBox(width: 8.w),
//                     _buildFilterChip(
//                       label: s.beginner,
//                       isSelected: selectedDifficulty == 'Beginner',
//                       onTap: () => onFilterChanged('Beginner'),
//                     ),
//                     SizedBox(width: 8.w),
//                     _buildFilterChip(
//                       label: s.intermediate,
//                       isSelected: selectedDifficulty == 'Intermediate',
//                       onTap: () => onFilterChanged('Intermediate'),
//                     ),
//                     SizedBox(width: 8.w),
//                     _buildFilterChip(
//                       label: s.advanced,
//                       isSelected: selectedDifficulty == 'Advanced',
//                       onTap: () => onFilterChanged('Advanced'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (hasActiveFilters) ...[
//               SizedBox(width: 8.w),
//               _buildClearButton(s),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFilterChip({
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return TweenAnimationBuilder(
//       duration: const Duration(milliseconds: 200),
//       tween: Tween<double>(begin: 0.95, end: 1.0),
//       builder: (context, double value, child) {
//         return Transform.scale(scale: value, child: child);
//       },
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20.r),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//           decoration: BoxDecoration(
//             gradient: isSelected ? ColorsManager.primaryGradient : null,
//             color: isSelected ? null : ColorsManager.cardBackground,
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(
//               color: isSelected
//                   ? Colors.transparent
//                   : ColorsManager.lightText.withValues(alpha: 0.2),
//               width: 1,
//             ),
//             boxShadow: isSelected
//                 ? [
//                     BoxShadow(
//                       color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     ),
//                   ]
//                 : null,
//           ),
//           child: Text(
//             label,
//             style: TextStyles.bodySmall.copyWith(
//               color: isSelected
//                   ? ColorsManager.whiteText
//                   : ColorsManager.primaryText,
//               fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildClearButton(S s) {
//     return InkWell(
//       onTap: onClearFilters,
//       borderRadius: BorderRadius.circular(20.r),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
//         decoration: BoxDecoration(
//           color: ColorsManager.error.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.clear, size: 16.sp, color: ColorsManager.error),
//             SizedBox(width: 4.w),
//             Text(
//               s.clear,
//               style: TextStyles.bodySmall.copyWith(
//                 color: ColorsManager.error,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomExercisesFilterChips extends StatelessWidget {
  final String? selectedDifficulty;
  final Function(String?) onFilterChanged;

  const CustomExercisesFilterChips({
    super.key,
    required this.selectedDifficulty,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
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
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip(
                label: s.all,
                isSelected: selectedDifficulty == null,
                onTap: () => onFilterChanged(null),
              ),
              SizedBox(width: 8.w),
              _buildFilterChip(
                label: s.beginner,
                isSelected: selectedDifficulty == 'Beginner',
                onTap: () => onFilterChanged('Beginner'),
              ),
              SizedBox(width: 8.w),
              _buildFilterChip(
                label: s.intermediate,
                isSelected: selectedDifficulty == 'Intermediate',
                onTap: () => onFilterChanged('Intermediate'),
              ),
              SizedBox(width: 8.w),
              _buildFilterChip(
                label: s.advanced,
                isSelected: selectedDifficulty == 'Advanced',
                onTap: () => onFilterChanged('Advanced'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 200),
      tween: Tween<double>(begin: 0.95, end: 1.0),
      builder: (context, double value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            gradient: isSelected ? ColorsManager.primaryGradient : null,
            color: isSelected ? null : ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : ColorsManager.lightText.withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyles.bodySmall.copyWith(
              color: isSelected
                  ? ColorsManager.whiteText
                  : ColorsManager.primaryText,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
