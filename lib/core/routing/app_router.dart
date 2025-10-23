import 'package:fitrix/core/routing/page_transitions.dart';
import 'package:fitrix/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:fitrix/features/home/presentation/screens/trainer_home_screen.dart';
import 'package:fitrix/features/home/presentation/screens/user_home_screen.dart';
import 'package:fitrix/features/host/presentation/screens/trainer_host_screen.dart';
import 'package:fitrix/features/host/presentation/screens/user_host_screen.dart';
import 'package:fitrix/features/auth/presentation/screens/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/exercises/data/models/exercise_model.dart';
import '../../features/exercises/data/models/section_model.dart';
import '../../features/exercises/presentation/cubit/custom_exercises_cubit.dart';
import '../../features/exercises/presentation/cubit/exercises_cubit.dart';
import '../../features/exercises/presentation/cubit/sections_cubit.dart';
import '../../features/exercises/presentation/screens/create_custom_exercise_screen.dart';
import '../../features/exercises/presentation/screens/custom_exercises_screen.dart';
import '../../features/exercises/presentation/screens/exercise_details_screen.dart';
import '../../features/exercises/presentation/screens/exercise_progress_screen.dart';
import '../../features/exercises/presentation/screens/section_exercises_screen.dart';
import '../../features/home/presentation/screens/all_records_screen.dart';
import '../../features/home/presentation/widgets/custom_exercise_widgets/select_section_screen.dart';
import '../../features/notifications/data/models/notification_model.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../../features/notifications/presentation/screens/notification_details_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/about_screen.dart';
import '../../features/profile/presentation/screens/change_password_screen.dart';
import '../../features/profile/presentation/screens/contact_support_screen.dart';
import '../../features/profile/presentation/screens/privacy_policy_screen.dart';
import '../../features/profile/presentation/screens/terms_conditions_screen.dart'
    hide PrivacyPolicyScreen;
import '../../features/profile/presentation/screens/update_profile.dart';
import '../../features/workout/presentation/cubit/workouts_cubit.dart';
import '../../features/workout/presentation/screens/workout_details_screen.dart';
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

      // ========== SECTION EXERCISES SCREEN ==========
      // case Routes.sectionExercises:
      //   final section = settings.arguments as SectionModel;
      //   return MaterialPageRoute(
      //     builder: (_) => BlocProvider(
      //       create: (context) => di.get<ExercisesCubit>(),
      //       child: SectionExercisesScreen(
      //         sectionId: section.id,
      //         sectionName: section.name,
      //       ),
      //     ),
      //   );
      // In your routes configuration
      case Routes.sectionExercises:
        final args = settings.arguments;

        if (args is Map<String, dynamic>) {
          // ✅ Coming from workout with context
          final section = args['section'];
          final workoutId = args['workoutId'] as String?;
          final workoutsCubit = args['workoutsCubit'] as WorkoutsCubit?;

          return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
              providers: [
                // ✅ Always provide ExercisesCubit
                BlocProvider(create: (_) => di.get<ExercisesCubit>()),
                // ✅ Provide existing WorkoutsCubit if available
                if (workoutsCubit != null)
                  BlocProvider.value(value: workoutsCubit),
              ],
              child: SectionExercisesScreen(
                sectionId: section.id,
                sectionName: section.name,
                workoutId: workoutId,
              ),
            ),
          );
        } else {
          // ✅ Coming from home screen (no workout context)
          final section = args as dynamic;
          return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => di.get<ExercisesCubit>(),
              child: SectionExercisesScreen(
                sectionId: section.id,
                sectionName: section.name,
              ),
            ),
          );
        }

      // ========== EXERCISE DETAILS SCREEN ==========
      case Routes.exerciseDetails:
        final exercise = settings.arguments as ExerciseModel;
        return MaterialPageRoute(
          builder: (_) => ExerciseDetailsScreen(exercise: exercise),
        );

      // ========== CUSTOM EXERCISES SCREEN ==========
      case Routes.customExercises:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di.get<CustomExercisesCubit>(),
            child: CustomExercisesScreen(),
          ),
        );

      case Routes.selectSection:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: di<SectionsCubit>(),
            child: const SelectSectionScreen(),
          ),
        );

      // ========== CREATE CUSTOM EXERCISE SCREEN ==========
      case Routes.createCustomExercise:
        final sectionId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => di.get<CustomExercisesCubit>(),
            child: CreateCustomExerciseScreen(sectionId: sectionId),
          ),
        );

      case Routes.customExercises:
        return MaterialPageRoute(builder: (_) => const CustomExercisesScreen());

      case Routes.privacyPolicyScreen:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen());

      case Routes.termsConditionsScreen:
        return MaterialPageRoute(builder: (_) => TermsConditionsScreen());

      case Routes.contactSupportScreen:
        return MaterialPageRoute(builder: (_) => const ContactSupportScreen());

      case Routes.aboutScreen:
        return MaterialPageRoute(builder: (_) => const AboutScreen());

      case Routes.updateProfileScreen:
        return MaterialPageRoute(builder: (_) => const UpdateProfileScreen());

      case Routes.workoutDetails:
        final workoutId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => WorkoutDetailsScreen(workoutId: workoutId),
        );
      case Routes.allRecords:
        return MaterialPageRoute(builder: (_) => const AllRecordsScreen());

      case Routes.changePassword:
        return MaterialPageRoute(
          builder: (_) => const ChangePasswordScreen(), // No arguments needed
        );
      case Routes.exerciseProgress:
        final exercise = settings.arguments as ExerciseModel;
        return MaterialPageRoute(
          builder: (_) => ExerciseProgressScreen(exercise: exercise),
        );
      case Routes.notifications:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: di<NotificationsCubit>(),
            child: const NotificationsScreen(),
          ),
        );

      case Routes.notificationDetails:
        final notification = settings.arguments as NotificationModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: di<NotificationsCubit>(),
            child: NotificationDetailsScreen(notification: notification),
          ),
        );

      default:
        screen = const ErrorScreen();
    }
    return PageTransitions.slideWithLocale(screen, settings: settings);
  }
}
