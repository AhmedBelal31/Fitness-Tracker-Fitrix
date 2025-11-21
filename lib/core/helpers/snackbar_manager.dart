import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SnackBarManager {
  static DateTime? _lastShownTime;
  static String? _lastMessage;

  static void showSuccess(
    BuildContext context,
    String message, {
    String? actionLabel,
  }) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
      actionLabel: actionLabel,
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    String? actionLabel,
  }) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
      actionLabel: actionLabel,
    );
  }

  static void showInfo(
    BuildContext context,
    String message, {
    String? actionLabel,
  }) {
    _show(
      context: context,
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
      actionLabel: actionLabel,
    );
  }

  static void _show({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    String? actionLabel,
  }) {
    final now = DateTime.now();

    // ✅ Prevent duplicate within 500ms
    if (_lastMessage == message &&
        _lastShownTime != null &&
        now.difference(_lastShownTime!) < const Duration(milliseconds: 500)) {
      return;
    }

    _lastMessage = message;
    _lastShownTime = now;

    // ✅ Clear previous snackbars
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.only(bottom: 20.h, left: 16.w, right: 16.w),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: actionLabel ?? 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _lastMessage = null;
            _lastShownTime = null;
          },
        ),
      ),
    );
  }
}
