import 'package:flutter/material.dart';

import '../../theming/app_colors.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final bool isLoading;
//   final bool isOutlined;
//   final double? width;
//   final double height;
//   final IconData? icon;
//
//   const CustomButton({
//     super.key,
//     required this.text,
//     this.onPressed,
//     this.isLoading = false,
//     this.isOutlined = false,
//     this.width,
//     this.height = 56,
//     this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final bool isDisabled = isLoading || onPressed == null;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       width: width ?? double.infinity,
//       height: height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         // 🎨 Adaptive gradient
//         gradient: !isOutlined && !isDisabled
//             ? ColorsManager.getButtonGradient(context)
//             : null,
//         // 🎨 Adaptive shadow/glow
//         boxShadow: !isOutlined && !isDisabled
//             ? [
//                 BoxShadow(
//                   color: isDark
//                       ? ColorsManager.darkPrimaryGreen.withOpacity(0.3)
//                       : ColorsManager.primaryGreen.withOpacity(0.3),
//                   blurRadius: isDark ? 16 : 12,
//                   spreadRadius: isDark ? 1 : 2,
//                   offset: Offset(0, isDark ? 0 : 6),
//                 ),
//               ]
//             : null,
//         // 🎨 Adaptive disabled background
//         color: isOutlined
//             ? Colors.transparent
//             : isDisabled
//             ? (isDark ? ColorsManager.darkSurface : const Color(0xFFE0E0E0))
//             : null,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: isLoading ? null : onPressed,
//           borderRadius: BorderRadius.circular(16),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               border: isOutlined
//                   ? Border.all(
//                       color: ColorsManager.getPrimaryGreen(context),
//                       width: 2,
//                     )
//                   : null,
//               color: isOutlined ? Colors.transparent : null,
//             ),
//             child: Center(
//               child: isLoading
//                   ? SizedBox(
//                       width: 24,
//                       height: 24,
//                       child: CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           isOutlined
//                               ? ColorsManager.getPrimaryGreen(context)
//                               : (isDark
//                                     ? ColorsManager.darkScaffold
//                                     : Colors.white),
//                         ),
//                         strokeWidth: 2.5,
//                       ),
//                     )
//                   : Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         if (icon != null) ...[
//                           Icon(
//                             icon,
//                             color: isOutlined
//                                 ? ColorsManager.getPrimaryGreen(context)
//                                 : (isDark
//                                       ? ColorsManager.darkScaffold
//                                       : Colors.white),
//                             size: 20,
//                           ),
//                           const SizedBox(width: 8),
//                         ],
//                         Text(
//                           text,
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: isOutlined
//                                 ? ColorsManager.getPrimaryGreen(context)
//                                 : (isDark
//                                       ? ColorsManager.darkScaffold
//                                       : Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

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
    final bool isDisabled = onPressed == null && !isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: !isOutlined && !isDisabled
            ? ColorsManager.getButtonGradient(context)
            : null,
        boxShadow: !isOutlined && !isDisabled
            ? [
                BoxShadow(
                  color: isDark
                      ? ColorsManager.darkPrimaryGreen.withValues(alpha: 0.3)
                      : ColorsManager.primaryGreen.withValues(alpha: 0.3),
                  blurRadius: isDark ? 16 : 12,
                  spreadRadius: isDark ? 1 : 2,
                  offset: Offset(0, isDark ? 0 : 6),
                ),
              ]
            : null,
        color: isOutlined
            ? Colors.transparent
            : isDisabled
            ? (isDark ? ColorsManager.darkSurface : const Color(0xFFE0E0E0))
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading || onPressed == null ? null : onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: isOutlined
                  ? Border.all(
                      color: ColorsManager.getPrimaryGreen(context),
                      width: 2,
                    )
                  : null,
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          isOutlined
                              ? ColorsManager.getPrimaryGreen(context)
                              : (isDark
                                    ? ColorsManager.darkScaffold
                                    : Colors.white),
                        ),
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color: isOutlined
                                ? ColorsManager.getPrimaryGreen(context)
                                : (isDark
                                      ? ColorsManager.darkScaffold
                                      : Colors.white),
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
                                ? ColorsManager.getPrimaryGreen(context)
                                : (isDark
                                      ? ColorsManager.darkScaffold
                                      : Colors.white),
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
