import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';
import 'measurement_dialog_helper.dart';
import 'update_profile_form_controller.dart';

class MuscleMassRingCard extends StatefulWidget {
  final UpdateProfileFormController controller;

  const MuscleMassRingCard({super.key, required this.controller});

  @override
  State<MuscleMassRingCard> createState() => _MuscleMassRingCardState();
}

class _MuscleMassRingCardState extends State<MuscleMassRingCard> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentMuscle =
        double.tryParse(widget.controller.muscleMassController.text) ?? 45.0;
    final goalMuscle =
        double.tryParse(widget.controller.muscleMassGoalController.text) ??
        50.0;

    return GestureDetector(
      onTap: () => MeasurementDialogHelper.showMuscleMassDialog(
        context: context,
        currentValue: currentMuscle,
        goalValue: goalMuscle,
        onSave: (current, goal) {
          setState(() {
            widget.controller.muscleMassController.text = current
                .toStringAsFixed(1);
            widget.controller.muscleMassGoalController.text = goal
                .toStringAsFixed(1);
          });
        },
      ),
      child: Container(
        height: 150.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsManager.success.withValues(alpha: isDark ? 0.2 : 0.15),
              ColorsManager.success.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: ColorsManager.success.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : ColorsManager.success.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60.w,
              height: 60.h,
              child: Stack(
                children: [
                  SizedBox(
                    width: 60.w,
                    height: 60.h,
                    child: CircularProgressIndicator(
                      value: currentMuscle / 100,
                      strokeWidth: 5,
                      backgroundColor: ColorsManager.success.withValues(
                        alpha: 0.2,
                      ),
                      valueColor: const AlwaysStoppedAnimation(
                        ColorsManager.success,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentMuscle.toStringAsFixed(0),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.success,
                          ),
                        ),
                        Text(
                          'kg',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: ColorsManager.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 6.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.flag,
                    size: 10.sp,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                  SizedBox(width: 3.w),
                  Flexible(
                    child: Text(
                      '${goalMuscle.toStringAsFixed(0)}kg',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.getPrimaryGreen(context),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Icon(
              Icons.touch_app,
              size: 10.sp,
              color: ColorsManager.getSecondaryText(context),
            ),
          ],
        ),
      ),
    );
  }
}
