import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'body_fat_ring_card.dart';
import 'height_meter_card.dart';
import 'muscle_mass_ring_card.dart';
import 'update_profile_form_controller.dart';
import 'weight_dial_card.dart';

class MeasurementsSection extends StatelessWidget {
  final UpdateProfileFormController controller;
  final GlobalKey heightKey;
  final GlobalKey weightKey;
  final GlobalKey bodyFatKey;
  final GlobalKey muscleMassKey;

  const MeasurementsSection({
    super.key,
    required this.controller,
    required this.heightKey,
    required this.weightKey,
    required this.bodyFatKey,
    required this.muscleMassKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeightMeterCard(key: heightKey, controller: controller),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: WeightDialCard(
                key: weightKey,
                controller: controller,
                isGoal: false,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: WeightDialCard(controller: controller, isGoal: true),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: BodyFatRingCard(key: bodyFatKey, controller: controller),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: MuscleMassRingCard(
                key: muscleMassKey,
                controller: controller,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
