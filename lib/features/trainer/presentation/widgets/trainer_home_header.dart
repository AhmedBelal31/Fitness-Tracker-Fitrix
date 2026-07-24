// lib/features/trainer/presentation/widgets/trainer_home_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';

class TrainerHomeHeader extends StatelessWidget {
  const TrainerHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final hour = DateTime.now().hour;
    String greeting;

    if (hour < 12) {
      greeting = s.good_morning;
    } else if (hour < 17) {
      greeting = s.good_afternoon;
    } else {
      greeting = s.good_evening;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: TextStyle(
            fontSize: 16.sp,
            color: ColorsManager.getSecondaryText(context),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          s.trainer_dashboard_title,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
      ],
    );
  }
}
