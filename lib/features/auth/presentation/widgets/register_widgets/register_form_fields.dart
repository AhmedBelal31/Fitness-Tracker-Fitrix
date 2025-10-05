import 'package:flutter/material.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import 'register_form_controller.dart';
import 'register_validators.dart';
import 'register_role_selector.dart';

class RegisterFormFields extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final RegisterFormController controller;
  const RegisterFormFields({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  State<RegisterFormFields> createState() => _RegisterFormFieldsState();
}

class _RegisterFormFieldsState extends State<RegisterFormFields> {
  final _validators = RegisterValidators();

  @override
  void initState() {
    super.initState();
    widget.controller.initialize(context);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.controller.userNameController,
            label: 'Username',
            hint: 'Choose a username',
            prefixIcon: Icons.person_outlined,
            validator: (value) => _validators.validateUserName(value, context),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.controller.emailController,
            label: 'Email Address',
            hint: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => _validators.validateEmail(value, context),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.controller.phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (value) => _validators.validatePhone(value, context),
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: widget.controller.passwordController,
            label: 'Password',
            hint: 'Create a strong password',
            prefixIcon: Icons.lock_outlined,
            isPassword: true,
            validator: (value) => _validators.validatePassword(value, context),
          ),
          const SizedBox(height: 24),
          RegisterRoleSelector(
            selectedRole: widget.controller.selectedRole,
            onRoleChanged: widget.controller.setSelectedRole,
          ),
        ],
      ),
    );
  }
}
