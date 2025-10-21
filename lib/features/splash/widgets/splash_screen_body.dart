import 'package:flutter/material.dart';
import '../../../core/theming/app_colors.dart';

// class SplashScreenBody extends StatelessWidget {
//   const SplashScreenBody({
//     super.key,
//     required AnimationController backgroundController,
//     required AnimationController logoController,
//     required AnimationController textController,
//     required AnimationController exitController,
//     required Animation<double> exitFadeAnimation,
//     required Animation<double> backgroundAnimation,
//     required Animation<double> logoFadeAnimation,
//     required Animation<double> logoScaleAnimation,
//     required Animation<Offset> textSlideAnimation,
//     required Animation<double> textFadeAnimation,
//   }) : _backgroundController = backgroundController,
//        _logoController = logoController,
//        _textController = textController,
//        _exitController = exitController,
//        _exitFadeAnimation = exitFadeAnimation,
//        _backgroundAnimation = backgroundAnimation,
//        _logoFadeAnimation = logoFadeAnimation,
//        _logoScaleAnimation = logoScaleAnimation,
//        _textSlideAnimation = textSlideAnimation,
//        _textFadeAnimation = textFadeAnimation;
//
//   final AnimationController _backgroundController;
//   final AnimationController _logoController;
//   final AnimationController _textController;
//   final AnimationController _exitController;
//   final Animation<double> _exitFadeAnimation;
//   final Animation<double> _backgroundAnimation;
//   final Animation<double> _logoFadeAnimation;
//   final Animation<double> _logoScaleAnimation;
//   final Animation<Offset> _textSlideAnimation;
//   final Animation<double> _textFadeAnimation;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: Listenable.merge([
//         _backgroundController,
//         _logoController,
//         _textController,
//         _exitController,
//       ]),
//       builder: (context, child) {
//         return FadeTransition(
//           opacity: _exitFadeAnimation,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color.lerp(
//                     ColorsManager.scaffoldBackground,
//                     ColorsManager.lightBackground,
//                     _backgroundAnimation.value,
//                   )!,
//                   Color.lerp(
//                     ColorsManager.lightBackground,
//                     ColorsManager.scaffoldBackground,
//                     _backgroundAnimation.value,
//                   )!,
//                   Color.lerp(
//                     ColorsManager.scaffoldBackground,
//                     ColorsManager.mintGreen.withValues(alpha: 0.05),
//                     _backgroundAnimation.value * 0.3,
//                   )!,
//                 ],
//                 stops: const [0.0, 0.5, 1.0],
//               ),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo with fitness theme shadow
//                   FadeTransition(
//                     opacity: _logoFadeAnimation,
//                     child: ScaleTransition(
//                       scale: _logoScaleAnimation,
//                       child: Container(
//                         width: 120,
//                         height: 120,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           gradient: ColorsManager.primaryGradient,
//                           boxShadow: [
//                             BoxShadow(
//                               color: ColorsManager.primaryGreen.withValues(
//                                 alpha: 0.3,
//                               ),
//                               blurRadius: 25,
//                               spreadRadius: 3,
//                               offset: const Offset(0, 8),
//                             ),
//                             BoxShadow(
//                               color: ColorsManager.lightGreen.withValues(
//                                 alpha: 0.15,
//                               ),
//                               blurRadius: 15,
//                               spreadRadius: 1,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               gradient: ColorsManager.primaryGradient,
//                             ),
//                             child: const Icon(
//                               Icons.fitness_center,
//                               size: 60,
//                               color: ColorsManager.whiteText,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // App name with fitness theme colors
//                   SlideTransition(
//                     position: _textSlideAnimation,
//                     child: FadeTransition(
//                       opacity: _textFadeAnimation,
//                       child: const Column(
//                         children: [
//                           Text(
//                             'FITRIX',
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: ColorsManager.primaryText,
//                               letterSpacing: 2.0,
//                             ),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             'FIT YOUR LIFE. FIX YOUR FUTURE',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: ColorsManager.primaryGreen,
//                               letterSpacing: 1.0,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 60),
//
//                   // Loading indicator with fitness theme
//                   FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: ColorsManager.primaryGreen.withValues(
//                               alpha: 0.2,
//                             ),
//                             blurRadius: 10,
//                             spreadRadius: 1,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: CircularProgressIndicator(
//                         valueColor: const AlwaysStoppedAnimation<Color>(
//                           ColorsManager.primaryGreen,
//                         ),
//                         strokeWidth: 3,
//                         backgroundColor: ColorsManager.lightGreen.withValues(
//                           alpha: 0.2,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // Animated fitness tagline
//                   FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Text(
//                       'Transform Your Body, Transform Your Life',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: ColorsManager.secondaryText.withValues(
//                           alpha: 0.8,
//                         ),
//                         letterSpacing: 0.5,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

