import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

// class QuickActionsCard extends StatelessWidget {
//   const QuickActionsCard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return TweenAnimationBuilder(
//       duration: const Duration(milliseconds: 600),
//       tween: Tween<double>(begin: 0, end: 1),
//       curve: Curves.easeOutBack,
//       builder: (context, double value, child) {
//         // ✅ Clamp the value to ensure it's within valid range
//         final clampedValue = value.clamp(0.0, 1.0);
//         return Transform.scale(
//           scale: 0.9 + (0.1 * clampedValue),
//           child: Opacity(opacity: clampedValue, child: child),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               ColorsManager.getPrimaryGreen(
//                 context,
//               ).withOpacity(isDark ? 0.15 : 0.08),
//               ColorsManager.getSecondaryGreen(
//                 context,
//               ).withOpacity(isDark ? 0.12 : 0.06),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(20.r),
//           border: Border.all(
//             color: ColorsManager.getPrimaryGreen(context).withOpacity(0.2),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: ColorsManager.getPrimaryGreen(context).withOpacity(0.1),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: () {
//               Navigator.pushNamed(context, Routes.userRequests);
//             },
//             borderRadius: BorderRadius.circular(20.r),
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//               child: Row(
//                 children: [
//                   // Icon Container
//                   Container(
//                     width: 56.w,
//                     height: 56.w,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         colors: [
//                           ColorsManager.getSecondaryGreen(context),
//                           ColorsManager.getPrimaryGreen(context),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(16.r),
//                       boxShadow: [
//                         BoxShadow(
//                           color: ColorsManager.getPrimaryGreen(
//                             context,
//                           ).withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: Icon(
//                       Icons.people_outline_rounded,
//                       color: Colors.white,
//                       size: 28.sp,
//                     ),
//                   ),
//
//                   SizedBox(width: 16.w),
//
//                   // Text Content
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           s.view_requests,
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             color: ColorsManager.getPrimaryText(context),
//                           ),
//                         ),
//                         SizedBox(height: 4.h),
//                         Text(
//                           'Manage your trainer requests',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: ColorsManager.getSecondaryText(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Arrow Icon
//                   Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       color: ColorsManager.getPrimaryGreen(
//                         context,
//                       ).withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: ColorsManager.getPrimaryGreen(context),
//                       size: 16.sp,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  Future<void> _navigateToRequests(BuildContext context) async {
    final isTrainer = await TokenManager.instance.isTrainer;

    if (isTrainer) {
      Navigator.pushNamed(context, Routes.trainerRequests);
    } else {
      Navigator.pushNamed(context, Routes.userRequests);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsManager.getPrimaryGreen(
              context,
            ).withOpacity(isDark ? 0.15 : 0.08),
            ColorsManager.getSecondaryGreen(
              context,
            ).withOpacity(isDark ? 0.12 : 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: ColorsManager.getPrimaryGreen(context).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToRequests(context),
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Row(
              children: [
                Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsManager.getSecondaryGreen(context),
                        ColorsManager.getPrimaryGreen(context),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(
                    Icons.people_outline_rounded,
                    color: Colors.white,
                    size: 28.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.view_requests,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Manage your trainer requests',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorsManager.getPrimaryGreen(context),
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
