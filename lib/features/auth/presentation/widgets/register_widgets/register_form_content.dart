import 'package:flutter/material.dart';
import 'register_back_button.dart';
import 'register_form_controller.dart';
import 'register_form_fields.dart';
import 'register_header.dart';
import 'register_login_link.dart';
import 'register_submit_button.dart';

class RegisterFormContent extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onNavigateToLogin;

  const RegisterFormContent({
    super.key,
    required this.isLoading,
    required this.onNavigateToLogin,
  });

  @override
  State<RegisterFormContent> createState() => _RegisterFormContentState();
}

class _RegisterFormContentState extends State<RegisterFormContent> {
  final _formKey = GlobalKey<FormState>();
  final _controller = RegisterFormController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        RegisterBackButton(
          isLoading: widget.isLoading,
          onPressed: widget.onNavigateToLogin,
        ),
        const SizedBox(height: 20),
        const RegisterHeader(),
        const SizedBox(height: 40),
        RegisterFormFields(formKey: _formKey, controller: _controller),
        const SizedBox(height: 32),
        RegisterSubmitButton(formKey: _formKey, controller: _controller),
        const SizedBox(height: 32),
        RegisterLoginLink(
          isLoading: widget.isLoading,
          onPressed: widget.onNavigateToLogin,
        ),
      ],
    );
  }
}
