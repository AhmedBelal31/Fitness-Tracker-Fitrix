import 'package:fitrix/core/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/networking/token_manager.dart';
import '../../core/routing/page_transitions.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/app_colors.dart';
import '../auth/presentation/cubits/auth_check/auth_check_cubit.dart';
import '../host/presentation/screens/trainer_host_screen.dart';
import '../auth/presentation/screens/login_screen.dart';
import '../host/presentation/screens/user_host_screen.dart';
import 'widgets/splash_screen_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
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
  String? _navigationRoute;

  final TokenManager _tokenManager = TokenManager.instance;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _exitController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

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

  Future<void> _startAnimationSequence() async {
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

  void _onAuthCheckComplete(String route) {
    if (_hasNavigated) return;

    _navigationRoute = route;

    _exitController.forward().then((_) {
      if (mounted && !_hasNavigated) {
        _navigateTo(route);
      }
    });
  }

  void _navigateTo(String route) {
    if (_hasNavigated || !mounted) return;

    _hasNavigated = true;

    Widget destinationScreen;
    switch (route) {
      case Routes.userHostScreen:
        destinationScreen = UserHostScreen();
        break;
      case Routes.trainerHostScreen:
        destinationScreen = TrainerHostScreen();
        break;
      case Routes.loginScreen:
      default:
        destinationScreen = const LoginScreen();
    }

    Navigator.of(context).pushReplacement(
      PageTransitions.slideWithLocale(
        destinationScreen,
        settings: RouteSettings(name: route),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<AuthCheckCubit>()..checkAuthStatus(),
      child: BlocListener<AuthCheckCubit, AuthCheckState>(
        listener: (context, state) async {
          if (state is AuthCheckAuthenticated) {
            await _startAnimationSequence();

            final userProfile = state.user;
            final cachedRole = await _tokenManager.getUserRole();

            if (cachedRole != userProfile.role) {
              dev.log(
                '⚠️ Role mismatch! Cached: $cachedRole, Profile: ${userProfile.role}',
                name: 'SplashScreen',
              );
              if (userProfile.role != null) {
                await _tokenManager.saveUserRole(userProfile.role!);
              }
            }

            String route;
            if (userProfile.role == 1) {
              route = Routes.userHostScreen;
              dev.log('🎯 Navigating to User home', name: 'SplashScreen');
            } else if (userProfile.role == 2) {
              route = Routes.trainerHostScreen;
              dev.log('🎯 Navigating to Trainer home', name: 'SplashScreen');
            } else {
              route = Routes.userHostScreen;
              dev.log(
                '⚠️ Unknown role: ${userProfile.role}, defaulting to User home',
                name: 'SplashScreen',
              );
            }

            _onAuthCheckComplete(route);
          } else if (state is AuthCheckUnauthenticated) {
            await _startAnimationSequence();
            dev.log(
              '🔒 No authentication, navigating to login',
              name: 'SplashScreen',
            );
            _onAuthCheckComplete(Routes.loginScreen);
          }
        },
        child: Scaffold(
          backgroundColor: ColorsManager.scaffoldBackground,
          body: SplashScreenBody(
            backgroundController: _backgroundController,
            logoController: _logoController,
            textController: _textController,
            exitController: _exitController,
            exitFadeAnimation: _exitFadeAnimation,
            backgroundAnimation: _backgroundAnimation,
            logoFadeAnimation: _logoFadeAnimation,
            logoScaleAnimation: _logoScaleAnimation,
            textSlideAnimation: _textSlideAnimation,
            textFadeAnimation: _textFadeAnimation,
          ),
        ),
      ),
    );
  }
}
