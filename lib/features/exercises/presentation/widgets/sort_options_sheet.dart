import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

void showSortOptionsSheet({
  required BuildContext context,
  required String currentSort,
  required ValueChanged<String> onSortChanged,
}) {
  final s = S.of(context);

  showModalBottomSheet(
    context: context,
    backgroundColor: ColorsManager.cardBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(s.sort_by, style: TextStyles.headline3),
          SizedBox(height: 20.h),
          _buildSortOption(
            ctx,
            Icons.sort_by_alpha,
            s.name_a_z,
            'name',
            currentSort == 'name',
            onSortChanged,
          ),
          _buildSortOption(
            ctx,
            Icons.trending_up,
            s.difficulty,
            'difficulty',
            currentSort == 'difficulty',
            onSortChanged,
          ),
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
  return ListTile(
    leading: Icon(
      icon,
      color: isSelected ? ColorsManager.primaryGreen : ColorsManager.lightText,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontFamily: GoogleFonts.openSans().fontFamily,
        color: isSelected
            ? ColorsManager.primaryGreen
            : ColorsManager.primaryText,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    ),
    trailing: isSelected
        ? const Icon(Icons.check, color: ColorsManager.primaryGreen)
        : null,
    onTap: () {
      onSortChanged(value);
      Navigator.pop(ctx);
    },
  );
}
