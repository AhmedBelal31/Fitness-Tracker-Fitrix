import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:confetti/confetti.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'dart:math';

import '../../../../core/theming/app_colors.dart';

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
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: const Interval(0.0, 0.5),
//       ),
//     );
//
//     // Start animations
//     _animationController.forward();
//     _confettiController.play();
//
//     HapticFeedback.mediumImpact();
//
//     // Auto dismiss after 4 seconds
//     Future.delayed(const Duration(seconds: 4), () {
//       if (mounted) {
//         _dismiss();
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _confettiController.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   void _dismiss() {
//     _animationController.reverse().then((_) {
//       widget.onDismiss();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//                   color: Colors.black.withOpacity(0.6 * _fadeAnimation.value),
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
//               animation: _scaleAnimation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _scaleAnimation.value,
//                   child: child,
//                 );
//               },
//               child: _buildCelebrationCard(),
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
//         numberOfParticles: 20,
//         gravity: 0.2,
//         shouldLoop: false,
//         colors: [
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
//   Widget _buildCelebrationCard() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 40.w),
//       padding: EdgeInsets.all(32.w),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24.r),
//         boxShadow: [
//           BoxShadow(
//             color: ColorsManager.primaryGreen.withOpacity(0.5),
//             blurRadius: 30,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Trophy/Star Icon
//           Container(
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(_getIcon(), size: 60.sp, color: Colors.white),
//           ),
//           SizedBox(height: 20.h),
//
//           // Message
//           Text(
//             widget.message,
//             style: TextStyles.font24WhiteBold,
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 12.h),
//
//           // Progress percentage
//           Text(
//             '${widget.progressPercent.toStringAsFixed(0)}% Complete',
//             style: TextStyles.font18WhiteMedium.copyWith(
//               color: Colors.white.withOpacity(0.9),
//             ),
//           ),
//           SizedBox(height: 24.h),
//
//           // Continue button
//           GestureDetector(
//             onTap: _dismiss,
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30.r),
//               ),
//               child: Text(
//                 'Continue',
//                 style: TextStyles.font16PrimaryGreenRegular.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getIcon() {
//     if (widget.progressPercent >= 100) {
//       return Icons.emoji_events; // Trophy
//     } else if (widget.progressPercent >= 75) {
//       return Icons.local_fire_department; // Fire
//     } else if (widget.progressPercent >= 50) {
//       return Icons.star; // Star
//     }
//     return Icons.celebration;
//   }
// }

import 'package:just_audio/just_audio.dart';

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
  late AudioPlayer _audioPlayer; // ✅ just_audio player

  @override
  void initState() {
    super.initState();

    // ✅ Initialize audio player
    _audioPlayer = AudioPlayer();

    // Confetti controller
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    // Animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5),
      ),
    );

    // ✅ Play celebration sound
    _playSound();

    // ✅ Haptic feedback
    HapticFeedback.mediumImpact();

    // Start animations
    _animationController.forward();
    _confettiController.play();

    // Auto dismiss after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // ✅ Play celebration sound with just_audio
  Future<void> _playSound() async {
    try {
      // ✅ Correct path - just the relative path from assets folder
      await _audioPlayer.setAsset('assets/sounds/celebrate.mp3');
      await _audioPlayer.play();
      debugPrint('✅ Celebration sound playing');
    } catch (e) {
      // Sound failed to play, continue without it
      debugPrint('❌ Failed to play celebration sound: $e');
    }
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Dark overlay background
          GestureDetector(
            onTap: _dismiss,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Container(
                  color: Colors.black.withOpacity(0.6 * _fadeAnimation.value),
                );
              },
            ),
          ),

          // Confetti animations
          _buildConfetti(Alignment.topCenter, pi * 1.5),
          _buildConfetti(Alignment.topLeft, pi * 1.75),
          _buildConfetti(Alignment.topRight, pi * 1.25),

          // Celebration card
          Center(
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: child,
                );
              },
              child: _buildCelebrationCard(),
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
        numberOfParticles: 20,
        gravity: 0.2,
        shouldLoop: false,
        colors: [
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

  Widget _buildCelebrationCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryGreen.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Trophy/Star Icon
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(_getIcon(), size: 60.sp, color: Colors.white),
          ),
          SizedBox(height: 20.h),

          // Message
          Text(
            widget.message,
            style: TextStyles.font24WhiteBold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h),

          // Progress percentage
          Text(
            '${widget.progressPercent.toStringAsFixed(1)}% Complete',
            style: TextStyles.font18WhiteMedium.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 24.h),

          // Continue button
          GestureDetector(
            onTap: _dismiss,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text(
                'Continue',
                style: TextStyles.font16PrimaryGreenRegular.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    if (widget.progressPercent >= 100) {
      return Icons.emoji_events; // Trophy
    } else if (widget.progressPercent >= 75) {
      return Icons.local_fire_department; // Fire
    } else if (widget.progressPercent >= 50) {
      return Icons.star; // Star
    } else if (widget.progressPercent >= 25) {
      return Icons.stars; // Stars
    }
    return Icons.celebration; // Party popper
  }
}
