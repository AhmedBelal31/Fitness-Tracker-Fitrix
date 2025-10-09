import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class StatCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;
  final int index;

  const StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    this.index = 0,
    super.key,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatingAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Different duration for each card
    final baseDuration = 1000 + (widget.index * 350); // 2s, 2.35s, 2.7s
    _controller = AnimationController(
      duration: Duration(milliseconds: baseDuration),
      vsync: this,
    );

    // Floating animation (up and down)
    _floatingAnimation = Tween<double>(
      begin: -8.0,
      end: 8.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Breathing scale effect
    _scaleAnimation = Tween<double>(
      begin: 0.97,
      end: 1.03,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start animation after first frame with staggered delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: widget.index * 100), () {
        if (mounted) {
          _controller.repeat(reverse: true);
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value),
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorsManager.cardBackground,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15 + (_scaleAnimation.value * 5),
                    spreadRadius: 1,
                    offset: Offset(0, 4 + _floatingAnimation.value / 3),
                  ),
                  BoxShadow(
                    color: widget.color.withOpacity(0.15),
                    blurRadius: 8 + (_scaleAnimation.value * 3),
                    spreadRadius: 0,
                    offset: Offset(0, 2 + _floatingAnimation.value / 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Icon
                  TweenAnimationBuilder<double>(
                    duration: Duration(
                      milliseconds: 800 + (widget.index * 150),
                    ),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: widget.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.icon,
                            color: widget.color,
                            size: 28.sp,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),

                  // Animated Value
                  TweenAnimationBuilder<double>(
                    duration: Duration(
                      milliseconds: 1000 + (widget.index * 150),
                    ),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: Text(
                            widget.value,
                            style: TextStyles.font20PrimaryTextSemiBold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 4.h),

                  // Animated Title
                  TweenAnimationBuilder<double>(
                    duration: Duration(
                      milliseconds: 1200 + (widget.index * 150),
                    ),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Text(
                          widget.title,
                          style: TextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 2.h),

                  // Animated Subtitle
                  TweenAnimationBuilder<double>(
                    duration: Duration(
                      milliseconds: 1400 + (widget.index * 150),
                    ),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Text(
                          widget.subtitle,
                          style: TextStyles.caption,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
