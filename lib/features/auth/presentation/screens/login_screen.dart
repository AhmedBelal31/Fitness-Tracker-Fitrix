import 'package:fitrix/core/di/get_it.dart';
import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../cubits/login/login_cubit.dart';
import '../widgets/login_widgets/login_listener.dart';
import '../widgets/login_widgets/login_screen_body.dart';
import '../../../../core/routing/routes.dart';
import 'dart:developer' as dev;

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di.get<LoginCubit>()..initialize(),
//       child: BlocListener<LoginCubit, LoginState>(
//         listener: (context, state) async {
//           if (state.shouldNavigateToHome) {
//             final userProfile = state.userProfile;
//
//             String route;
//             if (userProfile?.isUser == true) {
//               route = Routes.userHostScreen;
//             } else if (userProfile?.isTrainer == true) {
//               route = Routes.trainerHostScreen;
//             } else {
//               route = Routes.userHostScreen;
//             }
//
//             dev.log(
//               '🎯 Navigating to ${userProfile?.roleString ?? "User"} home',
//               name: 'LoginScreen',
//             );
//
//             if (context.mounted) {
//               context.pushReplacementNamed(route);
//             }
//           } else if (state.shouldNavigateToCompleteProfile) {
//             dev.log('📝 Navigating to complete profile', name: 'LoginScreen');
//
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Please complete your profile to continue'),
//                 backgroundColor: ColorsManager.primaryGreen,
//                 behavior: SnackBarBehavior.floating,
//                 duration: Duration(seconds: 2),
//               ),
//             );
//
//             await Future.delayed(const Duration(milliseconds: 500));
//
//             if (context.mounted) {
//               context.pushReplacementNamed(Routes.completeProfileScreen);
//             }
//           } else if (state.hasError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Row(
//                   children: [
//                     const Icon(Icons.error_outline, color: Colors.white),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         state.errorMessage!,
//                         style: const TextStyle(fontSize: 14),
//                       ),
//                     ),
//                   ],
//                 ),
//                 backgroundColor: Colors.red,
//                 behavior: SnackBarBehavior.floating,
//                 duration: const Duration(seconds: 4),
//                 action: SnackBarAction(
//                   label: 'Dismiss',
//                   textColor: Colors.white,
//                   onPressed: () {
//                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                   },
//                 ),
//               ),
//             );
//           }
//         },
//         child: const LoginScreenBody(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<LoginCubit>()..initialize(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: LoginListener.handleStateChange,
        child: const LoginScreenBody(),
      ),
    );
  }
}
