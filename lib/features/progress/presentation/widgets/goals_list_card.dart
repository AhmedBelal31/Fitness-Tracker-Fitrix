import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/progress_models.dart';
import 'dart:developer' as developer;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // ✅ Add debug print
    print('🎯 GoalsListCard build() called');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
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
      child: Column(
        children: [
          _buildGoalItem(
            title: widget.s.weight_goal,
            progress: _calculateWeightProgress(),
            color: isDark
                ? const Color(0xFF66BB6A)
                : ColorsManager.primaryGreen,
            animationIndex: 0,
          ),
          SizedBox(height: 16.h),
          _buildGoalItem(
            title: widget.s.body_fat_goal,
            progress: _calculateBodyFatProgress(),
            color: isDark ? const Color(0xFF42A5F5) : ColorsManager.info,
            animationIndex: 1,
          ),
          SizedBox(height: 16.h),
          _buildGoalItem(
            title: widget.s.muscle_mass_goal,
            progress: _calculateMuscleProgress(),
            color: isDark ? const Color(0xFFFFB74D) : ColorsManager.warning,
            animationIndex: 2,
          ),
        ],
      ),
    );
  }

  // ✅ SIMPLEST: Show current as % of goal
  double _calculateWeightProgress() {
    final current = widget.cards.weightCard.lastWeight;
    final goal = widget.cards.weightCard.weightGoal;

    if (goal == null || goal == 0) return 0.0;

    print(
      'Weight: $current / $goal = ${(current / goal * 100).toStringAsFixed(1)}%',
    );
    return (current / goal) * 100; // Don't clamp
  }

  double _calculateBodyFatProgress() {
    final current = widget.cards.bodyFatCard.lastBodyFat;
    final goal = widget.cards.bodyFatCard.bodyFatGoal;

    if (goal == null || goal == 0) return 0.0;

    print(
      'Body Fat: $current / $goal = ${(current / goal * 100).toStringAsFixed(1)}%',
    );
    return (current / goal) * 100; // Don't clamp
  }

  double _calculateMuscleProgress() {
    final current = widget.cards.muscleMassCard.lastMuscleMass;
    final goal = widget.cards.muscleMassCard.muscleMassGoal;

    if (goal == null || goal == 0) return 0.0;

    print(
      'Muscle: $current / $goal = ${(current / goal * 100).toStringAsFixed(1)}%',
    );
    return (current / goal) * 100; // Don't clamp
  }

  Widget _buildGoalItem({
    required String title,
    required double progress,
    required Color color,
    required int animationIndex,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isNegative = progress < 0;

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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
                Text(
                  '${animatedProgress >= 0 ? "" : ""}${animatedProgress.toStringAsFixed(0)}%', // ✅ Show sign
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isNegative
                        ? Colors.red
                        : color, // ✅ Red for negative
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    height: 8.h,
                    color: isDark
                        ? ColorsManager.darkInputBackground
                        : ColorsManager.grey200,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: (animatedProgress.abs() / 100).clamp(
                    0.0,
                    1.0,
                  ), // ✅ Use abs() for width
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isNegative
                              ? [
                                  Colors.red,
                                  Colors.red.withValues(alpha: 0.7),
                                ] // ✅ Red for negative
                              : [color, color.withValues(alpha: 0.7)],
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
