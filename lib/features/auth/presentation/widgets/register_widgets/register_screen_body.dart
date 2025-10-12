import 'package:fitrix/core/routing/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../cubits/register/register_cubit.dart';
import 'register_animated_content.dart';
import 'register_bloc_listener.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      body: Container(
        decoration: const BoxDecoration(
          gradient: ColorsManager.appBackgroundGradient,
        ),
        child: SafeArea(
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: RegisterBlocListener.handleStateChanges,
            builder: (context, state) {
              return RegisterAnimatedContent(
                isLoading: state.isLoading,
                onNavigateToLogin: () =>
                    context.pushReplacementNamed(Routes.loginScreen),
              );
            },
          ),
        ),
      ),
    );
  }
}
