import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/cubit/theme_cubit.dart';
import '../../../../../core/theming/cubit/theme_state.dart';
import '../../../../../generated/l10n.dart';

// class ThemeSelectorSheet extends StatefulWidget {
//   const ThemeSelectorSheet({super.key});
//
//   @override
//   State<ThemeSelectorSheet> createState() => _ThemeSelectorSheetState();
// }
//
// class _ThemeSelectorSheetState extends State<ThemeSelectorSheet>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _slideAnimation;
//   bool _showCatAnimation = false; // ✅ Track if showing cat
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//
//     _scaleAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeOutBack,
//     );
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.1),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
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
//   // ✅ Show cat animation and switch theme
//   void _handleThemeChange(BuildContext context, AppThemeMode themeMode) {
//     if (themeMode == AppThemeMode.dark) {
//       setState(() => _showCatAnimation = true);
//
//       // Wait for GIF to play (2 seconds) then apply theme
//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) {
//           context.read<ThemeCubit>().setTheme(themeMode);
//           Future.delayed(const Duration(milliseconds: 300), () {
//             if (context.mounted) Navigator.pop(context);
//           });
//         }
//       });
//     } else {
//       // For light/system, switch immediately
//       context.read<ThemeCubit>().setTheme(themeMode);
//       Future.delayed(const Duration(milliseconds: 300), () {
//         if (context.mounted) Navigator.pop(context);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Stack(
//       children: [
//         // Main content
//         SlideTransition(
//           position: _slideAnimation,
//           child: ScaleTransition(
//             scale: _scaleAnimation,
//             child: Container(
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).padding.top + 100.h,
//               ),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).scaffoldBackgroundColor,
//                 borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Drag Handle
//                   Container(
//                     margin: EdgeInsets.only(top: 12.h),
//                     width: 40.w,
//                     height: 4.h,
//                     decoration: BoxDecoration(
//                       color: ColorsManager.getSecondaryText(
//                         context,
//                       ).withValues(alpha: 0.3),
//                       borderRadius: BorderRadius.circular(2.r),
//                     ),
//                   ),
//
//                   // Header
//                   Padding(
//                     padding: EdgeInsets.all(20.w),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.all(12.w),
//                           decoration: BoxDecoration(
//                             gradient: isDark
//                                 ? LinearGradient(
//                                     colors: [
//                                       ColorsManager.darkPrimaryGreen,
//                                       ColorsManager.darkSecondaryGreen,
//                                     ],
//                                   )
//                                 : ColorsManager.primaryGradient,
//                             borderRadius: BorderRadius.circular(12.r),
//                           ),
//                           child: Icon(
//                             Icons.palette_outlined,
//                             color: isDark
//                                 ? ColorsManager.darkScaffold
//                                 : Colors.white,
//                             size: 24.sp,
//                           ),
//                         ),
//                         SizedBox(width: 16.w),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 s.theme,
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: ColorsManager.getPrimaryText(context),
//                                 ),
//                               ),
//                               Text(
//                                 s.choose_your_theme,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   color: ColorsManager.getSecondaryText(
//                                     context,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // Theme Options
//                   BlocBuilder<ThemeCubit, ThemeState>(
//                     builder: (context, state) {
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: Column(
//                           children: [
//                             _buildThemeOption(
//                               context: context,
//                               icon: Icons.light_mode,
//                               title: s.light_theme,
//                               description: s.light_theme_desc,
//                               themeMode: AppThemeMode.light,
//                               isSelected:
//                                   state.appThemeMode == AppThemeMode.light,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.orange.shade300,
//                                   Colors.yellow.shade400,
//                                 ],
//                               ),
//                               index: 0,
//                             ),
//                             SizedBox(height: 12.h),
//                             _buildThemeOption(
//                               context: context,
//                               icon: Icons.dark_mode,
//                               title: s.dark_theme,
//                               description: s.dark_theme_desc,
//                               themeMode: AppThemeMode.dark,
//                               isSelected:
//                                   state.appThemeMode == AppThemeMode.dark,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.indigo.shade400,
//                                   Colors.purple.shade600,
//                                 ],
//                               ),
//                               index: 1,
//                             ),
//                             SizedBox(height: 12.h),
//                             _buildThemeOption(
//                               context: context,
//                               icon: Icons.brightness_auto,
//                               title: s.system_theme,
//                               description: s.system_theme_desc,
//                               themeMode: AppThemeMode.system,
//                               isSelected:
//                                   state.appThemeMode == AppThemeMode.system,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   ColorsManager.primaryGreen,
//                                   ColorsManager.secondaryGreen,
//                                 ],
//                               ),
//                               index: 2,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//
//                   SizedBox(height: 24.h),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         // ✅ Cat Animation Overlay
//         if (_showCatAnimation)
//           Positioned.fill(
//             child: Container(
//               color: Colors.black.withValues(alpha: 0.95),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(20.r),
//                       child: Image.asset(
//                         'assets/images/cats_turn_off_light.gif',
//                         width: 250.w,
//                         height: 250.h,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     Text(
//                       '🌙 Switching to Dark Mode...',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildThemeOption({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String description,
//     required AppThemeMode themeMode,
//     required bool isSelected,
//     required Gradient gradient,
//     required int index,
//   }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(milliseconds: 400 + (index * 100)),
//       curve: Curves.easeOut,
//       builder: (context, value, child) {
//         return Transform.translate(
//           offset: Offset(20 * (1 - value), 0),
//           child: Opacity(
//             opacity: value,
//             child: InkWell(
//               onTap: () =>
//                   _handleThemeChange(context, themeMode), // ✅ Use new handler
//               borderRadius: BorderRadius.circular(16.r),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 padding: EdgeInsets.all(16.w),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardTheme.color,
//                   borderRadius: BorderRadius.circular(16.r),
//                   border: Border.all(
//                     color: isSelected
//                         ? ColorsManager.getPrimaryGreen(context)
//                         : (isDark
//                               ? ColorsManager.darkBorder
//                               : ColorsManager.lightBorder),
//                     width: isSelected ? 2 : 1,
//                   ),
//                   boxShadow: isSelected
//                       ? [
//                           BoxShadow(
//                             color: ColorsManager.getPrimaryGreen(
//                               context,
//                             ).withValues(alpha: 0.3),
//                             blurRadius: 12,
//                             offset: const Offset(0, 4),
//                           ),
//                         ]
//                       : [
//                           BoxShadow(
//                             color: isDark
//                                 ? Colors.black.withValues(alpha: 0.3)
//                                 : Colors.black.withValues(alpha: 0.08),
//                             blurRadius: 8,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                 ),
//                 child: Row(
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       padding: EdgeInsets.all(12.w),
//                       decoration: BoxDecoration(
//                         gradient: isSelected ? gradient : null,
//                         color: isSelected
//                             ? null
//                             : (isDark
//                                   ? ColorsManager.darkInputBackground
//                                   : ColorsManager.grey200),
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: Icon(
//                         icon,
//                         color: isSelected
//                             ? Colors.white
//                             : ColorsManager.getSecondaryText(context),
//                         size: 28.sp,
//                       ),
//                     ),
//                     SizedBox(width: 16.w),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             title,
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               color: isSelected
//                                   ? ColorsManager.getPrimaryGreen(context)
//                                   : ColorsManager.getPrimaryText(context),
//                             ),
//                           ),
//                           SizedBox(height: 4.h),
//                           Text(
//                             description,
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: ColorsManager.getSecondaryText(context),
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                     AnimatedScale(
//                       scale: isSelected ? 1.0 : 0.0,
//                       duration: const Duration(milliseconds: 300),
//                       child: Icon(
//                         Icons.check_circle,
//                         color: ColorsManager.getPrimaryGreen(context),
//                         size: 28.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class ThemeSelectorSheet extends StatefulWidget {
  const ThemeSelectorSheet({super.key});

  @override
  State<ThemeSelectorSheet> createState() => _ThemeSelectorSheetState();
}

class _ThemeSelectorSheetState extends State<ThemeSelectorSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  bool _showCatAnimation = false;
  String _catGifPath = '';
  String _animationText = '';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleThemeChange(BuildContext context, AppThemeMode themeMode) {
    if (themeMode == AppThemeMode.dark) {
      setState(() {
        _showCatAnimation = true;
        _catGifPath = 'assets/images/cats_turn_off_light.gif';
        _animationText = '🌙 Switching to Dark Mode...';
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.read<ThemeCubit>().setTheme(themeMode);
          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) Navigator.pop(context);
          });
        }
      });
    } else if (themeMode == AppThemeMode.light) {
      setState(() {
        _showCatAnimation = true;
        _catGifPath = 'assets/images/cat_turn_on_ligh.gif';
        _animationText = '☀️ Switching to Light Mode...';
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.read<ThemeCubit>().setTheme(themeMode);
          Future.delayed(const Duration(milliseconds: 300), () {
            if (context.mounted) Navigator.pop(context);
          });
        }
      });
    } else {
      // System mode - no animation
      context.read<ThemeCubit>().setTheme(themeMode);
      Future.delayed(const Duration(milliseconds: 300), () {
        if (context.mounted) Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Main content
        SlideTransition(
          position: _slideAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 100.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Drag Handle
                  Container(
                    margin: EdgeInsets.only(top: 12.h),
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.getSecondaryText(
                        context,
                      ).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            gradient: isDark
                                ? LinearGradient(
                                    colors: [
                                      ColorsManager.darkPrimaryGreen,
                                      ColorsManager.darkSecondaryGreen,
                                    ],
                                  )
                                : ColorsManager.primaryGradient,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.palette_outlined,
                            color: isDark
                                ? ColorsManager.darkScaffold
                                : Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.theme,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.getPrimaryText(context),
                                ),
                              ),
                              Text(
                                s.choose_your_theme,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsManager.getSecondaryText(
                                    context,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Theme Options
                  BlocBuilder<ThemeCubit, ThemeState>(
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            _buildThemeOption(
                              context: context,
                              icon: Icons.light_mode,
                              title: s.light_theme,
                              description: s.light_theme_desc,
                              themeMode: AppThemeMode.light,
                              isSelected:
                                  state.appThemeMode == AppThemeMode.light,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.orange.shade300,
                                  Colors.yellow.shade400,
                                ],
                              ),
                              index: 0,
                            ),
                            SizedBox(height: 12.h),
                            _buildThemeOption(
                              context: context,
                              icon: Icons.dark_mode,
                              title: s.dark_theme,
                              description: s.dark_theme_desc,
                              themeMode: AppThemeMode.dark,
                              isSelected:
                                  state.appThemeMode == AppThemeMode.dark,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.indigo.shade400,
                                  Colors.purple.shade600,
                                ],
                              ),
                              index: 1,
                            ),
                            SizedBox(height: 12.h),
                            _buildThemeOption(
                              context: context,
                              icon: Icons.brightness_auto,
                              title: s.system_theme,
                              description: s.system_theme_desc,
                              themeMode: AppThemeMode.system,
                              isSelected:
                                  state.appThemeMode == AppThemeMode.system,
                              gradient: LinearGradient(
                                colors: [
                                  ColorsManager.primaryGreen,
                                  ColorsManager.secondaryGreen,
                                ],
                              ),
                              index: 2,
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),

        // Cat Animation Overlay
        if (_showCatAnimation)
          Positioned.fill(
            child: Container(
              color: _catGifPath.contains('turn_off')
                  ? Colors.black.withValues(alpha: 0.95)
                  : Colors.white.withValues(alpha: 0.95),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.asset(
                        _catGifPath,
                        width: 250.w,
                        height: 250.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      _animationText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _catGifPath.contains('turn_off')
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    required AppThemeMode themeMode,
    required bool isSelected,
    required Gradient gradient,
    required int index,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(20 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: InkWell(
              onTap: () => _handleThemeChange(context, themeMode),
              borderRadius: BorderRadius.circular(16.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? ColorsManager.getPrimaryGreen(context)
                        : (isDark
                              ? ColorsManager.darkBorder
                              : ColorsManager.lightBorder),
                    width: isSelected ? 2 : 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withValues(alpha: 0.3)
                                : Colors.black.withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        gradient: isSelected ? gradient : null,
                        color: isSelected
                            ? null
                            : (isDark
                                  ? ColorsManager.darkInputBackground
                                  : ColorsManager.grey200),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        icon,
                        color: isSelected
                            ? Colors.white
                            : ColorsManager.getSecondaryText(context),
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? ColorsManager.getPrimaryGreen(context)
                                  : ColorsManager.getPrimaryText(context),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            description,
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    AnimatedScale(
                      scale: isSelected ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 300),
                      child: Icon(
                        Icons.check_circle,
                        color: ColorsManager.getPrimaryGreen(context),
                        size: 28.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
