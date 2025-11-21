import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../theming/app_colors.dart';

void showMiniSnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
  IconData? icon,
  Color? iconColor,
  TextStyle? textStyle,
  Duration? displayDuration,
}) {
  showTopSnackBar(
    Overlay.of(context),
    Material(
      color: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.info,
              size: 20,
              color: iconColor ?? Colors.white,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style:
                    textStyle ??
                    const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ),
    displayDuration: displayDuration ?? const Duration(seconds: 2),
  );
}

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  IconData? icon,
  Color? iconColor,
  Duration? displayDuration,
}) {
  showMiniSnackBar(
    context,
    message: message,
    backgroundColor: ColorsManager.primaryGreen,
    icon: icon ?? Icons.check_circle,
    iconColor: iconColor ?? Colors.white,
    textStyle: textStyle ?? const TextStyle(color: Colors.white, fontSize: 14),
    displayDuration: displayDuration,
  );
}

void showFailureSnackBar({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  IconData? icon,
  Color? iconColor,
}) {
  showMiniSnackBar(
    context,
    message: message,
    backgroundColor: Colors.red,
    icon: icon ?? Icons.error,
    iconColor: iconColor ?? Colors.white,
    textStyle: textStyle ?? const TextStyle(color: Colors.white, fontSize: 14),
  );
}

void showInformationSnackBar({
  required BuildContext context,
  required String message,
  TextStyle? textStyle,
  IconData? icon,
  Color? iconColor,
}) {
  showMiniSnackBar(
    context,
    message: message,
    backgroundColor: Colors.amber,
    icon: icon ?? Icons.info,
    iconColor: iconColor ?? Colors.black,
    textStyle: textStyle ?? const TextStyle(color: Colors.black, fontSize: 14),
  );
}
