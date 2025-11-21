import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../generated/l10n.dart';
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
    final s = S.of(context);

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CustomButton(
          text: s.createAccountButton,
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

    if (formKey.currentState?.validate() ?? false) {
      final formData = controller.getFormData();

      String phoneNumber = formData['phoneNumber'] as String;

      phoneNumber = _formatPhoneNumber(phoneNumber);

      cubit.register(
        userName: formData['userName'] as String,
        email: formData['email'] as String,
        password: formData['password'] as String,
        phoneNumber: phoneNumber,
        role: formData['role'] as int,
      );
    }
  }

  String _formatPhoneNumber(String phone) {
    phone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (phone.startsWith('+20')) {
      return '0${phone.substring(3)}';
    }

    if (phone.startsWith('20') && !phone.startsWith('0')) {
      return '0${phone.substring(2)}';
    }

    if (!phone.startsWith('0')) {
      return '0$phone';
    }

    return phone;
  }
}
