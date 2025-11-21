import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class SectionSelectionCard extends StatelessWidget {
  final dynamic section;
  final VoidCallback onTap;

  const SectionSelectionCard({
    super.key,
    required this.section,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          decoration: BoxDecoration(
            gradient: ColorsManager.primaryGradient,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CustomPaint(painter: _PatternPainter()),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildIcon(),
                    SizedBox(height: 12.h),
                    _buildTitle(),
                    if (section.description != null) ...[
                      SizedBox(height: 4.h),
                      _buildDescription(),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: 8.w,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: ColorsManager.whiteText,
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getSectionIcon(),
        color: ColorsManager.whiteText,
        size: 32.sp,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      section.name ?? '',
      style: TextStyles.headline3.copyWith(
        color: ColorsManager.whiteText,
        fontSize: 16.sp,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription() {
    return Text(
      section.description ?? '',
      style: TextStyles.caption.copyWith(
        color: ColorsManager.whiteText.withValues(alpha: 0.8),
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  IconData _getSectionIcon() {
    final name = section.name?.toLowerCase() ?? '';

    if (name.contains('chest')) return Icons.fitness_center;
    if (name.contains('back')) return Icons.accessibility_new;
    if (name.contains('leg')) return Icons.directions_run;
    if (name.contains('arm')) return Icons.sports_martial_arts;
    if (name.contains('shoulder')) return Icons.sports_gymnastics;
    if (name.contains('core') || name.contains('abs')) return Icons.spa;
    if (name.contains('cardio')) return Icons.favorite;

    return Icons.fitness_center;
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    for (double i = -size.height; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
