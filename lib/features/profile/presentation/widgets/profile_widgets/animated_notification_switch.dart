import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:load_switch/load_switch.dart';
import '../../../../../core/theming/app_colors.dart';

class AnimatedLoadSwitch extends StatelessWidget {
  final bool value;
  final Future<bool> Function() future;
  final ValueChanged<bool> onChange;

  const AnimatedLoadSwitch({
    super.key,
    required this.value,
    required this.future,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LoadSwitch(
      value: value,
      future: () => future(),
      style: SpinStyle.material,
      width: 55.w,
      height: 30.h,
      curveIn: Curves.easeInOut,
      curveOut: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      switchDecoration: (value, isActive) => BoxDecoration(
        color: value
            ? ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.2)
            : (isDark ? ColorsManager.darkBorder : ColorsManager.lightBorder)
                  .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: value
                ? ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      spinColor: (value) => value
          ? ColorsManager.getPrimaryGreen(context)
          : ColorsManager.getSecondaryText(context),
      spinStrokeWidth: 2,
      thumbDecoration: (value, isActive) => BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: value
                ? ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.3)
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
        log('Switch tapped while value is $v');
      },
    );
  }
}
