import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/progress_models.dart';

class GoalsListCard extends StatefulWidget {
  final MeasurementCardsResponse cards;
  final S s;

  const GoalsListCard({super.key, required this.cards, required this.s});

  @override
  State<GoalsListCard> createState() => _GoalsListCardState();
}

class _GoalsListCardState extends State<GoalsListCard>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    // Create 3 animation controllers
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      ),
    );

    // Create animations
    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    // Start animations with delay
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          _buildGoalItem(
            title: widget.s.weight_goal,
            progress: _calculateWeightProgress(),
            color: ColorsManager.primaryGreen,
            animationIndex: 0,
          ),
          SizedBox(height: 16.h),
          _buildGoalItem(
            title: widget.s.body_fat_goal,
            progress: _calculateBodyFatProgress(),
            color: ColorsManager.info,
            animationIndex: 1,
          ),
          SizedBox(height: 16.h),
          _buildGoalItem(
            title: widget.s.muscle_mass_goal,
            progress: _calculateMuscleProgress(),
            color: ColorsManager.warning,
            animationIndex: 2,
          ),
        ],
      ),
    );
  }

  // ✅ Calculate weight loss progress
  // double _calculateWeightProgress() {
  //   final start = widget.cards.weightCard.firstWeight;
  //   final current = widget.cards.weightCard.lastWeight;
  //   final goal = widget.cards.weightCard.weightGoal;
  //
  //   final totalToLose = start - goal;
  //   final alreadyLost = start - current;
  //
  //   if (totalToLose <= 0) return 100;
  //   return ((alreadyLost / totalToLose) * 100).clamp(0, 100);
  // }
  // ✅ Calculate weight loss progress
  double _calculateWeightProgress() {
    final start = widget.cards.weightCard.firstWeight;
    final current = widget.cards.weightCard.lastWeight;
    final goal = widget.cards.weightCard.weightGoal;

    // Return 0 if no goal is set
    if (goal == null) return 0.0;

    final totalToLose = start - goal;
    final alreadyLost = start - current;

    if (totalToLose <= 0) return 100;
    return ((alreadyLost / totalToLose) * 100).clamp(0, 100);
  }

  // ✅ Calculate body fat reduction progress
  double _calculateBodyFatProgress() {
    final start = widget.cards.bodyFatCard.firstBodyFat;
    final current = widget.cards.bodyFatCard.lastBodyFat;
    final goal = widget.cards.bodyFatCard.bodyFatGoal;

    // Return 0 if no goal is set
    if (goal == null) return 0.0;

    final totalToLose = start - goal;
    final alreadyLost = start - current;

    if (totalToLose <= 0) return 100;
    return ((alreadyLost / totalToLose) * 100).clamp(0, 100);
  }

  // ✅ Calculate muscle gain progress
  double _calculateMuscleProgress() {
    final start = widget.cards.muscleMassCard.firstMuscleMass;
    final current = widget.cards.muscleMassCard.lastMuscleMass;
    final goal = widget.cards.muscleMassCard.muscleMassGoal;

    // Return 0 if no goal is set
    if (goal == null) return 0.0;

    final totalToGain = goal - start;
    final alreadyGained = current - start;

    if (totalToGain <= 0) return 100;
    return ((alreadyGained / totalToGain) * 100).clamp(0, 100);
  }

  // // ✅ Calculate body fat reduction progress
  // double _calculateBodyFatProgress() {
  //   final start = widget.cards.bodyFatCard.firstBodyFat;
  //   final current = widget.cards.bodyFatCard.lastBodyFat;
  //   final goal = widget.cards.bodyFatCard.bodyFatGoal;
  //
  //   final totalToLose = start - goal;
  //   final alreadyLost = start - current;
  //
  //   if (totalToLose <= 0) return 100;
  //   return ((alreadyLost / totalToLose) * 100).clamp(0, 100);
  // }
  //
  // // ✅ Calculate muscle gain progress
  // double _calculateMuscleProgress() {
  //   final start = widget.cards.muscleMassCard.firstMuscleMass;
  //   final current = widget.cards.muscleMassCard.lastMuscleMass;
  //   final goal = widget.cards.muscleMassCard.muscleMassGoal;
  //
  //   final totalToGain = goal - start;
  //   final alreadyGained = current - start;
  //
  //   if (totalToGain <= 0) return 100;
  //   return ((alreadyGained / totalToGain) * 100).clamp(0, 100);
  // }

  Widget _buildGoalItem({
    required String title,
    required double progress,
    required Color color,
    required int animationIndex,
  }) {
    return AnimatedBuilder(
      animation: _animations[animationIndex],
      builder: (context, child) {
        final animatedProgress = progress * _animations[animationIndex].value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyles.font14PrimaryTextMedium),
                Text(
                  '${animatedProgress.toStringAsFixed(0)}%',
                  style: TextStyles.font14Bold.copyWith(color: color),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Stack(
              children: [
                // Background
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(height: 8.h, color: ColorsManager.grey200),
                ),

                // Animated Progress
                FractionallySizedBox(
                  widthFactor: animatedProgress / 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color, color.withValues(alpha: 0.7)],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
