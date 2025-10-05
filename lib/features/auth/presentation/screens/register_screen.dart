import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../cubits/register/register_cubit.dart';
import '../widgets/register_widgets/register_screen_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<RegisterCubit>(),
      child: RegisterScreenBody(),
    );
  }
}
