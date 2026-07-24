// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../../../../core/theming/app_colors.dart';
// import '../../../../../core/theming/styles.dart';
// import '../../../../../generated/l10n.dart';
//
// void showSortOptionsSheet({
//   required BuildContext context,
//   required String currentSort,
//   required ValueChanged<String> onSortChanged,
// }) {
//   final s = S.of(context);
//
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: ColorsManager.cardBackground,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//     ),
//     builder: (ctx) => Padding(
//       padding: EdgeInsets.all(20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(s.sort_by, style: TextStyles.headline3),
//           SizedBox(height: 20.h),
//           _buildSortOption(
//             ctx,
//             Icons.sort_by_alpha,
//             s.name_a_z,
//             'name',
//             currentSort == 'name',
//             onSortChanged,
//           ),
//           _buildSortOption(
//             ctx,
//             Icons.trending_up,
//             s.difficulty,
//             'difficulty',
//             currentSort == 'difficulty',
//             onSortChanged,
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget _buildSortOption(
//   BuildContext ctx,
//   IconData icon,
//   String title,
//   String value,
//   bool isSelected,
//   ValueChanged<String> onSortChanged,
// ) {
//   return ListTile(
//     leading: Icon(
//       icon,
//       color: isSelected ? ColorsManager.primaryGreen : ColorsManager.lightText,
//     ),
//     title: Text(
//       title,
//       style: TextStyle(
//         fontFamily: GoogleFonts.openSans().fontFamily,
//         color: isSelected
//             ? ColorsManager.primaryGreen
//             : ColorsManager.primaryText,
//         fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//       ),
//     ),
//     trailing: isSelected
//         ? const Icon(Icons.check, color: ColorsManager.primaryGreen)
//         : null,
//     onTap: () {
//       onSortChanged(value);
//       Navigator.pop(ctx);
//     },
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

void showSortOptionsSheet({
  required BuildContext context,
  required String currentSort,
  required ValueChanged<String> onSortChanged,
}) {
  final s = S.of(context);
  final isDark = Theme.of(context).brightness == Brightness.dark;

  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).cardTheme.color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: isDark
                  ? ColorsManager.darkBorder
                  : ColorsManager.lightBorder,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Title
          Text(
            s.sort_by,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 20.h),

          // Sort options
          _buildSortOption(
            ctx,
            Icons.sort_by_alpha,
            s.name_a_z,
            'name',
            currentSort == 'name',
            onSortChanged,
          ),
          SizedBox(height: 8.h),
          _buildSortOption(
            ctx,
            Icons.trending_up,
            s.difficulty,
            'difficulty',
            currentSort == 'difficulty',
            onSortChanged,
          ),
          SizedBox(height: 8.h),
        ],
      ),
    ),
  );
}

Widget _buildSortOption(
  BuildContext ctx,
  IconData icon,
  String title,
  String value,
  bool isSelected,
  ValueChanged<String> onSortChanged,
) {
  final isDark = Theme.of(ctx).brightness == Brightness.dark;

  return Container(
    decoration: BoxDecoration(
      color: isSelected
          ? ColorsManager.getPrimaryGreen(
              ctx,
            ).withValues(alpha: isDark ? 0.2 : 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: isSelected
            ? ColorsManager.getPrimaryGreen(ctx)
            : (isDark ? ColorsManager.darkBorder : ColorsManager.lightBorder),
        width: isSelected ? 2 : 1,
      ),
    ),
    child: ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      leading: Icon(
        icon,
        color: isSelected
            ? ColorsManager.getPrimaryGreen(ctx)
            : ColorsManager.getSecondaryText(ctx),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: GoogleFonts.openSans().fontFamily,
          fontSize: 16,
          color: isSelected
              ? ColorsManager.getPrimaryGreen(ctx)
              : ColorsManager.getPrimaryText(ctx),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: ColorsManager.getPrimaryGreen(ctx))
          : Icon(
              Icons.circle_outlined,
              color: ColorsManager.getSecondaryText(ctx).withValues(alpha: 0.3),
            ),
      onTap: () {
        onSortChanged(value);
        Navigator.pop(ctx);
      },
    ),
  );
}
