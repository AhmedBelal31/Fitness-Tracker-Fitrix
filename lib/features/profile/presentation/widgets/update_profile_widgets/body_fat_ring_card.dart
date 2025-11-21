import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';
import 'measurement_dialog_helper.dart';
import 'update_profile_form_controller.dart';

// class BodyFatRingCard extends StatefulWidget {
//   final UpdateProfileFormController controller;
//
//   const BodyFatRingCard({super.key, required this.controller});
//
//   @override
//   State<BodyFatRingCard> createState() => _BodyFatRingCardState();
// }
//
// class _BodyFatRingCardState extends State<BodyFatRingCard> {
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final currentBodyFat =
//         double.tryParse(widget.controller.bodyFatController.text) ?? 20.0;
//     final goalBodyFat =
//         double.tryParse(widget.controller.bodyFatGoalController.text) ?? 15.0;
//
//     return GestureDetector(
//       onTap: () => MeasurementDialogHelper.showBodyFatDialog(
//         context: context,
//         currentValue: currentBodyFat,
//         goalValue: goalBodyFat,
//         onSave: (current, goal) {
//           setState(() {
//             widget.controller.bodyFatController.text = current.toStringAsFixed(
//               1,
//             );
//             widget.controller.bodyFatGoalController.text = goal.toStringAsFixed(
//               1,
//             );
//           });
//         },
//       ),
//       child: Container(
//         height: 150.h,
//         padding: EdgeInsets.all(10.w),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               ColorsManager.warning.withValues(alpha: 0.15),
//               ColorsManager.warning.withValues(alpha: 0.05),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(20.r),
//           border: Border.all(
//             color: ColorsManager.warning.withValues(alpha: 0.3),
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: ColorsManager.warning.withValues(alpha: 0.1),
//               blurRadius: 15,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Circular Progress Ring
//             SizedBox(
//               width: 60.w,
//               height: 60.h,
//               child: Stack(
//                 children: [
//                   SizedBox(
//                     width: 60.w,
//                     height: 60.h,
//                     child: CircularProgressIndicator(
//                       value: currentBodyFat / 50,
//                       strokeWidth: 5,
//                       backgroundColor: ColorsManager.warning.withValues(
//                         alpha: 0.2,
//                       ),
//                       valueColor: const AlwaysStoppedAnimation(
//                         ColorsManager.warning,
//                       ),
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           currentBodyFat.toStringAsFixed(1),
//                           style: TextStyles.font16Bold.copyWith(
//                             color: ColorsManager.warning,
//                           ),
//                         ),
//                         Text(
//                           '%',
//                           style: TextStyles.caption.copyWith(
//                             fontSize: 8.sp,
//                             color: ColorsManager.warning,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 6.h),
//
//             // Goal Display
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
//               decoration: BoxDecoration(
//                 color: ColorsManager.success.withValues(alpha: 0.15),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.flag, size: 10.sp, color: ColorsManager.success),
//                   SizedBox(width: 3.w),
//                   Flexible(
//                     child: Text(
//                       '${goalBodyFat.toStringAsFixed(1)}%',
//                       style: TextStyles.caption.copyWith(
//                         fontSize: 9.sp,
//                         fontWeight: FontWeight.w600,
//                         color: ColorsManager.success,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 4.h),
//
//             // Tap to Edit
//             Icon(Icons.touch_app, size: 10.sp, color: ColorsManager.lightText),
//           ],
//         ),
//       ),
//     );
//   }
// }
class BodyFatRingCard extends StatefulWidget {
  final UpdateProfileFormController controller;

  const BodyFatRingCard({super.key, required this.controller});

  @override
  State<BodyFatRingCard> createState() => _BodyFatRingCardState();
}

class _BodyFatRingCardState extends State<BodyFatRingCard> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentBodyFat =
        double.tryParse(widget.controller.bodyFatController.text) ?? 20.0;
    final goalBodyFat =
        double.tryParse(widget.controller.bodyFatGoalController.text) ?? 15.0;

    return GestureDetector(
      onTap: () => MeasurementDialogHelper.showBodyFatDialog(
        context: context,
        currentValue: currentBodyFat,
        goalValue: goalBodyFat,
        onSave: (current, goal) {
          setState(() {
            widget.controller.bodyFatController.text = current.toStringAsFixed(
              1,
            );
            widget.controller.bodyFatGoalController.text = goal.toStringAsFixed(
              1,
            );
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
              ColorsManager.warning.withValues(alpha: isDark ? 0.2 : 0.15),
              ColorsManager.warning.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: ColorsManager.warning.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : ColorsManager.warning.withValues(alpha: 0.1),
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
                      value: currentBodyFat / 50,
                      strokeWidth: 5,
                      backgroundColor: ColorsManager.warning.withValues(
                        alpha: 0.2,
                      ),
                      valueColor: const AlwaysStoppedAnimation(
                        ColorsManager.warning,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentBodyFat.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.warning,
                          ),
                        ),
                        Text(
                          '%',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: ColorsManager.warning,
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
                color: ColorsManager.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.flag, size: 10.sp, color: ColorsManager.success),
                  SizedBox(width: 3.w),
                  Flexible(
                    child: Text(
                      '${goalBodyFat.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w600,
                        color: ColorsManager.success,
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
