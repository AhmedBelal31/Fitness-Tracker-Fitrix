import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/common_ui/widgets/adaptive_back_button.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/routing/routes.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/notification_model.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../widgets/empty_notifications_widget.dart';
import '../widgets/notification_type_icon.dart';
import 'dart:math' as math;

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    // Always refresh when screen opens
    context.read<NotificationsCubit>().refresh();
    _scrollController.addListener(_onScroll);

    _waveController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<NotificationsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.getScaffoldBackground(context),
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 56.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20.h),
                child: Stack(
                  children: [
                    // Back button on the left
                    Positioned(
                      left: 20.w,
                      top: 0,
                      bottom: 0,
                      child: AdaptiveBackButton(
                        isLoading: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    // Title centered
                    Center(
                      child: Text(
                        s.notifications,
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state is NotificationsLoaded && state.unreadCount > 0) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorsManager.getPrimaryGreen(
                                context,
                              ).withValues(alpha: 0.1),
                              ColorsManager.getSecondaryGreen(
                                context,
                              ).withValues(alpha: 0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              context
                                  .read<NotificationsCubit>()
                                  .markAllAsRead();
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      color: ColorsManager.getPrimaryGreen(
                                        context,
                                      ).withValues(alpha: 0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.done_all,
                                      color: ColorsManager.getPrimaryGreen(
                                        context,
                                      ),
                                      size: 20.sp,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          s.mark_all_read,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                ColorsManager.getPrimaryGreen(
                                                  context,
                                                ),
                                          ),
                                        ),
                                        Text(
                                          '${state.unreadCount} unread',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color:
                                                ColorsManager.getSecondaryText(
                                                  context,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16.sp,
                                    color: ColorsManager.getPrimaryGreen(
                                      context,
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
                  return const SizedBox.shrink();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Divider(indent: 20, endIndent: 20),
              ),
            ),
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsLoading) {
                  return SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          ColorsManager.getPrimaryGreen(context),
                        ),
                      ),
                    ),
                  );
                }

                if (state is NotificationsError) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 64.sp,
                            color: ColorsManager.error,
                          ),
                          SizedBox(height: 16.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              state.message,
                              style: TextStyle(
                                color: ColorsManager.getSecondaryText(context),
                                fontSize: 16.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 24.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.read<NotificationsCubit>().refresh();
                            },
                            icon: const Icon(Icons.refresh),
                            label: Text(s.retry),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state is NotificationsLoaded) {
                  if (state.notifications.isEmpty) {
                    return const SliverFillRemaining(
                      child: EmptyNotificationsWidget(),
                    );
                  }

                  return SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        if (index >= state.notifications.length) {
                          return state.hasMore
                              ? Padding(
                                  padding: EdgeInsets.all(16.h),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                        ColorsManager.getPrimaryGreen(context),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        }

                        final notification = state.notifications[index];
                        return _buildNotificationItem(
                          context,
                          notification,
                          index,
                        );
                      }, childCount: state.notifications.length + 1),
                    ),
                  );
                }

                return const SliverFillRemaining(child: SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    NotificationModel notification,
    int index,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (index * 50)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final clampedValue = value.clamp(0.0, 1.0);

        return Opacity(
          opacity: clampedValue,
          child: Transform.translate(
            offset: Offset(50 * (1 - clampedValue), 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Slidable(
          key: ValueKey(notification.id),
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  context.read<NotificationsCubit>().deleteNotification(
                    notification.id,
                  );
                },
                backgroundColor: ColorsManager.error,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
                borderRadius: BorderRadius.circular(16.r),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              if (!notification.isRead) {
                context.read<NotificationsCubit>().markAsRead(notification.id);
              }
              Navigator.pushNamed(
                context,
                Routes.notificationDetails,
                arguments: notification,
              );
            },
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: notification.isRead
                    ? ColorsManager.getCardBackground(context)
                    : ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: notification.isRead
                      ? (isDark
                            ? ColorsManager.darkBorder
                            : ColorsManager.lightBorder)
                      : ColorsManager.getPrimaryGreen(
                          context,
                        ).withValues(alpha: 0.3),
                  width: notification.isRead ? 1 : 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NotificationTypeIcon(type: notification.type),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: notification.isRead
                                      ? FontWeight.w600
                                      : FontWeight.bold,
                                  color: ColorsManager.getPrimaryText(context),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8.w,
                                height: 8.h,
                                margin: EdgeInsets.only(left: 8.w),
                                decoration: BoxDecoration(
                                  color: ColorsManager.getPrimaryGreen(context),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          notification.body,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          timeago.format(
                            notification.createdAtUtc,
                            locale: 'en_short',
                          ),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorsManager.getSecondaryText(
                              context,
                            ).withValues(alpha: 0.7),
                          ),
                        ),
                      ],
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

// Subtle Wave Painter - Elegant and Simple
class SubtleWavePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  SubtleWavePainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Start from top-left
    path.moveTo(0, size.height * 0.5);

    // Create smooth wave
    for (double i = 0; i <= size.width; i += 5) {
      final normalizedX = i / size.width;
      final y =
          size.height * 0.5 +
          math.sin(
                (normalizedX * 2 * math.pi) + (animationValue * 2 * math.pi),
              ) *
              (size.height * 0.3);

      path.lineTo(i, y);
    }

    // Complete the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SubtleWavePainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}