// class SplashScreenBody extends StatelessWidget {
//   const SplashScreenBody({
//     super.key,
//     required AnimationController backgroundController,
//     required AnimationController logoController,
//     required AnimationController textController,
//     required AnimationController exitController,
//     required Animation<double> exitFadeAnimation,
//     required Animation<double> backgroundAnimation,
//     required Animation<double> logoFadeAnimation,
//     required Animation<double> logoScaleAnimation,
//     required Animation<Offset> textSlideAnimation,
//     required Animation<double> textFadeAnimation,
//   }) : _backgroundController = backgroundController,
//        _logoController = logoController,
//        _textController = textController,
//        _exitController = exitController,
//        _exitFadeAnimation = exitFadeAnimation,
//        _backgroundAnimation = backgroundAnimation,
//        _logoFadeAnimation = logoFadeAnimation,
//        _logoScaleAnimation = logoScaleAnimation,
//        _textSlideAnimation = textSlideAnimation,
//        _textFadeAnimation = textFadeAnimation;
//
//   final AnimationController _backgroundController;
//   final AnimationController _logoController;
//   final AnimationController _textController;
//   final AnimationController _exitController;
//   final Animation<double> _exitFadeAnimation;
//   final Animation<double> _backgroundAnimation;
//   final Animation<double> _logoFadeAnimation;
//   final Animation<double> _logoScaleAnimation;
//   final Animation<Offset> _textSlideAnimation;
//   final Animation<double> _textFadeAnimation;
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return AnimatedBuilder(
//       animation: Listenable.merge([
//         _backgroundController,
//         _logoController,
//         _textController,
//         _exitController,
//       ]),
//       builder: (context, child) {
//         return FadeTransition(
//           opacity: _exitFadeAnimation,
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Color.lerp(
//                     ColorsManager.scaffoldBackground,
//                     ColorsManager.lightBackground,
//                     _backgroundAnimation.value,
//                   )!,
//                   Color.lerp(
//                     ColorsManager.lightBackground,
//                     ColorsManager.scaffoldBackground,
//                     _backgroundAnimation.value,
//                   )!,
//                   Color.lerp(
//                     ColorsManager.scaffoldBackground,
//                     ColorsManager.mintGreen.withValues(alpha: 0.05),
//                     _backgroundAnimation.value * 0.3,
//                   )!,
//                 ],
//                 stops: const [0.0, 0.5, 1.0],
//               ),
//             ),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo with fitness theme shadow
//                   FadeTransition(
//                     opacity: _logoFadeAnimation,
//                     child: ScaleTransition(
//                       scale: _logoScaleAnimation,
//                       child: Container(
//                         width: 120,
//                         height: 120,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           gradient: ColorsManager.primaryGradient,
//                           boxShadow: [
//                             BoxShadow(
//                               color: ColorsManager.primaryGreen.withValues(
//                                 alpha: 0.3,
//                               ),
//                               blurRadius: 25,
//                               spreadRadius: 3,
//                               offset: const Offset(0, 8),
//                             ),
//                             BoxShadow(
//                               color: ColorsManager.lightGreen.withValues(
//                                 alpha: 0.15,
//                               ),
//                               blurRadius: 15,
//                               spreadRadius: 1,
//                               offset: const Offset(0, 4),
//                             ),
//                           ],
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(20),
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               gradient: ColorsManager.primaryGradient,
//                             ),
//                             child: const Icon(
//                               Icons.fitness_center,
//                               size: 60,
//                               color: ColorsManager.whiteText,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // App name with fitness theme colors
//                   SlideTransition(
//                     position: _textSlideAnimation,
//                     child: FadeTransition(
//                       opacity: _textFadeAnimation,
//                       child: Column(
//                         children: [
//                           Text(
//                             s.appName,
//                             style: const TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.bold,
//                               color: ColorsManager.primaryText,
//                               letterSpacing: 2.0,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             s.appTagline,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: ColorsManager.primaryGreen,
//                               letterSpacing: 1.0,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 60),
//
//                   // Loading indicator with fitness theme
//                   FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: ColorsManager.primaryGreen.withValues(
//                               alpha: 0.2,
//                             ),
//                             blurRadius: 10,
//                             spreadRadius: 1,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: CircularProgressIndicator(
//                         valueColor: const AlwaysStoppedAnimation<Color>(
//                           ColorsManager.primaryGreen,
//                         ),
//                         strokeWidth: 3,
//                         backgroundColor: ColorsManager.lightGreen.withValues(
//                           alpha: 0.2,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 40),
//
//                   // Animated fitness tagline
//                   FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Text(
//                       s.transformYourLife,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: ColorsManager.secondaryText.withValues(
//                           alpha: 0.8,
//                         ),
//                         letterSpacing: 0.5,
//                         fontWeight: FontWeight.w400,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class SplashScreenBody extends StatelessWidget {
  const SplashScreenBody({
    super.key,
    required AnimationController backgroundController,
    required AnimationController logoController,
    required AnimationController textController,
    required AnimationController exitController,
    required Animation<double> exitFadeAnimation,
    required Animation<double> backgroundAnimation,
    required Animation<double> logoFadeAnimation,
    required Animation<double> logoScaleAnimation,
    required Animation<Offset> textSlideAnimation,
    required Animation<double> textFadeAnimation,
  }) : _backgroundController = backgroundController,
       _logoController = logoController,
       _textController = textController,
       _exitController = exitController,
       _exitFadeAnimation = exitFadeAnimation,
       _backgroundAnimation = backgroundAnimation,
       _logoFadeAnimation = logoFadeAnimation,
       _logoScaleAnimation = logoScaleAnimation,
       _textSlideAnimation = textSlideAnimation,
       _textFadeAnimation = textFadeAnimation;

  final AnimationController _backgroundController;
  final AnimationController _logoController;
  final AnimationController _textController;
  final AnimationController _exitController;
  final Animation<double> _exitFadeAnimation;
  final Animation<double> _backgroundAnimation;
  final Animation<double> _logoFadeAnimation;
  final Animation<double> _logoScaleAnimation;
  final Animation<Offset> _textSlideAnimation;
  final Animation<double> _textFadeAnimation;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _backgroundController,
        _logoController,
        _textController,
        _exitController,
      ]),
      builder: (context, child) {
        return FadeTransition(
          opacity: _exitFadeAnimation,
          child: Container(
            decoration: BoxDecoration(
              gradient: _buildBackgroundGradient(context, isDark),
            ),
            child: Stack(
              children: [
                // 🌟 Animated glow effect (only for dark mode)
                if (isDark)
                  Positioned.fill(
                    child: FadeTransition(
                      opacity: _logoFadeAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 0.8,
                            colors: [
                              ColorsManager.darkPrimaryGreen.withOpacity(
                                0.08 * _backgroundAnimation.value,
                              ),
                              ColorsManager.darkSecondaryGreen.withOpacity(
                                0.04 * _backgroundAnimation.value,
                              ),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ),
                  ),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 🎯 Logo with adaptive styling
                      _buildLogo(context, isDark),

                      const SizedBox(height: 50),

                      // 📱 App name with adaptive styling
                      _buildAppTitle(context, s, isDark),

                      const SizedBox(height: 70),

                      // 🔄 Loading indicator
                      _buildLoadingIndicator(context, isDark),

                      const SizedBox(height: 50),

                      // 💪 Motivational tagline
                      _buildTagline(context, s, isDark),
                    ],
                  ),
                ),

                // 🌟 Decorative particles (only for dark mode)
                if (isDark) ..._buildParticles(),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🎨 Build background gradient based on theme
  LinearGradient _buildBackgroundGradient(BuildContext context, bool isDark) {
    if (isDark) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.lerp(
            ColorsManager.darkScaffold,
            ColorsManager.darkSurface,
            _backgroundAnimation.value * 0.5,
          )!,
          Color.lerp(
            ColorsManager.darkSurface,
            const Color(0xFF0F1419),
            _backgroundAnimation.value * 0.7,
          )!,
          Color.lerp(
            const Color(0xFF0A0E14),
            ColorsManager.darkScaffold,
            _backgroundAnimation.value * 0.3,
          )!,
        ],
        stops: const [0.0, 0.5, 1.0],
      );
    } else {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.lerp(
            ColorsManager.lightScaffoldBackground,
            const Color(0xFFF8F9FA),
            _backgroundAnimation.value,
          )!,
          Color.lerp(
            const Color(0xFFF8F9FA),
            ColorsManager.lightScaffoldBackground,
            _backgroundAnimation.value,
          )!,
          Color.lerp(
            ColorsManager.lightScaffoldBackground,
            ColorsManager.mintGreen.withOpacity(0.05),
            _backgroundAnimation.value * 0.3,
          )!,
        ],
        stops: const [0.0, 0.5, 1.0],
      );
    }
  }

  // 🎯 Build logo with adaptive styling
  Widget _buildLogo(BuildContext context, bool isDark) {
    return FadeTransition(
      opacity: _logoFadeAnimation,
      child: ScaleTransition(
        scale: _logoScaleAnimation,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow ring (more prominent in dark mode)
            if (isDark)
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      ColorsManager.darkPrimaryGreen.withOpacity(0.3),
                      ColorsManager.darkSecondaryGreen.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.6, 1.0],
                  ),
                ),
              ),

            // Logo container
            Container(
              width: isDark ? 130 : 120,
              height: isDark ? 130 : 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(isDark ? 28 : 20),
                gradient: ColorsManager.getLogoGradient(context),
                boxShadow: ColorsManager.getLogoShadow(context),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isDark ? 28 : 20),
                  border: isDark
                      ? Border.all(
                          color: ColorsManager.darkAccentGreen.withOpacity(0.3),
                          width: 2,
                        )
                      : null,
                ),
                child: Icon(
                  Icons.fitness_center,
                  size: isDark ? 70 : 60,
                  color: isDark
                      ? const Color(0xFF0A0E14)
                      : ColorsManager.lightScaffoldBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 📱 Build app title with adaptive styling
  Widget _buildAppTitle(BuildContext context, S s, bool isDark) {
    return SlideTransition(
      position: _textSlideAnimation,
      child: FadeTransition(
        opacity: _textFadeAnimation,
        child: Column(
          children: [
            // Main app name
            if (isDark)
              ShaderMask(
                shaderCallback: (bounds) =>
                    ColorsManager.getLogoGradient(context).createShader(bounds),
                child: Text(
                  s.appName,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 4.0,
                    height: 1.2,
                  ),
                ),
              )
            else
              Text(
                s.appName,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryText(context),
                  letterSpacing: 2.0,
                ),
              ),

            const SizedBox(height: 12),

            // Tagline
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark
                    ? ColorsManager.darkSurface.withOpacity(0.5)
                    : Colors.transparent,
                border: isDark
                    ? Border.all(
                        color: ColorsManager.darkPrimaryGreen.withOpacity(0.2),
                        width: 1,
                      )
                    : null,
              ),
              child: Text(
                s.appTagline,
                style: TextStyle(
                  fontSize: isDark ? 12 : 14,
                  color: isDark
                      ? ColorsManager.darkAccentGreen
                      : ColorsManager.primaryGreen,
                  letterSpacing: isDark ? 1.5 : 1.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔄 Build loading indicator with adaptive styling
  Widget _buildLoadingIndicator(BuildContext context, bool isDark) {
    return FadeTransition(
      opacity: _textFadeAnimation,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect (more prominent in dark mode)
          if (isDark)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.darkPrimaryGreen.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
            )
          else
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryGreen.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),

          // Progress indicator
          SizedBox(
            width: isDark ? 45 : 40,
            height: isDark ? 45 : 40,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                ColorsManager.getPrimaryGreen(context),
              ),
              strokeWidth: isDark ? 3.5 : 3,
              backgroundColor: isDark
                  ? ColorsManager.darkSurface
                  : ColorsManager.lightGreen.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  // 💪 Build tagline with adaptive styling
  Widget _buildTagline(BuildContext context, S s, bool isDark) {
    return FadeTransition(
      opacity: _textFadeAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          s.transformYourLife,
          style: TextStyle(
            fontSize: isDark ? 13 : 12,
            color: ColorsManager.getSecondaryText(context).withOpacity(0.8),
            letterSpacing: isDark ? 0.8 : 0.5,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 🌟 Build decorative particles (dark mode only)
  List<Widget> _buildParticles() {
    return [
      Positioned(
        top: 100,
        right: 50,
        child: FadeTransition(
          opacity: _logoFadeAnimation,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.darkAccentGreen.withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.darkAccentGreen.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 150,
        left: 60,
        child: FadeTransition(
          opacity: _logoFadeAnimation,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsManager.darkSecondaryGreen.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.darkSecondaryGreen.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }
}
