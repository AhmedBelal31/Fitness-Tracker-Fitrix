import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/statistics_model.dart';

class StatisticsCards extends StatefulWidget {
  final StatisticsResponse? statistics;
  final S s;

  const StatisticsCards({super.key, required this.statistics, required this.s});

  @override
  State<StatisticsCards> createState() => _StatisticsCardsState();
}

class _StatisticsCardsState extends State<StatisticsCards>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  void _initAnimations() {
    _controllers = List.generate(
      4,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    }).toList();

    _fadeAnimations = _controllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    }).toList();

    // Start animations with stagger
    for (int i = 0; i < _controllers.length; i++) {
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
    if (widget.statistics == null) {
      return _buildLoadingState();
    }

    final stats = widget.statistics!;

    return Column(
      children: [
        // First Row
        Row(
          children: [
            Expanded(
              child: _buildAnimatedStatCard(
                icon: Icons.fitness_center,
                value: stats.workoutsCount.toString(),
                label: widget.s.workouts,
                color: ColorsManager.primaryGreen,
                animationIndex: 0,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildAnimatedStatCard(
                icon: Icons.emoji_events,
                value: stats.recordsCount.toString(),
                label: widget.s.records,
                color: ColorsManager.warning,
                animationIndex: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Second Row
        Row(
          children: [
            Expanded(
              child: _buildAnimatedStatCard(
                icon: Icons.timer_outlined,
                value:
                    '${stats.averageWorkoutDuration.toStringAsFixed(0)}${widget.s.minutes_short}',
                label: widget.s.avg_duration,
                color: ColorsManager.info,
                animationIndex: 2,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildAnimatedStatCard(
                icon: Icons.trending_up,
                value: stats.averageWorkoutsPerWeek.toStringAsFixed(1),
                label: widget.s.per_week,
                color: ColorsManager.success,
                animationIndex: 3,
              ),
            ),
          ],
        ),

        // Optional: Personal Bests Section
        if (stats.personalBestWeight > 0) ...[
          SizedBox(height: 16.h),
          _buildPersonalBestsCard(stats),
        ],
      ],
    );
  }

  Widget _buildAnimatedStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required int animationIndex,
  }) {
    return AnimatedBuilder(
      animation: _controllers[animationIndex],
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimations[animationIndex].value,
          child: Opacity(
            opacity: _fadeAnimations[animationIndex].value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(height: 12.h),
            Text(value, style: TextStyles.font24PrimaryTextBold),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyles.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalBestsCard(StatisticsResponse stats) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.warning.withValues(alpha: 0.1),
            ColorsManager.warning.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: ColorsManager.warning.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: ColorsManager.warning,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                widget.s.personal_bests,
                style: TextStyles.font16PrimaryTextSemiBold,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPBItem(
                widget.s.weight,
                '${stats.personalBestWeight.toStringAsFixed(0)}${widget.s.kg}',
              ),
              _buildPBItem(widget.s.reps, '${stats.personalBestReps}'),
              _buildPBItem(
                widget.s.volume,
                '${(stats.personalBestVolume / 1000).toStringAsFixed(1)}t',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPBItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: TextStyles.font16SuccessBold),
        SizedBox(height: 2.h),
        Text(label, style: TextStyles.caption),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Row(
      children: [
        Expanded(child: _buildSkeletonCard()),
        SizedBox(width: 12.w),
        Expanded(child: _buildSkeletonCard()),
      ],
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
    );
  }
}
