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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: ColorsManager.getScaffoldBackground(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorsManager.getBackgroundGradient(context),
        ),
        child: Stack(
          children: [
            if (isDark)
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        ColorsManager.darkPrimaryGreen.withOpacity(0.06),
                        ColorsManager.darkSecondaryGreen.withOpacity(0.03),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            SafeArea(
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
          ],
        ),
      ),
    );
  }
}
