import 'package:flutter/material.dart';

import 'complete_profile_form.dart';
import 'complete_profile_form_controller.dart';
import 'complete_profile_header.dart';

class CompleteProfileScreenBody extends StatefulWidget {
  const CompleteProfileScreenBody({super.key});

  @override
  State<CompleteProfileScreenBody> createState() =>
      _CompleteProfileScreenBodyState();
}

class _CompleteProfileScreenBodyState extends State<CompleteProfileScreenBody> {
  final _formKey = GlobalKey<FormState>();
  late CompleteProfileFormController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CompleteProfileFormController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CompleteProfileHeader(),
              const SizedBox(height: 32),
              CompleteProfileForm(formKey: _formKey, controller: _controller),
            ],
          ),
        ),
      ),
    );
  }
}
