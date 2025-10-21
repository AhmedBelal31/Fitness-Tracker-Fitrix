import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';

class MeasurementDialogHelper {
  /// Show Body Fat Goal Dialog with Sliders
  static Future<void> showBodyFatDialog({
    required BuildContext context,
    required double currentValue,
    required double goalValue,
    required Function(double current, double goal) onSave,
  }) async {
    double tempCurrent = currentValue.clamp(5.0, 50.0);
    double tempGoal = goalValue.clamp(5.0, 50.0);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final s = S.of(context);

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Container(
                constraints: BoxConstraints(maxHeight: 0.85.sh),
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorsManager.warning.withValues(alpha: 0.1),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.warning.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.donut_small,
                          size: 48.sp,
                          color: ColorsManager.warning,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        s.set_body_fat_goals,
                        style: TextStyles.font20PrimaryTextBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        s.adjust_sliders_to_set_goals,
                        style: TextStyles.font14SecondaryTextRegular,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      _buildSliderSection(
                        label: s.current_body_fat,
                        value: tempCurrent,
                        min: 5.0,
                        max: 50.0,
                        color: ColorsManager.warning,
                        onChanged: (value) {
                          setState(() => tempCurrent = value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      _buildSliderSection(
                        label: s.goal_body_fat,
                        value: tempGoal,
                        min: 5.0,
                        max: 50.0,
                        color: ColorsManager.success,
                        onChanged: (value) {
                          setState(() => tempGoal = value);
                        },
                      ),
                      SizedBox(height: 32.h),
                      _buildProgressPreview(
                        current: tempCurrent,
                        goal: tempGoal,
                        s: s,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                side: BorderSide(
                                  color: ColorsManager.lightBorder,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                s.cancel,
                                style: TextStyles.font14PrimaryTextMedium,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                onSave(tempCurrent, tempGoal);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                backgroundColor: ColorsManager.primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                s.save,
                                style: TextStyles.font14WhiteMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Show Weight Dialog with Slider
  static Future<void> showWeightDialog({
    required BuildContext context,
    required double currentValue,
    required bool isGoal,
    required Function(double) onSave,
  }) async {
    double tempWeight = currentValue.clamp(30.0, 200.0);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final s = S.of(context);

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Container(
                height: 0.7.sh,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isGoal
                        ? [ColorsManager.success.withOpacity(0.1), Colors.white]
                        : [ColorsManager.info.withOpacity(0.1), Colors.white],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top Section
                    Column(
                      children: [
                        // Icon Header
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color:
                                (isGoal
                                        ? ColorsManager.success
                                        : ColorsManager.info)
                                    .withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isGoal ? Icons.flag : Icons.monitor_weight,
                            size: 48.sp,
                            color: isGoal
                                ? ColorsManager.success
                                : ColorsManager.info,
                          ),
                        ),
                        SizedBox(height: 20.h),

                        // Title
                        Text(
                          isGoal ? s.set_goal_weight : s.set_current_weight,
                          style: TextStyles.font20PrimaryTextBold,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          s.adjust_slider_to_set_weight,
                          style: TextStyles.font14SecondaryTextRegular,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),

                    // Middle Section - Weight Display
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            (isGoal
                                    ? ColorsManager.success
                                    : ColorsManager.info)
                                .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            tempWeight.toStringAsFixed(1),
                            style: TextStyles.font36Bold.copyWith(
                              color: isGoal
                                  ? ColorsManager.success
                                  : ColorsManager.info,
                              fontSize: 48.sp,
                            ),
                          ),
                          Text('kg', style: TextStyles.font16WhiteRegular),
                        ],
                      ),
                    ),

                    // Weight Slider
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '30 kg',
                              style: TextStyles.font12SecondaryTextRegular,
                            ),
                            Text(
                              '200 kg',
                              style: TextStyles.font12SecondaryTextRegular,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: isGoal
                                ? ColorsManager.success
                                : ColorsManager.info,
                            inactiveTrackColor:
                                (isGoal
                                        ? ColorsManager.success
                                        : ColorsManager.info)
                                    .withOpacity(0.2),
                            thumbColor: isGoal
                                ? ColorsManager.success
                                : ColorsManager.info,
                            overlayColor:
                                (isGoal
                                        ? ColorsManager.success
                                        : ColorsManager.info)
                                    .withOpacity(0.2),
                            trackHeight: 8.h,
                            thumbShape: RoundSliderThumbShape(
                              enabledThumbRadius: 12.r,
                            ),
                          ),
                          child: Slider(
                            value: tempWeight,
                            min: 30.0,
                            max: 200.0,
                            divisions: 1700,
                            onChanged: (value) {
                              setState(() => tempWeight = value);
                            },
                          ),
                        ),
                      ],
                    ),

                    // Info Box
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: ColorsManager.info.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: ColorsManager.info.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: ColorsManager.info,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              isGoal
                                  ? s.weight_goal_info
                                  : s.weight_measurement_info,
                              style: TextStyles.font12SecondaryTextRegular,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              side: BorderSide(
                                color: ColorsManager.lightBorder,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              s.cancel,
                              style: TextStyles.font14PrimaryTextMedium,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              onSave(tempWeight);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              backgroundColor: ColorsManager.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              s.save,
                              style: TextStyles.font14WhiteMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Show Height Dialog with Slider
  static Future<void> showHeightDialog({
    required BuildContext context,
    required double currentValue,
    required Function(double) onSave,
  }) async {
    double tempHeight = currentValue.clamp(100.0, 250.0);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final s = S.of(context);
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Container(
                height: 0.7.sh,
                // constraints: BoxConstraints(maxHeight: 0.6.sh),
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorsManager.primaryGreen.withValues(alpha: 0.1),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icon Header
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryGreen.withValues(
                            alpha: 0.15,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.height,
                          size: 48.sp,
                          color: ColorsManager.primaryGreen,
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Title
                      Text(
                        s.set_your_height,
                        style: TextStyles.font20PrimaryTextBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        s.adjust_slider_to_set_height,
                        style: TextStyles.font14SecondaryTextRegular,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),

                      // Height Display
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryGreen.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              tempHeight.toStringAsFixed(0),
                              style: TextStyles.font32Bold.copyWith(
                                color: ColorsManager.primaryGreen,
                              ),
                            ),
                            Text(
                              'cm',
                              style: TextStyles.font14SecondaryTextRegular,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Height Slider
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '100 cm',
                                style: TextStyles.font12SecondaryTextRegular,
                              ),
                              Text(
                                '250 cm',
                                style: TextStyles.font12SecondaryTextRegular,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          SliderTheme(
                            data: SliderThemeData(
                              activeTrackColor: ColorsManager.primaryGreen,
                              inactiveTrackColor: ColorsManager.primaryGreen
                                  .withValues(alpha: 0.2),
                              thumbColor: ColorsManager.primaryGreen,
                              overlayColor: ColorsManager.primaryGreen
                                  .withValues(alpha: 0.2),
                              trackHeight: 8.h,
                              thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 12.r,
                              ),
                            ),
                            child: Slider(
                              value: tempHeight,
                              min: 100.0,
                              max: 250.0,
                              divisions: 150,
                              onChanged: (value) {
                                setState(() => tempHeight = value);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),

                      // Info Box
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.info.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ColorsManager.info.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: ColorsManager.info,
                              size: 20.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                s.height_measurement_info,
                                style: TextStyles.font12SecondaryTextRegular,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                side: BorderSide(
                                  color: ColorsManager.lightBorder,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                s.cancel,
                                style: TextStyles.font14PrimaryTextMedium,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                onSave(tempHeight);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                backgroundColor: ColorsManager.primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                s.save,
                                style: TextStyles.font14WhiteMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Show Muscle Mass Goal Dialog with Sliders
  static Future<void> showMuscleMassDialog({
    required BuildContext context,
    required double currentValue,
    required double goalValue,
    required Function(double current, double goal) onSave,
  }) async {
    double tempCurrent = currentValue.clamp(10.0, 100.0);
    double tempGoal = goalValue.clamp(10.0, 100.0);

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final s = S.of(context);

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Container(
                constraints: BoxConstraints(maxHeight: 0.85.sh),
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorsManager.success.withValues(alpha: 0.1),
                      Colors.white,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: ColorsManager.success.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.fitness_center,
                          size: 48.sp,
                          color: ColorsManager.success,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        s.set_muscle_mass_goals,
                        style: TextStyles.font20PrimaryTextBold,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        s.adjust_sliders_to_set_goals,
                        style: TextStyles.font14SecondaryTextRegular,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 32.h),
                      _buildSliderSection(
                        label: s.current_muscle_mass,
                        value: tempCurrent,
                        min: 10.0, // ✅ Changed from 20.0
                        max: 100.0,
                        color: ColorsManager.info,
                        onChanged: (value) {
                          setState(() => tempCurrent = value);
                        },
                      ),
                      SizedBox(height: 24.h),
                      _buildSliderSection(
                        label: s.goal_muscle_mass,
                        value: tempGoal,
                        min: 10.0, // ✅ Changed from 20.0
                        max: 100.0,
                        color: ColorsManager.success,
                        onChanged: (value) {
                          setState(() => tempGoal = value);
                        },
                      ),
                      SizedBox(height: 32.h),
                      _buildProgressPreview(
                        current: tempCurrent,
                        goal: tempGoal,
                        s: s,
                        isMuscleMass: true,
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                side: BorderSide(
                                  color: ColorsManager.lightBorder,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                s.cancel,
                                style: TextStyles.font14PrimaryTextMedium,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                onSave(tempCurrent, tempGoal);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                backgroundColor: ColorsManager.primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                s.save,
                                style: TextStyles.font14WhiteMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  static Widget _buildSliderSection({
    required String label,
    required double value,
    required double min,
    required double max,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(label, style: TextStyles.font14PrimaryTextMedium),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${value.toStringAsFixed(1)}${label.contains('Fat') ? '%' : 'kg'}',
                style: TextStyles.font14Bold.copyWith(color: color),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: color,
            inactiveTrackColor: color.withValues(alpha: 0.2),
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
            trackHeight: 6.h,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) * 10).toInt(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  static Widget _buildProgressPreview({
    required double current,
    required double goal,
    required S s,
    bool isMuscleMass = false,
  }) {
    final difference = (goal - current).abs();
    final isGaining = goal > current;
    final unit = isMuscleMass ? 'kg' : '%';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.info.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.info.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            isGaining ? Icons.trending_up : Icons.trending_down,
            color: isGaining ? ColorsManager.success : ColorsManager.warning,
            size: 32.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isGaining
                      ? (isMuscleMass ? s.gain_muscle : s.reduce_fat)
                      : (isMuscleMass ? s.lose_muscle : s.increase_fat),
                  style: TextStyles.font14Bold,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${difference.toStringAsFixed(1)} $unit ${isGaining ? s.to_gain : s.to_lose}',
                  style: TextStyles.font12SecondaryTextRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
