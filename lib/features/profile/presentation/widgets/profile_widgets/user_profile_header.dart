import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

// class UserProfileHeader extends StatefulWidget {
//   const UserProfileHeader({super.key});
//
//   @override
//   State<UserProfileHeader> createState() => _UserProfileHeaderState();
// }
//
// class _UserProfileHeaderState extends State<UserProfileHeader>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
//
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     var profile = HiveService().getProfile();
//     String firstName = profile?.firstName ?? 'F';
//     String lastName = profile?.lastName ?? 'R';
//
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(20.w),
//         decoration: BoxDecoration(
//           gradient: isDark
//               ? LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     ColorsManager.darkPrimaryGreen,
//                     ColorsManager.darkSecondaryGreen,
//                   ],
//                 )
//               : ColorsManager.primaryGradient,
//           borderRadius: BorderRadius.circular(20.r),
//           boxShadow: [
//             BoxShadow(
//               color: ColorsManager.getPrimaryGreen(
//                 context,
//               ).withValues(alpha: 0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Container(
//               width: 100.w,
//               height: 100.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: isDark ? ColorsManager.darkScaffold : Colors.white,
//                   width: 4,
//                 ),
//                 color: isDark ? ColorsManager.darkScaffold : Colors.white,
//               ),
//               child: Center(
//                 child: Text(
//                   "${firstName.isNotEmpty ? firstName[0] : 'F'}.${lastName.isNotEmpty ? lastName[0] : 'R'}",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: ColorsManager.getPrimaryGreen(context),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16.h),
//             Text(
//               "$firstName $lastName",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: isDark ? ColorsManager.darkScaffold : Colors.white,
//               ),
//             ),
//             SizedBox(height: 16.h),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, Routes.updateProfileScreen);
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isDark
//                     ? ColorsManager.darkScaffold
//                     : Colors.white,
//                 foregroundColor: ColorsManager.getPrimaryGreen(context),
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.r),
//                 ),
//               ),
//               child: Text(
//                 s.edit_profile_and_measurements,
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:math' as math;

