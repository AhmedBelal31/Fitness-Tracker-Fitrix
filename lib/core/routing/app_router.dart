import 'package:fitrix/core/routing/page_transitions.dart';
import 'package:fitrix/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:fitrix/features/home/presentation/screens/trainer_home_screen.dart';
import 'package:fitrix/features/home/presentation/screens/user_home_screen.dart';
import 'package:fitrix/features/host/presentation/screens/trainer_host_screen.dart';
import 'package:fitrix/features/host/presentation/screens/user_host_screen.dart';
import 'package:fitrix/features/auth/presentation/screens/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/exercises/data/models/section_model.dart';
import '../../features/exercises/presentation/screens/custom_exercises_screen.dart';
import '../../features/exercises/presentation/screens/section_exercises_screen.dart';
import '../../features/profile/presentation/screens/about_screen.dart';
import '../../features/profile/presentation/screens/contact_support_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../../features/profile/presentation/screens/terms_conditions_screen.dart';
import 'export_routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    final name = settings.name;
    final args = settings.arguments;

    Widget screen;

    switch (name) {
      case Routes.splashScreen:
        screen = const SplashScreen();
        break;
      case Routes.loginScreen:
        screen = const LoginScreen();
        break;
      case Routes.registerScreen:
        screen = const RegisterScreen();
        break;
      case Routes.forgotPasswordScreen:
        screen = const ForgotPasswordScreen();
        break;
      case Routes.completeProfileScreen:
        screen = const CompleteProfileScreen();
        break;
      case Routes.userHostScreen:
        screen = UserHostScreen();
      case Routes.trainerHostScreen:
        screen = TrainerHostScreen();
        break;

      case Routes.userHomeScreen:
        screen = UserHomeScreen();
      case Routes.trainerHomeScreen:
        screen = TrainerHomeScreen();
        break;

      case Routes.sectionExercises:
        final section = settings.arguments as SectionModel;
        return MaterialPageRoute(
          builder: (_) => SectionExercisesScreen(section: section),
        );

      case Routes.customExercises:
        return MaterialPageRoute(builder: (_) => const CustomExercisesScreen());

      case Routes.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      case Routes.termsConditionsScreen:
        return MaterialPageRoute(builder: (_) => const TermsConditionsScreen());

      case Routes.contactSupportScreen:
        return MaterialPageRoute(builder: (_) => const ContactSupportScreen());

      case Routes.aboutScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());

      default:
        screen = const ErrorScreen();
    }
    return PageTransitions.slideWithLocale(screen, settings: settings);
  }
}
