import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashAnimationController {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;
  late AnimationController _exitController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _backgroundAnimation;
  late Animation<double> _exitFadeAnimation;

  bool _hasNavigated = false;

  SplashAnimationController({required TickerProvider vsync}) {
    _initializeControllers(vsync);
    _initializeAnimations();
  }

  void _initializeControllers(TickerProvider vsync) {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: vsync,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: vsync,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: vsync,
    );

    _exitController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );
  }

  void _initializeAnimations() {
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    _exitFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );
  }

  Future<void> startAnimationSequence() async {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    _backgroundController.forward();
    await Future.delayed(const Duration(milliseconds: 300));

    _logoController.forward();
    await Future.delayed(const Duration(milliseconds: 600));

    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  Future<void> startExitAnimation() async {
    await _exitController.forward();
  }

  void markAsNavigated() {
    _hasNavigated = true;
  }

  bool get hasNavigated => _hasNavigated;

  // Getters for animations
  AnimationController get backgroundController => _backgroundController;
  AnimationController get logoController => _logoController;
  AnimationController get textController => _textController;
  AnimationController get exitController => _exitController;

  Animation<double> get exitFadeAnimation => _exitFadeAnimation;
  Animation<double> get backgroundAnimation => _backgroundAnimation;
  Animation<double> get logoFadeAnimation => _logoFadeAnimation;
  Animation<double> get logoScaleAnimation => _logoScaleAnimation;
  Animation<Offset> get textSlideAnimation => _textSlideAnimation;
  Animation<double> get textFadeAnimation => _textFadeAnimation;

  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _exitController.dispose();
  }
}
