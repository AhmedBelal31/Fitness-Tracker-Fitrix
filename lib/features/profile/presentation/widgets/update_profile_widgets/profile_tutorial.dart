import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';

class ProfileTutorial {
  static TutorialCoachMark createTutorial({
    required BuildContext context,
    required GlobalKey heightKey,
    required GlobalKey weightKey,
    required GlobalKey bodyFatKey,
    required GlobalKey muscleMassKey,
    required VoidCallback onFinish,
  }) {
    final s = S.of(context);

    return TutorialCoachMark(
      targets: _createTargets(
        context: context,
        s: s,
        heightKey: heightKey,
        weightKey: weightKey,
        bodyFatKey: bodyFatKey,
        muscleMassKey: muscleMassKey,
      ),
      colorShadow: Colors.black,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: onFinish,
      onSkip: () {
        onFinish();
        return true;
      },
    );
  }

  static List<TargetFocus> _createTargets({
    required BuildContext context,
    required S s,
    required GlobalKey heightKey,
    required GlobalKey weightKey,
    required GlobalKey bodyFatKey,
    required GlobalKey muscleMassKey,
  }) {
    return [
      // Height Tutorial
      TargetFocus(
        identify: "height",
        keyTarget: heightKey,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        radius: 16.r,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                icon: Icons.height,
                title: s.height_measurement,
                description: s.tap_to_set_height,
                color: ColorsManager.primaryGreen,
                currentStep: 1,
                totalSteps: 4,
              );
            },
          ),
        ],
      ),

      // Weight Tutorial
      TargetFocus(
        identify: "weight",
        keyTarget: weightKey,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        radius: 16.r,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return _buildTutorialContent(
                icon: Icons.monitor_weight,
                title: s.weight_tracking,
                description: s.tap_to_set_current_and_goal_weight,
                color: ColorsManager.info,
                currentStep: 2,
                totalSteps: 4,
              );
            },
          ),
        ],
      ),

      // Body Fat Tutorial
      TargetFocus(
        identify: "bodyFat",
        keyTarget: bodyFatKey,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        radius: 16.r,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                icon: Icons.donut_small,
                title: s.body_fat_goal,
                description: s.tap_to_set_body_fat_goal_slider,
                color: ColorsManager.warning,
                currentStep: 3,
                totalSteps: 4,
              );
            },
          ),
        ],
      ),

      // Muscle Mass Tutorial
      TargetFocus(
        identify: "muscleMass",
        keyTarget: muscleMassKey,
        alignSkip: Alignment.topRight,
        shape: ShapeLightFocus.RRect,
        radius: 16.r,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return _buildTutorialContent(
                icon: Icons.fitness_center,
                title: s.muscle_mass_goal,
                description: s.tap_to_set_muscle_mass_goal_slider,
                color: ColorsManager.success,
                currentStep: 4,
                totalSteps: 4,
              );
            },
          ),
        ],
      ),
    ];
  }

  static Widget _buildTutorialContent({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required int currentStep,
    required int totalSteps,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Step indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              '$currentStep of $totalSteps',
              style: TextStyles.font12Bold.copyWith(color: color),
            ),
          ),
          SizedBox(height: 16.h),

          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 40.sp, color: color),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: TextStyles.font18PrimaryTextBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            style: TextStyles.font14SecondaryTextRegular,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
