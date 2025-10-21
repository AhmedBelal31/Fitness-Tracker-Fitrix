import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
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
              ColorsManager.primaryGreen.withValues(alpha: 0.15),
              ColorsManager.primaryGreen.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.height, size: 40.sp, color: ColorsManager.primaryGreen),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s.height, style: TextStyles.font14SecondaryTextRegular),
                  Text(
                    '${height.toStringAsFixed(0)} cm',
                    style: TextStyles.font20PrimaryGreenMedium,
                  ),
                ],
              ),
            ),
            Icon(Icons.touch_app, color: ColorsManager.lightText, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
