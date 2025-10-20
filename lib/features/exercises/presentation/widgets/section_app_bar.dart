import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import 'animated_icon_widget.dart';
import 'exercise_helpers.dart';

class SectionAppBar extends StatelessWidget {
  final String sectionName;
  final bool isAddingToWorkout;
  final TickerProvider vsync;

  const SectionAppBar({
    super.key,
    required this.sectionName,
    required this.isAddingToWorkout,
    required this.vsync,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SliverAppBar(
      expandedHeight: 220.h,
      pinned: true,
      backgroundColor: ColorsManager.primaryGreen,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOut,
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 10 * (1 - value)),
                child: child,
              ),
            );
          },
          child: Text(
            isAddingToWorkout
                ? '${s.add_exercise} - $sectionName'
                : sectionName,
            style: TextStyles.font16WhiteRegular,
            textAlign: TextAlign.center,
          ),
        ),
        background: _buildBackground(context, s),
      ),
    );
  }

  Widget _buildBackground(BuildContext context, S s) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: ColorsManager.appBarBackgroundGradient,
          ),
        ),
        Positioned.fill(child: CustomPaint(painter: _AppBarPatternPainter())),
        _buildFloatingCircles(),
        _buildMainContent(s),
      ],
    );
  }

  Widget _buildFloatingCircles() {
    return Stack(
      children: [
        _buildCircle(
          top: 40.h,
          right: 30.w,
          size: 100.w,
          duration: 1200,
          offset: Offset(20, -20),
        ),
        _buildCircle(
          bottom: 30.h,
          left: 20.w,
          size: 120.w,
          duration: 1500,
          offset: Offset(-10, 30),
        ),
        _buildCircle(
          top: 100.h,
          left: 50.w,
          size: 80.w,
          duration: 1800,
          offset: Offset(-15, 15),
        ),
      ],
    );
  }

  Widget _buildCircle({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required int duration,
    required Offset offset,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Positioned(
          top: top != null ? top + offset.dy * value : null,
          bottom: bottom != null ? bottom + offset.dy * value : null,
          left: left != null ? left + offset.dx * value : null,
          right: right != null ? right + offset.dx * value : null,
          child: Opacity(
            opacity: 0.1 * value,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(S s) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.85 + (value * 0.15),
          child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50.h),
            AnimatedIconWidget(
              isAddingToWorkout: isAddingToWorkout,
              vsync: vsync,
            ),
            SizedBox(height: 16.h),
            _buildSubtitle(s),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitle(S s) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          isAddingToWorkout
              ? s.tap_to_add_exercise
              : ExerciseHelpers.getSectionDescription(s, sectionName),
          style: TextStyles.font14WhiteMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _AppBarPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (double i = -size.height; i < size.width + size.height; i += 25) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }

    final dotPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += 40) {
      for (double y = 0; y < size.height; y += 40) {
        canvas.drawCircle(Offset(x + 20, y + 20), 2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
