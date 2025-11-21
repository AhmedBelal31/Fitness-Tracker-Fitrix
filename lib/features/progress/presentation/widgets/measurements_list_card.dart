import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';

class MeasurementsListCard extends StatelessWidget {
  final S s;

  const MeasurementsListCard({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    final measurements = _getMeasurements();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: measurements.map((m) => _buildMeasurementItem(m)).toList(),
      ),
    );
  }

  Widget _buildMeasurementItem(Map<String, String> measurement) {
    final change = double.parse(measurement['change']!);
    final isPositive = change > 0;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(measurement['label']!, style: TextStyles.bodyMedium),
          Row(
            children: [
              Text(
                '${measurement['value']} ${s.cm}',
                style: TextStyles.font16PrimaryTextRegular,
              ),
              SizedBox(width: 8.w),
              _buildChangeBadge(change, isPositive),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChangeBadge(double change, bool isPositive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isPositive
            ? ColorsManager.success.withValues(alpha: 0.1)
            : ColorsManager.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        '${isPositive ? '+' : ''}${change.toStringAsFixed(0)} ${s.cm}',
        style: TextStyles.caption.copyWith(
          color: isPositive ? ColorsManager.success : ColorsManager.error,
        ),
      ),
    );
  }

  List<Map<String, String>> _getMeasurements() {
    return [
      {'label': s.chest, 'value': '102', 'change': '+2'},
      {'label': s.waist, 'value': '85', 'change': '-3'},
      {'label': s.arms, 'value': '38', 'change': '+1'},
      {'label': s.thighs, 'value': '58', 'change': '+2'},
    ];
  }
}
