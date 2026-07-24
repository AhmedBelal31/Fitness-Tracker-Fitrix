import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import 'update_profile_form_controller.dart';
import 'measurement_dialog_helper.dart';

class HeightMeterCard extends StatefulWidget {
  final UpdateProfileFormController controller;

  const HeightMeterCard({super.key, required this.controller});

  @override
  State<HeightMeterCard> createState() => _HeightMeterCardState();
}

class _HeightMeterCardState extends State<HeightMeterCard> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final height =
        double.tryParse(widget.controller.heightController.text) ?? 170.0;

    return GestureDetector(
      onTap: () => MeasurementDialogHelper.showHeightDialog(
        context: context,
        currentValue: height,
        onSave: (newHeight) {
          setState(() {
            widget.controller.heightController.text = newHeight.toStringAsFixed(
              0,
            );
          });
        },
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: isDark ? 0.2 : 0.15),
              ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.3),
            width: 1.5,
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
          children: [
            Icon(
              Icons.height,
              size: 40.sp,
              color: ColorsManager.getPrimaryGreen(context),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.height,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                  Text(
                    '${height.toStringAsFixed(0)} cm',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.touch_app,
              color: ColorsManager.getSecondaryText(context),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
