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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: color.withValues(alpha: isDark ? 0.4 : 0.3),
                width: 1,
              ),
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
                Icon(icon, color: color, size: 28.sp),
                SizedBox(height: 8.h),
                TweenAnimationBuilder<int>(
                  tween: IntTween(begin: 0, end: int.tryParse(value) ?? 0),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, val, child) {
                    return Text(
                      val.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                    );
                  },
                ),
                SizedBox(height: 4.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.getSecondaryText(context),
                  ),
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
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
              ? ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.15 : 0.1)
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
                    : (isDark
                          ? ColorsManager.darkInputBackground
                          : Colors.grey[300]),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${widget.setNumber}',
                  style: TextStyle(
                    fontSize: 14,
                    color: widget.isCompleted
                        ? Colors.white
                        : (isDark ? Colors.white : Colors.black),
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
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    '${widget.weight.toInt()} ${s.kg}',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorsManager.getPrimaryText(context),
                    ),
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
                color: ColorsManager.getPrimaryGreen(context),
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }
}
