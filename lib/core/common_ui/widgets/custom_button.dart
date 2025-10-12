import 'package:flutter/material.dart';

import '../../theming/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double height;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.width,
    this.height = 56,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = isLoading || onPressed == null;

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // Use gradient only when enabled (not loading and onPressed != null)
        gradient: !isOutlined && !isDisabled
            ? ColorsManager.buttonGradient
            : null,

        boxShadow: !isOutlined && !isDisabled
            ? ColorsManager.primaryShadow
            : null,

        // Add a solid background color when loading or disabled to prevent blank white area
        color: isOutlined
            ? Colors.transparent
            : isDisabled
            ? ColorsManager
                  .buttonDisabledBackground // define this color (e.g. dark grey)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // Disable tap during loading
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isOutlined
                  ? Border.all(color: ColorsManager.primaryBorder, width: 2)
                  : null,
              color: isOutlined ? Colors.transparent : null,
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ColorsManager.whiteText,
                        ),
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: isOutlined
                                ? ColorsManager.primaryGreen
                                : ColorsManager.whiteText,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isOutlined
                                ? ColorsManager.primaryGreen
                                : ColorsManager.whiteText,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
