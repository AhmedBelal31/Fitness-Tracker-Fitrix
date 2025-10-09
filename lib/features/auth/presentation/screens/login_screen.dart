import 'package:fitrix/core/di/get_it.dart';
import 'package:fitrix/core/helpers/constants.dart';
import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/login/login_cubit.dart';
import '../widgets/login_widgets/login_screen_body.dart';
import '../../../../core/routing/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<LoginCubit>(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.shouldNavigateToHome) {
            // Navigate to home screen
            context.pushReplacementNamed(
              Constants.isUser
                  ? Routes.userHostScreen
                  : Routes.trainerHostScreen,
            );
          } else if (state.shouldNavigateToCompleteProfile) {
            // Navigate to complete profile screen
            context.pushReplacementNamed(Routes.completeProfileScreen);
          } else if (state.hasError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const LoginScreenBody(),
      ),
    );
  }
}
