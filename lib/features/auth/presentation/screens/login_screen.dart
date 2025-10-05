import 'package:fitrix/core/di/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/login/login_cubit.dart';
import '../widgets/login_widgets/login_screen_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<LoginCubit>(),
      child: LoginScreenBody(),
    );
  }
}
