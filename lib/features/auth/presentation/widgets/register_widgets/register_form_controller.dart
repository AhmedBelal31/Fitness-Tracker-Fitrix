import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/register/register_cubit.dart';

class RegisterFormController {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  int _selectedRole = 1;
  int get selectedRole => _selectedRole;

  void initialize(BuildContext context) {
    _setupFieldListeners(context);
  }

  void _setupFieldListeners(BuildContext context) {
    userNameController.addListener(() {
      if (context.mounted) {
        context.read<RegisterCubit>().clearFieldError('UserName');
      }
    });

    emailController.addListener(() {
      if (context.mounted) {
        context.read<RegisterCubit>().clearFieldError('Email');
      }
    });

    phoneController.addListener(() {
      if (context.mounted) {
        context.read<RegisterCubit>().clearFieldError('PhoneNumber');
      }
    });

    passwordController.addListener(() {
      if (context.mounted) {
        context.read<RegisterCubit>().clearFieldError('Password');
      }
    });
  }

  void setSelectedRole(int role) {
    _selectedRole = role;
  }

  Map<String, dynamic> getFormData() {
    return {
      'userName': userNameController.text.trim(),
      'email': emailController.text.trim(),
      'password': passwordController.text,
      'phoneNumber': phoneController.text.trim(),
      'role': _selectedRole,
    };
  }

  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }
}
