import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';

class AnimatedChatFAB extends StatefulWidget {
  final int? unreadCount;

  const AnimatedChatFAB({super.key, this.unreadCount});

  @override
  State<AnimatedChatFAB> createState() => _AnimatedChatFABState();
}

class _AnimatedChatFABState extends State<AnimatedChatFAB>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Scale animation for entrance
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Pulse animation for attention
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasUnread = widget.unreadCount != null && widget.unreadCount! > 0;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          // return Transform.scale(
          //   scale: hasUnread ? _pulseAnimation.value : 1.0,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: ColorsManager.getPrimaryGreen(
          //             context,
          //           ).withValues(alpha: 0.4),
          //           blurRadius: 15,
          //           spreadRadius: 3,
          //         ),
          //       ],
          //     ),
          //     child: FloatingActionButton.large(
          //       heroTag: 'chat_fab',
          //       onPressed: () {
          //         Navigator.pushNamed(context, Routes.conversations);
          //       },
          //       backgroundColor: ColorsManager.getPrimaryGreen(context),
          //       elevation: 8,
          //       child: Stack(
          //         clipBehavior: Clip.none,
          //         children: [
          //           // Lottie Animation
          //           Lottie.asset(
          //             'assets/images/chat.json',
          //             width: 40.w,
          //             height: 40.w,
          //             fit: BoxFit.contain,
          //           ),
          //
          //           // Unread Badge
          //           if (hasUnread)
          //             Positioned(
          //               top: -8.h,
          //               right: -8.w,
          //               child: Container(
          //                 padding: EdgeInsets.all(6.w),
          //                 decoration: BoxDecoration(
          //                   color: ColorsManager.error,
          //                   shape: BoxShape.circle,
          //                   border: Border.all(
          //                     color: isDark
          //                         ? ColorsManager.darkScaffold
          //                         : Colors.white,
          //                     width: 2,
          //                   ),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: ColorsManager.error.withValues(
          //                         alpha: 0.5,
          //                       ),
          //                       blurRadius: 8,
          //                       spreadRadius: 1,
          //                     ),
          //                   ],
          //                 ),
          //                 constraints: BoxConstraints(
          //                   minWidth: 22.w,
          //                   minHeight: 22.w,
          //                 ),
          //                 child: Text(
          //                   widget.unreadCount! > 9
          //                       ? '9+'
          //                       : '${widget.unreadCount}',
          //                   style: TextStyle(
          //                     fontSize: 10.sp,
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                   textAlign: TextAlign.center,
          //                 ),
          //               ),
          //             ),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
          return InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.conversations);
            },
            child: SizedBox(
              width: 90.w,
              height: 90.w,
              child: Lottie.asset(
                'assets/images/chat.json',
                width: 40.w,
                height: 40.w,
                fit: BoxFit.contain,
              ),
            ),
          );
        },
      ),
    );
  }
}
