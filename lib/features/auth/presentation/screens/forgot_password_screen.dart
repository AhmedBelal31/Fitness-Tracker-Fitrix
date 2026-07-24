import 'package:fitrix/core/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/forget_password/forgot_password_cubit.dart';
import '../cubits/forget_password/forgot_password_state.dart';
import '../widgets/forgot_password_widgets/forgot_password_listener.dart';
import '../widgets/forgot_password_widgets/forgot_password_screen_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<ForgotPasswordCubit>(),
      child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: ForgotPasswordListener.handleStateChange,
        child: const ForgotPasswordScreenBody(),
      ),
    );
  }
}
