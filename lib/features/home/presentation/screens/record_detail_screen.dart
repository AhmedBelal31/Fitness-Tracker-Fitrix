import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fitrix/core/theming/app_colors.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../data/achievements_models.dart';

class RecordDetailScreen extends StatefulWidget {
  final MilestoneModel milestone;

  const RecordDetailScreen({super.key, required this.milestone});

  @override
  State<RecordDetailScreen> createState() => _RecordDetailScreenState();
}

class _RecordDetailScreenState extends State<RecordDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _particleController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    // Hero card animation
    _heroController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Particle animation
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    // Pulse animation
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    // Scale with bounce
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.elasticOut),
    );

    // Fade in
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Slide from top
    _slideAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    // Rotate emoji
    _rotateAnimation = Tween<double>(begin: -0.5, end: 0).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    // Glow pulse
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _heroController.forward();
  }

  @override
  void dispose() {
    _heroController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.record_details, style: TextStyles.headline3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildHeroCard(),
            SizedBox(height: 24.h),
            _buildExerciseInfo(),
            SizedBox(height: 16.h),
            _buildRecordStats(),
            SizedBox(height: 16.h),
            _buildWorkoutInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _heroController,
        _particleController,
        _pulseController,
      ]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Stack(
                children: [
                  // Animated particles background
                  ..._buildParticles(),

                  // Main card with glow
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorsManager.warning.withValues(
                            alpha: 0.3 * _glowAnimation.value,
                          ),
                          blurRadius: 40,
                          spreadRadius: 10,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorsManager.warning,
                            ColorsManager.warning.withValues(alpha: 0.8),
                            ColorsManager.warning.withValues(alpha: 0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        children: [
                          // Animated emoji with rotation
                          Transform.rotate(
                            angle: _rotateAnimation.value * math.pi / 4,
                            child: Transform.scale(
                              scale: 1.0 + (_glowAnimation.value * 0.1),
                              child: Container(
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.2),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withValues(
                                        alpha: 0.3 * _glowAnimation.value,
                                      ),
                                      blurRadius: 30,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  widget.milestone.icon,
                                  style: TextStyle(fontSize: 80.sp),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Title with shimmer effect
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white,
                                  Colors.white.withValues(alpha: 0.8),
                                  Colors.white,
                                ],
                                stops: [0.0, _particleController.value, 1.0],
                              ).createShader(bounds);
                            },
                            child: Text(
                              widget.milestone.title,
                              style: TextStyles.headline2.copyWith(
                                color: ColorsManager.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // Description
                          Text(
                            widget.milestone.description,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16.sp,
                              color: Colors.black.withValues(alpha: .7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildParticles() {
    return List.generate(8, (index) {
      final angle = (index * math.pi * 2) / 8;
      final distance = 120.w * _particleController.value;

      return Positioned(
        left:
            (MediaQuery.of(context).size.width / 2) +
            math.cos(angle + _particleController.value * math.pi * 2) *
                distance,
        top:
            (200.h / 2) +
            math.sin(angle + _particleController.value * math.pi * 2) *
                distance,
        child: Opacity(
          opacity: (1 - _particleController.value).clamp(0.0, 0.6),
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildExerciseInfo() {
    final s = S.of(context); // ✅ Get localization

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(30 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.fitness_center_rounded,
                  color: ColorsManager.primaryGreen,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(s.exercise, style: TextStyles.font16PrimaryTextBold), // ✅
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              widget.milestone.record.userExercise?.name ??
                  s.unknown_exercise, // ✅
              style: TextStyles.font18PrimaryTextMedium,
            ),
            if (widget.milestone.record.userExercise?.description != null) ...[
              SizedBox(height: 8.h),
              Text(
                widget.milestone.record.userExercise!.description!,
                style: TextStyles.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecordStats() {
    final s = S.of(context); // ✅ Get localization
    final record = widget.milestone.record;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(-30 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              Icons.fitness_center,
              record.value.toStringAsFixed(record.recordType == 3 ? 0 : 1),
              _getRecordTypeLabel(record.recordType, s), // ✅ Localized
            ),
            _buildDivider(),
            _buildStatItem(
              Icons.calendar_today,
              DateFormat('MMM d').format(record.createdAtUtc),
              s.date, // ✅
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Helper method for localized record types
  String _getRecordTypeLabel(int recordType, S s) {
    switch (recordType) {
      case 1:
        return s.weight;
      case 2:
        return s.reps;
      case 3:
        return s.volume;
      default:
        return 'Unknown';
    }
  }

  Widget _buildWorkoutInfo() {
    final s = S.of(context); // ✅ Get localization
    final workout = widget.milestone.record.workoutSession;
    if (workout == null) return const SizedBox();

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1200),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.scale(scale: 0.9 + (0.1 * value), child: child),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.event_note_rounded,
                  color: ColorsManager.primaryGreen,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  s.workout_session,
                  style: TextStyles.font16PrimaryTextBold,
                ), // ✅
              ],
            ),
            SizedBox(height: 12.h),
            _buildInfoRow(
              Icons.event,
              s.date, // ✅
              DateFormat('MMM d, yyyy').format(workout.date),
            ),
            if (workout.notes != null) ...[
              SizedBox(height: 8.h),
              _buildInfoRow(Icons.notes, s.notes, workout.notes!), // ✅
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: ColorsManager.primaryGreen, size: 28.sp),
        SizedBox(height: 8.h),
        Text(
          value,
          style: GoogleFonts.aBeeZee(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: ColorsManager.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyles.caption),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1.w,
      height: 60.h,
      color: ColorsManager.lightText.withValues(alpha: 0.2),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16.sp, color: ColorsManager.secondaryText),
        SizedBox(width: 8.w),
        Text('$label: ', style: TextStyles.font14SecondaryTextRegular),
        Expanded(child: Text(value, style: TextStyles.font14PrimaryTextMedium)),
      ],
    );
  }
}
