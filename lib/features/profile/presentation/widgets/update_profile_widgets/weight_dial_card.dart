import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';
import 'update_profile_form_controller.dart';

// class WeightDialCard extends StatelessWidget {
//   final UpdateProfileFormController controller;
//   final bool isGoal;
//
//   const WeightDialCard({
//     super.key,
//     required this.controller,
//     required this.isGoal,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final weight =
//         double.tryParse(
//           isGoal
//               ? controller.weightGoalController.text
//               : controller.weightController.text,
//         ) ??
//         70.0;
//
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: isGoal
//               ? [
//                   ColorsManager.success.withValues(alpha: 0.15),
//                   ColorsManager.success.withValues(alpha: 0.05),
//                 ]
//               : [
//                   ColorsManager.info.withValues(alpha: 0.15),
//                   ColorsManager.info.withValues(alpha: 0.05),
//                 ],
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: isGoal
//               ? ColorsManager.success.withValues(alpha: 0.3)
//               : ColorsManager.info.withValues(alpha: 0.3),
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 isGoal ? Icons.flag : Icons.monitor_weight,
//                 size: 24.sp,
//                 color: isGoal ? ColorsManager.success : ColorsManager.info,
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Text(
//                   isGoal ? s.goal_weight : s.current_weight,
//                   style: TextStyles.font12SecondaryTextRegular,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             '${weight.toStringAsFixed(1)} ${s.kg}',
//             style: TextStyles.font20Bold.copyWith(
//               color: isGoal ? ColorsManager.success : ColorsManager.info,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'measurement_dialog_helper.dart';

class WeightDialCard extends StatefulWidget {
  final UpdateProfileFormController controller;
  final bool isGoal;

  const WeightDialCard({
    super.key,
    required this.controller,
    required this.isGoal,
  });

  @override
  State<WeightDialCard> createState() => _WeightDialCardState();
}

class _WeightDialCardState extends State<WeightDialCard> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final weight =
        double.tryParse(
          widget.isGoal
              ? widget.controller.weightGoalController.text
              : widget.controller.weightController.text,
        ) ??
        70.0;

    return GestureDetector(
      onTap: () => MeasurementDialogHelper.showWeightDialog(
        context: context,
        currentValue: weight,
        isGoal: widget.isGoal,
        onSave: (newWeight) {
          setState(() {
            if (widget.isGoal) {
              widget.controller.weightGoalController.text = newWeight
                  .toStringAsFixed(1);
            } else {
              widget.controller.weightController.text = newWeight
                  .toStringAsFixed(1);
            }
          });
        },
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.isGoal
                ? [
                    ColorsManager.success.withOpacity(0.15),
                    ColorsManager.success.withOpacity(0.05),
                  ]
                : [
                    ColorsManager.info.withOpacity(0.15),
                    ColorsManager.info.withOpacity(0.05),
                  ],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: widget.isGoal
                ? ColorsManager.success.withOpacity(0.3)
                : ColorsManager.info.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  widget.isGoal ? Icons.flag : Icons.monitor_weight,
                  size: 24.sp,
                  color: widget.isGoal
                      ? ColorsManager.success
                      : ColorsManager.info,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    widget.isGoal ? s.goal_weight : s.current_weight,
                    style: TextStyles.font12SecondaryTextRegular,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '${weight.toStringAsFixed(1)} kg',
              style: TextStyles.font20Bold.copyWith(
                color: widget.isGoal
                    ? ColorsManager.success
                    : ColorsManager.info,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.touch_app,
                  size: 10.sp,
                  color: ColorsManager.lightText,
                ),
                SizedBox(width: 4.w),
                Text(
                  s.tap_to_edit,
                  style: TextStyles.caption.copyWith(fontSize: 9.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
