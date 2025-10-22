import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:confetti/confetti.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'dart:math';
import '../../../../core/services/sound_service.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/helpers/celebration_prefs.dart';
import '../../../../generated/l10n.dart';

// class CelebrationOverlay extends StatefulWidget {
//   final String message;
//   final double progressPercent;
//   final VoidCallback onDismiss;
//
//   const CelebrationOverlay({
//     super.key,
//     required this.message,
//     required this.progressPercent,
//     required this.onDismiss,
//   });
//
//   @override
//   State<CelebrationOverlay> createState() => _CelebrationOverlayState();
// }
//
// class _CelebrationOverlayState extends State<CelebrationOverlay>
//     with SingleTickerProviderStateMixin {
//   late ConfettiController _confettiController;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _slideAnimation;
//
//   bool _dontShowAgain = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Confetti controller
//     _confettiController = ConfettiController(
//       duration: const Duration(seconds: 3),
//     );
//
//     // Animation controller
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );
//
//     // Enhanced animations
//     _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
//       ),
//     );
//
//     _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
//       ),
//     );
//
//     // Play celebration effects
//     _playSound();
//     HapticFeedback.mediumImpact();
//
//     // Start animations
//     _animationController.forward();
//     _confettiController.play();
//
//     // Auto dismiss after 6 seconds
//     Future.delayed(const Duration(seconds: 6), () {
//       if (mounted) {
//         _dismiss();
//       }
//     });
//   }
//
//   Future<void> _playSound() async {
//     await SoundService.instance.playSound(
//       'assets/sounds/celebrate.mp3',
//       volume: 0.7,
//     );
//   }
//
//   @override
//   void dispose() {
//     _confettiController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _dismiss() async {
//     // Save preference if user checked "don't show again"
//     if (_dontShowAgain) {
//       await CelebrationPrefs.setCelebrationDisabled(true);
//     }
//
//     await _animationController.reverse();
//     widget.onDismiss();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isArabic = Localizations.localeOf(context).languageCode == 'ar';
//
//     return Material(
//       color: Colors.transparent,
//       child: Stack(
//         children: [
//           // Dark overlay background
//           GestureDetector(
//             onTap: _dismiss,
//             child: AnimatedBuilder(
//               animation: _fadeAnimation,
//               builder: (context, child) {
//                 return Container(
//                   color: Colors.black.withValues(
//                     alpha: 0.7 * _fadeAnimation.value,
//                   ),
//                 );
//               },
//             ),
//           ),
//
//           // Confetti animations
//           _buildConfetti(Alignment.topCenter, pi * 1.5),
//           _buildConfetti(Alignment.topLeft, pi * 1.75),
//           _buildConfetti(Alignment.topRight, pi * 1.25),
//
//           // Celebration card
//           Center(
//             child: AnimatedBuilder(
//               animation: _animationController,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _scaleAnimation.value,
//                   child: Transform.translate(
//                     offset: Offset(0, _slideAnimation.value),
//                     child: Opacity(opacity: _fadeAnimation.value, child: child),
//                   ),
//                 );
//               },
//               child: _buildCelebrationCard(s, isArabic),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildConfetti(Alignment alignment, double blastDirection) {
//     return Align(
//       alignment: alignment,
//       child: ConfettiWidget(
//         confettiController: _confettiController,
//         blastDirection: blastDirection,
//         particleDrag: 0.05,
//         emissionFrequency: 0.05,
//         numberOfParticles: 25,
//         gravity: 0.2,
//         shouldLoop: false,
//         colors: const [
//           ColorsManager.primaryGreen,
//           ColorsManager.secondaryGreen,
//           ColorsManager.warning,
//           ColorsManager.info,
//           ColorsManager.success,
//         ],
//         strokeWidth: 2,
//         strokeColor: Colors.white,
//       ),
//     );
//   }
//
//   Widget _buildCelebrationCard(S s, bool isArabic) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 32.w),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(28.r),
//         boxShadow: [
//           BoxShadow(
//             color: ColorsManager.primaryGreen.withValues(alpha: 0.6),
//             blurRadius: 40,
//             offset: const Offset(0, 15),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(28.r),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Top section with icon and message
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.all(32.w),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.white.withValues(alpha: 0.1),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   // Animated icon with glow effect
//                   TweenAnimationBuilder<double>(
//                     tween: Tween(begin: 0.0, end: 1.0),
//                     duration: const Duration(milliseconds: 800),
//                     curve: Curves.elasticOut,
//                     builder: (context, value, child) {
//                       return Transform.scale(
//                         scale: 0.5 + (value * 0.5),
//                         child: Container(
//                           padding: EdgeInsets.all(24.w),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withValues(alpha: 0.25),
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.white.withValues(
//                                   alpha: 0.4 * value,
//                                 ),
//                                 blurRadius: 30 * value,
//                                 spreadRadius: 10 * value,
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             _getIcon(),
//                             size: 64.sp,
//                             color: Colors.white,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(height: 24.h),
//
//                   // Message
//                   Text(
//                     widget.message,
//                     style: TextStyles.font24WhiteBold.copyWith(
//                       fontSize: 22.sp,
//                       height: 1.3,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   SizedBox(height: 16.h),
//
//                   // Progress percentage with animated circular progress
//                   _buildProgressIndicator(s),
//                 ],
//               ),
//             ),
//
//             // Bottom section with checkbox and button
//             Container(
//               padding: EdgeInsets.all(24.w),
//               decoration: BoxDecoration(
//                 color: Colors.black.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(28.r),
//                   bottomRight: Radius.circular(28.r),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   // Don't show again checkbox
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _dontShowAgain = !_dontShowAgain;
//                       });
//                       HapticFeedback.lightImpact();
//                     },
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 16.w,
//                         vertical: 12.h,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withValues(alpha: 0.1),
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 200),
//                             width: 24.w,
//                             height: 24.h,
//                             decoration: BoxDecoration(
//                               color: _dontShowAgain
//                                   ? Colors.white
//                                   : Colors.transparent,
//                               borderRadius: BorderRadius.circular(6.r),
//                               border: Border.all(color: Colors.white, width: 2),
//                             ),
//                             child: _dontShowAgain
//                                 ? Icon(
//                                     Icons.check,
//                                     size: 16.sp,
//                                     color: ColorsManager.primaryGreen,
//                                   )
//                                 : null,
//                           ),
//                           SizedBox(width: 12.w),
//                           Text(
//                             s.dont_show_again,
//                             style: TextStyles.font14WhiteMedium.copyWith(
//                               color: Colors.white.withValues(alpha: 0.9),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//
//                   // Continue button
//                   GestureDetector(
//                     onTap: () {
//                       HapticFeedback.lightImpact();
//                       _dismiss();
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.symmetric(vertical: 16.h),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withValues(alpha: 0.2),
//                             blurRadius: 10,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         s.continue_text,
//                         style: TextStyles.font16PrimaryGreenRegular.copyWith(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 18.sp,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProgressIndicator(S s) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.white.withValues(alpha: 0.15),
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           TweenAnimationBuilder<double>(
//             tween: Tween(begin: 0.0, end: widget.progressPercent / 100),
//             duration: const Duration(milliseconds: 1500),
//             curve: Curves.easeOutCubic,
//             builder: (context, value, child) {
//               return SizedBox(
//                 width: 40.w,
//                 height: 40.h,
//                 child: CircularProgressIndicator(
//                   value: value,
//                   backgroundColor: Colors.white.withValues(alpha: 0.2),
//                   valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                   strokeWidth: 4,
//                 ),
//               );
//             },
//           ),
//           SizedBox(width: 16.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 '${widget.progressPercent.toStringAsFixed(0)}%',
//                 style: TextStyles.font20WhiteBold.copyWith(fontSize: 24.sp),
//               ),
//               Text(
//                 s.complete,
//                 style: TextStyles.font14WhiteMedium.copyWith(
//                   color: Colors.white.withValues(alpha: 0.8),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getIcon() {
//     if (widget.progressPercent >= 100) {
//       return Icons.emoji_events;
//     } else if (widget.progressPercent >= 75) {
//       return Icons.local_fire_department;
//     } else if (widget.progressPercent >= 50) {
//       return Icons.star;
//     } else if (widget.progressPercent >= 25) {
//       return Icons.stars;
//     }
//     return Icons.celebration;
//   }
// }
class CelebrationOverlay extends StatefulWidget {
  final String message;
  final double progressPercent;
  final VoidCallback onDismiss;

  const CelebrationOverlay({
    super.key,
    required this.message,
    required this.progressPercent,
    required this.onDismiss,
  });

  @override
  State<CelebrationOverlay> createState() => _CelebrationOverlayState();
}

class _CelebrationOverlayState extends State<CelebrationOverlay>
    with SingleTickerProviderStateMixin {
  late ConfettiController _confettiController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  bool _dontShowAgain = false;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _playSound();
    HapticFeedback.mediumImpact();

    _animationController.forward();
    _confettiController.play();

    Future.delayed(const Duration(seconds: 6), () {
      if (mounted) _dismiss();
    });
  }

  Future<void> _playSound() async {
    await SoundService.instance.playSound(
      'assets/sounds/celebrate.mp3',
      volume: 0.7,
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _dismiss() async {
    if (_dontShowAgain) {
      await CelebrationPrefs.setCelebrationDisabled(true);
    }

    await _animationController.reverse();
    widget.onDismiss();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: _dismiss,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Container(
                  color: Colors.black.withValues(
                    alpha: 0.7 * _fadeAnimation.value,
                  ),
                );
              },
            ),
          ),
          _buildConfetti(Alignment.topCenter, pi * 1.5),
          _buildConfetti(Alignment.topLeft, pi * 1.75),
          _buildConfetti(Alignment.topRight, pi * 1.25),
          Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Opacity(opacity: _fadeAnimation.value, child: child),
                  ),
                );
              },
              child: _buildCelebrationCard(s, isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfetti(Alignment alignment, double blastDirection) {
    return Align(
      alignment: alignment,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirection: blastDirection,
        particleDrag: 0.05,
        emissionFrequency: 0.05,
        numberOfParticles: 25,
        gravity: 0.2,
        shouldLoop: false,
        colors: const [
          ColorsManager.primaryGreen,
          ColorsManager.secondaryGreen,
          ColorsManager.warning,
          ColorsManager.info,
          ColorsManager.success,
        ],
        strokeWidth: 2,
        strokeColor: Colors.white,
      ),
    );
  }

  Widget _buildCelebrationCard(S s, bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                ]
              : [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color:
                (isDark
                        ? ColorsManager.darkPrimaryGreen
                        : ColorsManager.primaryGreen)
                    .withValues(alpha: 0.6),
            blurRadius: 40,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: 0.5 + (value * 0.5),
                        child: Container(
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(
                              alpha: isDark ? 0.2 : 0.25,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withValues(
                                  alpha: 0.4 * value,
                                ),
                                blurRadius: 30 * value,
                                spreadRadius: 10 * value,
                              ),
                            ],
                          ),
                          child: Icon(
                            _getIcon(),
                            size: 64.sp,
                            color: isDark
                                ? ColorsManager.darkScaffold
                                : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    widget.message,
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark ? ColorsManager.darkScaffold : Colors.white,
                      height: 1.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  _buildProgressIndicator(s, isDark),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: isDark ? 0.15 : 0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28.r),
                  bottomRight: Radius.circular(28.r),
                ),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() => _dontShowAgain = !_dontShowAgain);
                      HapticFeedback.lightImpact();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: isDark ? 0.08 : 0.1,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: _dontShowAgain
                                  ? (isDark
                                        ? ColorsManager.darkScaffold
                                        : Colors.white)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: isDark
                                    ? ColorsManager.darkScaffold
                                    : Colors.white,
                                width: 2,
                              ),
                            ),
                            child: _dontShowAgain
                                ? Icon(
                                    Icons.check,
                                    size: 16.sp,
                                    color: isDark
                                        ? Colors.white
                                        : ColorsManager.primaryGreen,
                                  )
                                : null,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            s.dont_show_again,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color:
                                  (isDark
                                          ? ColorsManager.darkScaffold
                                          : Colors.white)
                                      .withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _dismiss();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: isDark
                            ? ColorsManager.darkScaffold
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        s.continue_text,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? Colors.white
                              : ColorsManager.primaryGreen,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(S s, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: isDark ? 0.12 : 0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: widget.progressPercent / 100),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return SizedBox(
                width: 40.w,
                height: 40.h,
                child: CircularProgressIndicator(
                  value: value,
                  backgroundColor:
                      (isDark ? ColorsManager.darkScaffold : Colors.white)
                          .withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark ? ColorsManager.darkScaffold : Colors.white,
                  ),
                  strokeWidth: 4,
                ),
              );
            },
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.progressPercent.toStringAsFixed(0)}%',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ColorsManager.darkScaffold : Colors.white,
                ),
              ),
              Text(
                s.complete,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                      .withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    if (widget.progressPercent >= 100) return Icons.emoji_events;
    if (widget.progressPercent >= 75) return Icons.local_fire_department;
    if (widget.progressPercent >= 50) return Icons.star;
    if (widget.progressPercent >= 25) return Icons.stars;
    return Icons.celebration;
  }
}
