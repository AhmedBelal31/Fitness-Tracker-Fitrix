import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:load_switch/load_switch.dart';
import '../../../../../core/theming/app_colors.dart';

class NotificationLoadSwitch extends StatelessWidget {
  final bool value;
  final Future<bool> Function() future;
  final ValueChanged<bool> onChange;

  const NotificationLoadSwitch({
    super.key,
    required this.value,
    required this.future,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return LoadSwitch(
      value: value,
      future: () => future(),
      style: SpinStyle.material,
      width: 55.w,
      height: 30.h,
      curveIn: Curves.easeInOut,
      curveOut: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      // Correct signature: (bool value, bool isActive)
      switchDecoration: (value, isActive) => BoxDecoration(
        color: value
            ? ColorsManager.primaryGreen.withValues(alpha: 0.2)
            : ColorsManager.lightText.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: value
                ? ColorsManager.primaryGreen.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // Correct signature: (bool value) for spinColor
      spinColor: (value) =>
          value ? ColorsManager.primaryGreen : ColorsManager.lightText,
      spinStrokeWidth: 2,
      // Correct signature: (bool value, bool isActive)
      thumbDecoration: (value, isActive) => BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: value
                ? ColorsManager.primaryGreen.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      onChange: onChange,
      onTap: (v) {
        HapticFeedback.mediumImpact();
        log('Notification switch tapped while value is $v');
      },
    );
  }
}
