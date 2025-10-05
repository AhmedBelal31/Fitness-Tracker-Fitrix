import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/networking/dio_helper.dart';
import '../../core/routing/routes.dart';
import '../../core/theming/app_colors.dart';
import '../../core/theming/styles.dart';
import '../auth/domain/repositories/auth_repository_impl.dart';
import '../auth/presentation/cubits/auth_check/auth_check_cubit.dart';
import '../profile/presentation/screens/complete_profile_screen.dart';
import '../auth/presentation/screens/login_screen.dart';
import '../auth/presentation/widgets/login_widgets/animated_fitness_icon.dart';
import '../host/presentation/screens/host_screen.dart';
import 'splash_screen_body.dart';
// lib/features/auth/presentation/pages/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Logo animations
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Text animations
    _textController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Background animation
    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Exit animation
    _exitController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Logo scale with bounce effect
    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    // Logo fade in
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    // Text slide up and fade in
    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
        );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    // Background gradient animation
    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.easeInOut),
    );

    // Exit fade animation
    _exitFadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );
  }

  Future<void> _startAnimationSequence() async {
    // Set status bar style for light theme
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    // Start background animation immediately
    _backgroundController.forward();

    // Start logo animation after a short delay
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // Start text animation when logo is halfway done
    await Future.delayed(const Duration(milliseconds: 600));
    _textController.forward();

    // Wait for all animations to complete
    await Future.delayed(const Duration(milliseconds: 1500));
  }

  void _onAuthCheckComplete(String route) {
    if (_hasNavigated) return;

    _navigationRoute = route;

    // Start exit animation and navigate
    _exitController.forward().then((_) {
      if (mounted && !_hasNavigated) {
        _navigateTo(route);
      }
    });
  }

  void _navigateTo(String route) {
    if (_hasNavigated || !mounted) return;

    _hasNavigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          // Determine which screen to navigate to
          switch (route) {
            case Routes.hostScreen:
              return const HostScreen();
            case Routes.completeProfileScreen:
              return const CompleteProfileScreen();
            case Routes.loginScreen:
            default:
              return const LoginScreen();
          }
        },
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Slide in from bottom with fade
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(opacity: fadeAnimation, child: child),
          );
        },
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
      create: (context) =>
          AuthCheckCubit(AuthRepositoryImpl(ApiService()))..checkAuthStatus(),
      child: BlocListener<AuthCheckCubit, AuthCheckState>(
        listener: (context, state) async {
          // Wait for animations to complete before navigating
          if (state is AuthCheckAuthenticated) {
            // Ensure animations have started
            await _startAnimationSequence();
            _onAuthCheckComplete(Routes.hostScreen);
          } else if (state is AuthCheckNeedsProfileCompletion) {
            await _startAnimationSequence();
            _onAuthCheckComplete(Routes.completeProfileScreen);
          } else if (state is AuthCheckUnauthenticated) {
            await _startAnimationSequence();
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

// lib/features/auth/presentation/pages/splash_screen.dart
// lib/features/auth/presentation/pages/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           AuthCheckCubit(AuthRepositoryImpl(ApiService()))..checkAuthStatus(),
//       child: Scaffold(
//         backgroundColor: ColorsManager.scaffoldBackground,
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: ColorsManager.appBackgroundGradient,
//           ),
//           child: BlocListener<AuthCheckCubit, AuthCheckState>(
//             listener: (context, state) {
//               if (state is AuthCheckAuthenticated) {
//                 // User is authenticated and has profile - go to home
//                 Future.delayed(const Duration(milliseconds: 500), () {
//                   if (context.mounted) {
//                     context.pushReplacementNamed(Routes.hostScreen);
//                   }
//                 });
//               } else if (state is AuthCheckNeedsProfileCompletion) {
//                 // User is authenticated but needs to complete profile
//                 Future.delayed(const Duration(milliseconds: 500), () {
//                   if (context.mounted) {
//                     context.pushReplacementNamed(Routes.completeProfileScreen);
//                   }
//                 });
//               } else if (state is AuthCheckUnauthenticated) {
//                 // User is not authenticated - go to login
//                 Future.delayed(const Duration(milliseconds: 500), () {
//                   if (context.mounted) {
//                     context.pushReplacementNamed(Routes.loginScreen);
//                   }
//                 });
//               }
//             },
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const PulsingFitnessIcon(size: 120),
//                   const SizedBox(height: 32),
//                   Text(
//                     'FITRIX',
//                     style: TextStyles.headline1.copyWith(
//                       fontSize: 32,
//                       letterSpacing: 4,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Your Fitness Journey Starts Here',
//                     style: TextStyles.subtitle2,
//                   ),
//                   const SizedBox(height: 48),
//                   BlocBuilder<AuthCheckCubit, AuthCheckState>(
//                     builder: (context, state) {
//                       if (state is AuthCheckLoading) {
//                         return const CircularProgressIndicator(
//                           color: ColorsManager.primaryGreen,
//                         );
//                       }
//                       return const SizedBox.shrink();
//                     },
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
