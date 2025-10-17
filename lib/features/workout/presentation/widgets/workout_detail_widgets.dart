import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

// ========== ANIMATED EXERCISE CARD ==========
class AnimatedExerciseCard extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedExerciseCard({
    super.key,
    required this.child,
    required this.index,
  });

  @override
  State<AnimatedExerciseCard> createState() => _AnimatedExerciseCardState();
}

class _AnimatedExerciseCardState extends State<AnimatedExerciseCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}

// ========== STAT CARD ==========
class WorkoutStatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final int index;

  const WorkoutStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.index = 0,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, animValue, child) {
        return Transform.scale(
          scale: animValue,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: ColorsManager.cardBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
              boxShadow: ColorsManager.softShadow,
            ),
            child: Column(
              children: [
                Icon(icon, color: color, size: 28.sp),
                SizedBox(height: 8.h),
                TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: int.tryParse(value) ?? 0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, val, child) {
                    return Text(
                      val.toString(),
                      style: TextStyles.font24PrimaryTextBold.copyWith(
                        fontSize: 20.sp, // ✅ Using existing style with fontSize
                      ),
                    );
                  },
                ),
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
      },
    );
  }
}

// ========== SET ROW ==========
class SetRow extends StatefulWidget {
  final int setNumber;
  final int reps;
  final double weight;
  final bool isCompleted;
  final bool isPersonalRecord;
  final VoidCallback? onTap;

  const SetRow({
    super.key,
    required this.setNumber,
    required this.reps,
    required this.weight,
    required this.isCompleted,
    required this.isPersonalRecord,
    this.onTap,
  });

  @override
  State<SetRow> createState() => _SetRowState();
}

class _SetRowState extends State<SetRow> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    var s = S.of(context);
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: _isPressed
              ? ColorsManager.primaryGreen.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              width: 32.w,
              height: 32.w,
              decoration: BoxDecoration(
                color: widget.isCompleted
                    ? ColorsManager.success
                    : Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${widget.setNumber}',
                  style: TextStyles.bodyMedium.copyWith(
                    color: widget.isCompleted ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Row(
                children: [
                  Text(
                    '${widget.reps} ${s.reps}',
                    style: TextStyles.bodyMedium,
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    '${widget.weight.toInt()} ${s.kg}',
                    style: TextStyles.bodyMedium,
                  ),
                  if (widget.isPersonalRecord) ...[
                    SizedBox(width: 8.w),
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                  ],
                ],
              ),
            ),
            if (!widget.isCompleted)
              Icon(
                Icons.edit_outlined,
                color: ColorsManager.primaryGreen,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
