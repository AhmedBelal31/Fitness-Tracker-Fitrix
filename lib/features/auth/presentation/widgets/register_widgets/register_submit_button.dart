import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../cubits/register/register_cubit.dart';
import 'register_form_controller.dart';

class RegisterSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final RegisterFormController controller;

  const RegisterSubmitButton({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CustomButton(
          text: 'Create Account',
          onPressed: state.isLoading ? null : () => _handleSubmit(context),
          isLoading: state.isLoading,
          icon: Icons.person_add,
        );
      },
    );
  }

  void _handleSubmit(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    cubit.clearError();

    // Validate form
    if (formKey.currentState?.validate() ?? false) {
      // Get form data
      final formData = controller.getFormData();

      // Call register
      cubit.register(
        userName: formData['userName'] as String,
        email: formData['email'] as String,
        password: formData['password'] as String,
        phoneNumber: formData['phoneNumber'] as String,
        role: formData['role'] as int,
      );
    }
  }
}
