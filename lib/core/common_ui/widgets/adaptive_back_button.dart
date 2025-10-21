import 'package:flutter/material.dart';
import '../../theming/app_colors.dart';

class AdaptiveBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const AdaptiveBackButton({super.key, this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? ColorsManager.darkSurface.withValues(alpha: 0.9)
            : ColorsManager.cardBackground.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading
              ? null
              : (onPressed ?? () => Navigator.of(context).pop()),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: ColorsManager.getPrimaryGreen(context),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
