import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_checkbox.dart';
import '../../cubits/login/login_cubit.dart';

class LoginRememberMe extends StatelessWidget {
  const LoginRememberMe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return CustomCheckbox(
          value: state.rememberMe,
          onChanged: (_) => context.read<LoginCubit>().toggleRememberMe(),
          label: 'Remember me',
        );
      },
    );
  }
}
