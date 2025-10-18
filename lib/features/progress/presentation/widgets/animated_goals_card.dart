import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/app_colors.dart';
import 'package:fitrix/core/theming/styles.dart';
import '../../data/models/goal_model.dart';

class AnimatedGoalsCard extends StatefulWidget {
  final List<GoalData> goals;

  const AnimatedGoalsCard({super.key, required this.goals});

  @override
  State<AnimatedGoalsCard> createState() => _AnimatedGoalsCardState();
}

class _AnimatedGoalsCardState extends State<AnimatedGoalsCard>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _progressAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.goals.length,
      (index) => AnimationController(
        duration: Duration(milliseconds: 1500 + (index * 200)),
        vsync: this,
      ),
    );

    _progressAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();

    // Start animations
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
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
        children: List.generate(widget.goals.length, (index) {
          final isLast = index == widget.goals.length - 1;
          return Column(
            children: [
              _buildGoalItem(widget.goals[index], index),
              if (!isLast) SizedBox(height: 16.h),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildGoalItem(GoalData goal, int index) {
    final color = _getGoalColor(index);

    return AnimatedBuilder(
      animation: _progressAnimations[index],
      builder: (context, child) {
        final animatedProgress =
            goal.progressPercentage * _progressAnimations[index].value;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // Icon
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(goal.icon, style: TextStyle(fontSize: 20.sp)),
                ),
                SizedBox(width: 12.w),

                // Goal Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: TextStyles.font14PrimaryTextMedium,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        goal.progressText,
                        style: TextStyles.caption.copyWith(
                          color: goal.isAchieved
                              ? ColorsManager.success
                              : ColorsManager.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Percentage Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: goal.isAchieved
                        ? ColorsManager.primaryGradient
                        : LinearGradient(
                            colors: [
                              color.withOpacity(0.2),
                              color.withOpacity(0.1),
                            ],
                          ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '${animatedProgress.toStringAsFixed(0)}%',
                    style: TextStyles.font14Bold.copyWith(
                      color: goal.isAchieved ? ColorsManager.whiteText : color,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Progress Bar
            Stack(
              children: [
                // Background
                Container(
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.grey200,
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                ),

                // Animated Progress
                FractionallySizedBox(
                  widthFactor: animatedProgress / 100,
                  child: Container(
                    height: 10.h,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: goal.isAchieved
                            ? [ColorsManager.success, ColorsManager.success]
                            : [color, color.withOpacity(0.7)],
                      ),
                      borderRadius: BorderRadius.circular(5.r),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // Achievement Indicator
                if (goal.isAchieved)
                  Positioned(
                    right: 4.w,
                    top: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 10.sp,
                    ),
                  ),
              ],
            ),

            // Stats Row
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatChip(
                  'Start',
                  goal.startValue,
                  goal.unit,
                  Colors.grey,
                ),
                _buildStatChip('Current', goal.currentValue, goal.unit, color),
                _buildStatChip(
                  'Goal',
                  goal.goalValue,
                  goal.unit,
                  ColorsManager.primaryGreen,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatChip(String label, double value, String unit, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyles.caption.copyWith(fontSize: 9.sp)),
          Text(
            '${value.toStringAsFixed(1)}$unit',
            style: TextStyles.font12Bold.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Color _getGoalColor(int index) {
    final colors = [
      ColorsManager.primaryGreen,
      ColorsManager.info,
      ColorsManager.warning,
    ];
    return colors[index % colors.length];
  }
}
