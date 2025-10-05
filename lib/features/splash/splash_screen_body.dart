import 'package:flutter/material.dart';
import '../../core/theming/app_colors.dart';

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
  }) : _backgroundController = backgroundController, _logoController = logoController, _textController = textController, _exitController = exitController, _exitFadeAnimation = exitFadeAnimation, _backgroundAnimation = backgroundAnimation, _logoFadeAnimation = logoFadeAnimation, _logoScaleAnimation = logoScaleAnimation, _textSlideAnimation = textSlideAnimation, _textFadeAnimation = textFadeAnimation;

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
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.lerp(
                    ColorsManager.scaffoldBackground,
                    ColorsManager.lightBackground,
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    ColorsManager.lightBackground,
                    ColorsManager.scaffoldBackground,
                    _backgroundAnimation.value,
                  )!,
                  Color.lerp(
                    ColorsManager.scaffoldBackground,
                    ColorsManager.mintGreen.withValues(alpha: 0.05),
                    _backgroundAnimation.value * 0.3,
                  )!,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with fitness theme shadow
                  FadeTransition(
                    opacity: _logoFadeAnimation,
                    child: ScaleTransition(
                      scale: _logoScaleAnimation,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: ColorsManager.primaryGradient,
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.primaryGreen.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 25,
                              spreadRadius: 3,
                              offset: const Offset(0, 8),
                            ),
                            BoxShadow(
                              color: ColorsManager.lightGreen.withValues(
                                alpha: 0.15,
                              ),
                              blurRadius: 15,
                              spreadRadius: 1,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: ColorsManager.primaryGradient,
                            ),
                            child: const Icon(
                              Icons.fitness_center,
                              size: 60,
                              color: ColorsManager.whiteText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // App name with fitness theme colors
                  SlideTransition(
                    position: _textSlideAnimation,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: const Column(
                        children: [
                          Text(
                            'FITRIX',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.primaryText,
                              letterSpacing: 2.0,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'FIT YOUR LIFE. FIX YOUR FUTURE',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorsManager.primaryGreen,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Loading indicator with fitness theme
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.primaryGreen.withValues(
                              alpha: 0.2,
                            ),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircularProgressIndicator(
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          ColorsManager.primaryGreen,
                        ),
                        strokeWidth: 3,
                        backgroundColor: ColorsManager.lightGreen.withValues(
                          alpha: 0.2,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Animated fitness tagline
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Text(
                      'Transform Your Body, Transform Your Life',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorsManager.secondaryText.withValues(
                          alpha: 0.8,
                        ),
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
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
