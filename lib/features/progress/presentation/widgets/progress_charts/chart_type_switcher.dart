import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../data/models/measurement_chart_models.dart';

class ChartTypeSwitcher extends StatelessWidget {
  final ChartType selectedType;
  final Function(ChartType) onTypeChanged;

  const ChartTypeSwitcher({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTypeButton(ChartType.line, Icons.show_chart),
        SizedBox(width: 8.w),
        _buildTypeButton(ChartType.bar, Icons.bar_chart),
        SizedBox(width: 8.w),
        _buildTypeButton(ChartType.area, Icons.area_chart),
      ],
    );
  }

  Widget _buildTypeButton(ChartType type, IconData icon) {
    final isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => onTypeChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          gradient: isSelected ? ColorsManager.primaryGradient : null,
          color: isSelected ? null : ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Icon(
          icon,
          size: 20.sp,
          color: isSelected
              ? ColorsManager.whiteText
              : ColorsManager.secondaryText,
        ),
      ),
    );
  }
}
