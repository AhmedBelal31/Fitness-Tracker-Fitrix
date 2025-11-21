import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class DeletingOverlay extends StatelessWidget {
  const DeletingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 300),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(opacity: value, child: child);
      },
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 400),
            tween: Tween<double>(begin: 0, end: 1),
            curve: Curves.elasticOut,
            builder: (context, double value, child) {
              return Transform.scale(scale: value, child: child);
            },
            child: Card(
              color: ColorsManager.cardBackground,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(32.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      color: ColorsManager.primaryGreen,
                      strokeWidth: 3,
                    ),
                    SizedBox(height: 20.h),
                    Text(s.deleting, style: TextStyles.headline3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
