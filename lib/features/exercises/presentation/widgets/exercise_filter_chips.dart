import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class DifficultyFilterChips extends StatelessWidget {
  final String? selectedDifficulty;
  final Function(String?) onDifficultyChanged;

  const DifficultyFilterChips({
    super.key,
    required this.selectedDifficulty,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final difficulties = [
      {'label': 'All', 'value': null},
      {'label': 'Beginner', 'value': 'Beginner'},
      {'label': 'Intermediate', 'value': 'Intermediate'},
      {'label': 'Advanced', 'value': 'Advanced'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: difficulties.map((difficulty) {
            final isSelected = selectedDifficulty == difficulty['value'];
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: FilterChip(
                label: Text(
                  difficulty['label'] as String,
                  style: TextStyles.bodyMedium.copyWith(
                    color: isSelected
                        ? Colors.white
                        : ColorsManager.primaryText,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  onDifficultyChanged(
                    selected ? difficulty['value'] as String? : null,
                  );
                },
                backgroundColor: ColorsManager.cardBackground,
                selectedColor: ColorsManager.primaryGreen,
                checkmarkColor: Colors.white,
                side: BorderSide(
                  color: isSelected
                      ? ColorsManager.primaryGreen
                      : ColorsManager.lightText,
                  width: 1,
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
