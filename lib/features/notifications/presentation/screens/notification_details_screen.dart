import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/notification_model.dart';
import '../cubit/notifications_cubit.dart';
import '../widgets/notification_type_icon.dart';
import 'dart:math' as math;

class NotificationDetailsScreen extends StatefulWidget {
  final NotificationModel notification;

  const NotificationDetailsScreen({super.key, required this.notification});

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _waveController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _particleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _waveController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ColorsManager.getScaffoldBackground(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Animated App Bar with Custom Paint
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20.sp,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: ColorsManager.error,
                    size: 20.sp,
                  ),
                ),
                onPressed: () {
                  _showDeleteDialog(context);
                },
              ),
              SizedBox(width: 8.w),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  // Gradient Background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorsManager.getSecondaryGreen(context),
                          ColorsManager.getSecondaryGreen(context),
                        ],
                      ),
                    ),
                  ),

                  // Animated Wave
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _waveController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: AnimatedWavePainter(
                            animationValue: _waveController.value,
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        );
                      },
                    ),
                  ),

                  // Floating Particles
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _particleController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: FloatingParticlesPainter(
                            animationValue: _particleController.value,
                            particleColor: Colors.white.withValues(alpha: 0.3),
                          ),
                        );
                      },
                    ),
                  ),

                  // Centered Icon with pulse animation
                  Center(
                    child: AnimatedBuilder(
                      animation: _particleController,
                      builder: (context, child) {
                        final scale =
                            1.0 +
                            (math.sin(_particleController.value * 2 * math.pi) *
                                0.1);
                        return Transform.scale(
                          scale: scale,
                          child: Hero(
                            tag: 'notification_${widget.notification.id}',
                            child: Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: NotificationTypeIcon(
                                type: widget.notification.type,
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

          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Type Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.getPrimaryGreen(
                            context,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          widget.notification.type.displayName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryGreen(context),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Title
                      Text(
                        widget.notification.title,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Timestamp
                      Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            size: 16.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            timeago.format(widget.notification.createdAtUtc),
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          if (!widget.notification.isRead)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: ColorsManager.getPrimaryGreen(context),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Divider
                      Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ColorsManager.getBorderColor(
                                context,
                              ).withValues(alpha: 0),
                              ColorsManager.getBorderColor(context),
                              ColorsManager.getBorderColor(
                                context,
                              ).withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Body Content
                      Text(
                        widget.notification.body,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorsManager.getPrimaryText(context),
                          height: 1.6,
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Additional Data (if available)
                      if (widget.notification.data != null &&
                          widget.notification.data!.isNotEmpty) ...[
                        Text(
                          s.additional_info,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: ColorsManager.getCardBackground(context),
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: isDark
                                  ? ColorsManager.darkBorder
                                  : ColorsManager.lightBorder,
                            ),
                          ),
                          child: Column(
                            children: widget.notification.data!.entries
                                .map(
                                  (entry) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            entry.key,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  ColorsManager.getSecondaryText(
                                                    context,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            entry.value,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color:
                                                  ColorsManager.getPrimaryText(
                                                    context,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],

                      // Action Button (if not read)
                      if (!widget.notification.isRead)
                        SizedBox(
                          width: double.infinity,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: ColorsManager.getButtonGradient(
                                context,
                              ),
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsManager.getPrimaryGreen(
                                    context,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  context.read<NotificationsCubit>().markAsRead(
                                    widget.notification.id,
                                  );
                                  setState(() {});
                                },
                                borderRadius: BorderRadius.circular(16.r),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.done,
                                        color: Colors.white,
                                        size: 22.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        s.mark_as_read,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final s = S.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: ColorsManager.getCardBackground(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Text(
          s.delete_notification,
          style: TextStyle(
            color: ColorsManager.getPrimaryText(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          s.delete_notification_confirmation,
          style: TextStyle(color: ColorsManager.getSecondaryText(context)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              s.cancel,
              style: TextStyle(color: ColorsManager.getSecondaryText(context)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<NotificationsCubit>().deleteNotification(
                widget.notification.id,
              );
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(s.delete, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Animated Wave Painter
class AnimatedWavePainter extends CustomPainter {
  final double animationValue;
  final Color color;

  AnimatedWavePainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    path.moveTo(0, size.height * 0.7);

    for (double i = 0; i <= size.width; i += 5) {
      final normalizedX = i / size.width;
      final y =
          size.height * 0.7 +
          math.sin(
                (normalizedX * 3 * math.pi) + (animationValue * 2 * math.pi),
              ) *
              15;
      path.lineTo(i, y);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(AnimatedWavePainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}

// Floating Particles Painter
class FloatingParticlesPainter extends CustomPainter {
  final double animationValue;
  final Color particleColor;

  FloatingParticlesPainter({
    required this.animationValue,
    required this.particleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = particleColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 15; i++) {
      final progress = (animationValue + (i * 0.1)) % 1.0;
      final x = (size.width / 15) * i;
      final y = size.height * progress;
      final opacity = 1.0 - progress;

      paint.color = particleColor.withValues(alpha: opacity * 0.5);
      canvas.drawCircle(Offset(x, y), 3, paint);
    }
  }

  @override
  bool shouldRepaint(FloatingParticlesPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}

// Custom Painter for Header Background
class NotificationHeaderPainter extends CustomPainter {
  final Color primaryColor;

  NotificationHeaderPainter({required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Draw decorative circles
    for (int i = 0; i < 5; i++) {
      final radius = 30.0 + (i * 20);
      final opacity = 0.1 - (i * 0.015);

      paint.color = Colors.white.withValues(alpha: opacity);

      canvas.drawCircle(
        Offset(size.width * 0.2, size.height * 0.3),
        radius,
        paint,
      );

      canvas.drawCircle(
        Offset(size.width * 0.8, size.height * 0.7),
        radius * 0.7,
        paint,
      );
    }

    // Draw wave pattern
    final path = Path();
    path.moveTo(0, size.height * 0.7);

    for (double i = 0; i <= size.width; i += 20) {
      path.lineTo(i, size.height * 0.7 + math.sin(i * 0.02) * 10);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    paint.color = primaryColor.withValues(alpha: 0.1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NotificationHeaderPainter oldDelegate) => false;
}