// class UserProfileHeader extends StatefulWidget {
//   const UserProfileHeader({super.key});
//
//   @override
//   State<UserProfileHeader> createState() => _UserProfileHeaderState();
// }
//
// class _UserProfileHeaderState extends State<UserProfileHeader>
//     with TickerProviderStateMixin {
//   late AnimationController _scaleController;
//   late AnimationController _waveController;
//   late AnimationController _rotationController;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _scaleController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _waveController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat();
//
//     _rotationController = AnimationController(
//       duration: const Duration(seconds: 10),
//       vsync: this,
//     )..repeat();
//
//     _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//       CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
//     );
//
//     _scaleController.forward();
//   }
//
//   @override
//   void dispose() {
//     _scaleController.dispose();
//     _waveController.dispose();
//     _rotationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     var profile = HiveService().getProfile();
//     String firstName = profile?.firstName ?? 'F';
//     String lastName = profile?.lastName ?? 'R';
//
//     return ScaleTransition(
//       scale: _scaleAnimation,
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(24.w),
//         decoration: BoxDecoration(
//           gradient: isDark
//               ? LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [
//                     ColorsManager.darkPrimaryGreen,
//                     ColorsManager.darkSecondaryGreen,
//                   ],
//                 )
//               : ColorsManager.primaryGradient,
//           borderRadius: BorderRadius.circular(24.r),
//           boxShadow: [
//             BoxShadow(
//               color: ColorsManager.getPrimaryGreen(
//                 context,
//               ).withValues(alpha: 0.4),
//               blurRadius: 30,
//               offset: const Offset(0, 12),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             AnimatedBuilder(
//               animation: _waveController,
//               builder: (context, child) {
//                 return CustomPaint(
//                   painter: _ProfileHeaderPainter(
//                     animation: _waveController.value,
//                     isDark: isDark,
//                   ),
//                   size: Size(double.infinity, 280.h),
//                 );
//               },
//             ),
//             Column(
//               children: [
//                 _buildAnimatedAvatar(firstName, lastName, isDark),
//                 SizedBox(height: 20.h),
//                 _buildNameWithShimmer(firstName, lastName, isDark),
//                 SizedBox(height: 20.h),
//                 _buildEditButton(s, isDark),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAnimatedAvatar(String firstName, String lastName, bool isDark) {
//     return AnimatedBuilder(
//       animation: _rotationController,
//       builder: (context, child) {
//         return Stack(
//           alignment: Alignment.center,
//           children: [
//             Transform.rotate(
//               angle: _rotationController.value * 2 * math.pi,
//               child: Container(
//                 width: 120.w,
//                 height: 120.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: (isDark ? ColorsManager.darkScaffold : Colors.white)
//                         .withValues(alpha: 0.3),
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//             Container(
//               width: 100.w,
//               height: 100.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isDark ? ColorsManager.darkScaffold : Colors.white,
//                 border: Border.all(
//                   color: isDark ? ColorsManager.darkScaffold : Colors.white,
//                   width: 4,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (isDark ? ColorsManager.darkScaffold : Colors.white)
//                         .withValues(alpha: 0.5),
//                     blurRadius: 20,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   "${firstName.isNotEmpty ? firstName[0] : 'F'}.${lastName.isNotEmpty ? lastName[0] : 'R'}",
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: ColorsManager.getPrimaryGreen(context),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildNameWithShimmer(String firstName, String lastName, bool isDark) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 1000),
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - value)),
//             child: child,
//           ),
//         );
//       },
//       child: Text(
//         "$firstName $lastName",
//         style: TextStyle(
//           fontSize: 26,
//           fontWeight: FontWeight.bold,
//           color: isDark ? ColorsManager.darkScaffold : Colors.white,
//           shadows: [
//             Shadow(
//               color: Colors.black.withValues(alpha: 0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEditButton(S s, bool isDark) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 1200),
//       builder: (context, value, child) {
//         return Transform.scale(scale: value, child: child);
//       },
//       child: ElevatedButton.icon(
//         onPressed: () {
//           Navigator.pushNamed(context, Routes.updateProfileScreen);
//         },
//         icon: Icon(
//           Icons.edit,
//           color: ColorsManager.getPrimaryGreen(context),
//           size: 18.sp,
//         ),
//         label: Text(
//           s.edit_profile_and_measurements,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: ColorsManager.getPrimaryGreen(context),
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: isDark ? ColorsManager.darkScaffold : Colors.white,
//           foregroundColor: ColorsManager.getPrimaryGreen(context),
//           padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           elevation: 8,
//           shadowColor: Colors.black.withValues(alpha: 0.3),
//         ),
//       ),
//     );
//   }
// }
//
// class _ProfileHeaderPainter extends CustomPainter {
//   final double animation;
//   final bool isDark;
//
//   const _ProfileHeaderPainter({required this.animation, required this.isDark});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final color = isDark ? ColorsManager.darkScaffold : Colors.white;
//
//     final wavePaint = Paint()
//       ..color = color.withValues(alpha: 0.08)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//
//     for (int i = 0; i < 3; i++) {
//       final path = Path();
//       final offset = animation * size.width;
//
//       for (double x = -size.width; x < size.width * 2; x += 10) {
//         final y =
//             size.height * 0.5 + math.sin((x + offset) / 50 + (i * 0.5)) * 20;
//         if (x == -size.width) {
//           path.moveTo(x, y);
//         } else {
//           path.lineTo(x, y);
//         }
//       }
//       canvas.drawPath(path, wavePaint);
//     }
//
//     final dotPaint = Paint()
//       ..color = color.withValues(alpha: 0.12)
//       ..style = PaintingStyle.fill;
//
//     for (double x = 30; x < size.width; x += 60) {
//       for (double y = 30; y < size.height; y += 60) {
//         final offset = math.sin(animation * 2 * math.pi + x / 40) * 3;
//         canvas.drawCircle(Offset(x, y + offset), 3, dotPaint);
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _ProfileHeaderPainter oldDelegate) {
//     return animation != oldDelegate.animation;
//   }
// }
class UserProfileHeader extends StatefulWidget {
  const UserProfileHeader({super.key});

  @override
  State<UserProfileHeader> createState() => _UserProfileHeaderState();
}

class _UserProfileHeaderState extends State<UserProfileHeader>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _waveController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _rotationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _scaleController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _waveController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var profile = HiveService().getProfile();
    String firstName = profile?.firstName ?? 'F';
    String lastName = profile?.lastName ?? 'R';

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          gradient: isDark
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorsManager.darkPrimaryGreen,
                    ColorsManager.darkSecondaryGreen,
                  ],
                )
              : ColorsManager.primaryGradient,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _waveController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ProfileHeaderPainter(
                    animation: _waveController.value,
                    isDark: isDark,
                  ),
                  size: Size(double.infinity, 160.h),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildAnimatedAvatar(firstName, lastName, isDark),
                  SizedBox(height: 10.h),
                  _buildNameWithShimmer(firstName, lastName, isDark),
                  SizedBox(height: 12.h),
                  _buildEditButton(s, isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedAvatar(String firstName, String lastName, bool isDark) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: _rotationController.value * 2 * math.pi,
              child: Container(
                width: 70.w,
                height: 70.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                        .withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? ColorsManager.darkScaffold : Colors.white,
                border: Border.all(
                  color: isDark ? ColorsManager.darkScaffold : Colors.white,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                        .withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "${firstName.isNotEmpty ? firstName[0] : 'F'}.${lastName.isNotEmpty ? lastName[0] : 'R'}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNameWithShimmer(String firstName, String lastName, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 10 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Text(
        "$firstName $lastName",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? ColorsManager.darkScaffold : Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildEditButton(S s, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, child) {
        return Transform.scale(scale: value, child: child);
      },
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, Routes.updateProfileScreen);
        },
        icon: Icon(
          Icons.edit,
          color: ColorsManager.getPrimaryGreen(context),
          size: 14.sp,
        ),
        label: Text(
          s.edit_profile_and_measurements,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ColorsManager.getPrimaryGreen(context),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? ColorsManager.darkScaffold : Colors.white,
          foregroundColor: ColorsManager.getPrimaryGreen(context),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}

class _ProfileHeaderPainter extends CustomPainter {
  final double animation;
  final bool isDark;

  const _ProfileHeaderPainter({required this.animation, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final color = isDark ? ColorsManager.darkScaffold : Colors.white;

    final wavePaint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 3; i++) {
      final path = Path();
      final offset = animation * size.width;

      for (double x = -size.width; x < size.width * 2; x += 10) {
        final y =
            size.height * 0.5 + math.sin((x + offset) / 50 + (i * 0.5)) * 20;
        if (x == -size.width) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, wavePaint);
    }

    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;

    for (double x = 30; x < size.width; x += 60) {
      for (double y = 30; y < size.height; y += 60) {
        final offset = math.sin(animation * 2 * math.pi + x / 40) * 3;
        canvas.drawCircle(Offset(x, y + offset), 3, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ProfileHeaderPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
