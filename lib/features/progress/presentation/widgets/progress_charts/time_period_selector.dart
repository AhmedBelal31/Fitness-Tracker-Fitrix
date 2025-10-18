import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/measurement_chart_models.dart';

class TimePeriodSelector extends StatelessWidget {
  final TimePeriod selectedPeriod;
  final Function(TimePeriod) onPeriodChanged;

  const TimePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Row(
        children: TimePeriod.values.map((period) {
          final isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => onPeriodChanged(period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
                decoration: BoxDecoration(
                  gradient: isSelected ? ColorsManager.primaryGradient : null,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  period.getLabel(s),
                  style: TextStyles.caption.copyWith(
                    fontSize: 11.sp,
                    color: isSelected
                        ? ColorsManager.whiteText
                        : ColorsManager.secondaryText,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
