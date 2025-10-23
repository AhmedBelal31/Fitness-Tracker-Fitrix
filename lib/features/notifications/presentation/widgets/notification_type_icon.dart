import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/notification_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../data/models/notification_model.dart';

class NotificationTypeIcon extends StatelessWidget {
  final NotificationType type;

  const NotificationTypeIcon({super.key, required this.type});

  IconData get _icon {
    switch (type) {
      case NotificationType.general:
        return Icons.info_outline;
      case NotificationType.workout:
        return Icons.fitness_center;
      case NotificationType.progress:
        return Icons.trending_up;
      case NotificationType.achievement:
        return Icons.emoji_events;
      case NotificationType.trainer:
        return Icons.person;
      case NotificationType.reminder:
        return Icons.alarm;
      case NotificationType.update:
        return Icons.system_update;
      case NotificationType.system:
        return Icons.settings;
      case NotificationType.social:
        return Icons.people;
      case NotificationType.custom:
        return Icons.notifications_active;
    }
  }

  Color get _color {
    switch (type) {
      case NotificationType.general:
        return ColorsManager.info;
      case NotificationType.workout:
        return ColorsManager.primaryGreen;
      case NotificationType.progress:
        return ColorsManager.progressHigh;
      case NotificationType.achievement:
        return ColorsManager.warning;
      case NotificationType.trainer:
        return ColorsManager.primaryGreen;
      case NotificationType.reminder:
        return ColorsManager.error;
      case NotificationType.update:
        return ColorsManager.info;
      case NotificationType.system:
        return ColorsManager.grey600;
      case NotificationType.social:
        return ColorsManager.blue;
      case NotificationType.custom:
        return ColorsManager.primaryGreen;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_color, _color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: _color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(_icon, color: Colors.white, size: 24.sp),
    );
  }
}
