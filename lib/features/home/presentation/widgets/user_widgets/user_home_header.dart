import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../notifications/presentation/cubit/notifications_cubit.dart';
import '../../../../notifications/presentation/cubit/notifications_state.dart';
import '../../../../notifications/presentation/widgets/notification_badge_painter.dart';

class UserHomeHeader extends StatefulWidget {
  const UserHomeHeader({super.key});

  @override
  State<UserHomeHeader> createState() => _UserHomeHeaderState();
}

class _UserHomeHeaderState extends State<UserHomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = HiveService().getProfile();
    final s = S.of(context);
    var firstAndLastName =
        ((profile?.firstName?.isNotEmpty ?? false) ||
            (profile?.lastName?.isNotEmpty ?? false))
        ? '${profile?.firstName ?? ""} ${profile?.lastName ?? ""}'.trim()
        : s.fitrixUser;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.welcome_back,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  firstAndLastName,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
              ],
            ),
          ),
          // Notification Bell Icon
          _buildNotificationBell(context),
        ],
      ),
    );
  }

  Widget _buildNotificationBell(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final unreadCount = state is NotificationsLoaded
            ? state.unreadCount
            : 0;
        final hasUnread = unreadCount > 0;

        return TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 400),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.scale(scale: 0.8 + (0.2 * value), child: child);
          },
          child: GestureDetector(
            onTap: () async {
              // Navigate to notifications
              await Navigator.pushNamed(context, Routes.notifications);

              // Refresh count when returning
              if (mounted) {
                context.read<NotificationsCubit>().fetchUnreadCount();
              }
            },
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: ColorsManager.getCardBackground(context),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withOpacity(hasUnread ? 0.3 : 0.1),
                    blurRadius: hasUnread ? 12 : 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: Icon(
                      hasUnread
                          ? Icons.notifications_active
                          : Icons.notifications_outlined,
                      color: hasUnread
                          ? ColorsManager.getPrimaryGreen(context)
                          : ColorsManager.getSecondaryText(context),
                      size: 24.sp,
                    ),
                  ),
                  if (hasUnread)
                    Positioned(
                      top: 6.h,
                      right: 6.w,
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            size: Size(18.w, 18.h),
                            painter: NotificationBadgePainter(
                              badgeColor: ColorsManager.error,
                              glowColor: ColorsManager.error,
                              animate: true,
                              animationValue: _pulseAnimation.value,
                            ),
                            child: Container(
                              width: 18.w,
                              height: 18.h,
                              alignment: Alignment.center,
                              child: Text(
                                unreadCount > 9 ? '9+' : '$unreadCount',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: unreadCount > 9 ? 9.sp : 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
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
