import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? ColorsManager.darkBorder : ColorsManager.lightBorder,
        ),
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
        children: TimePeriod.values.map((period) {
          final isSelected = selectedPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => onPeriodChanged(period),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? (isDark
                            ? LinearGradient(
                                colors: [
                                  ColorsManager.darkPrimaryGreen,
                                  ColorsManager.darkSecondaryGreen,
                                ],
                              )
                            : ColorsManager.primaryGradient)
                      : null,
                  color: isSelected
                      ? null
                      : (isDark
                            ? ColorsManager.darkInputBackground
                            : Colors.transparent),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  period.getLabel(s),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isSelected
                        ? (isDark ? ColorsManager.darkScaffold : Colors.white)
                        : (isDark ? Colors.white : ColorsManager.secondaryText),
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
