import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/params/complete_profile_params.dart';
import '../../cubits/profile_cubit/complete_profile_cubit.dart';
import '../../cubits/profile_cubit/complete_profile_state.dart';
import 'complete_profile_form_controller.dart';
import 'complete_profile_validators.dart';
import 'gender_selector.dart';

class CompleteProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final CompleteProfileFormController controller;

  const CompleteProfileForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _validators = CompleteProfileValidators();

  void _submitProfile() {
    if (!widget.formKey.currentState!.validate()) return;

    final formData = widget.controller.getFormData();

    final params = CompleteProfileParams(
      firstName: formData['firstName'] as String,
      lastName: formData['lastName'] as String,
      gender: formData['gender'] as String,
      weightKg: formData['weightKg'] as double?,
      bodyFatPercent: formData['bodyFatPercent'] as double?,
      muscleMassKg: formData['muscleMassKg'] as double?,
    );

    context.read<CompleteProfileCubit>().submitProfile(params);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: widget.controller.firstNameController,
            label: s.firstName,
            hint: s.enterFirstName,
            prefixIcon: Icons.person,
            validator: (v) =>
                _validators.validateRequired(v, s.firstName, context),
          ),
          const SizedBox(height: 16),

          // 👇 Last Name with hint
          CustomTextField(
            controller: widget.controller.lastNameController,
            label: s.lastName,
            hint: s.enterLastName,
            prefixIcon: Icons.person_outline,
            validator: (v) =>
                _validators.validateRequired(v, s.lastName, context),
          ),
          const SizedBox(height: 16),

          GenderSelector(
            selected: widget.controller.selectedGender,
            onChanged: (gender) {
              setState(() {
                widget.controller.setGender(gender);
              });
            },
          ),
          if (_validators.validateGender(
                widget.controller.selectedGender,
                context,
              ) !=
              null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  _validators.validateGender(
                    widget.controller.selectedGender,
                    context,
                  )!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ),
            ),
          const SizedBox(height: 16),

          // 👇 Weight (Required) with hint
          CustomTextField(
            controller: widget.controller.weightController,
            label: '${s.weightKg} *',
            hint: s.enterWeight, // 👈 Added hint
            prefixIcon: Icons.monitor_weight_outlined,
            keyboardType: TextInputType.number,
            validator: (v) => _validators.validateWeight(v, context),
          ),
          const SizedBox(height: 16),

          // 👇 Body Fat (Optional) with hint
          CustomTextField(
            controller: widget.controller.bodyFatController,
            label: s.bodyFatPercent,
            hint: s.enterBodyFat,
            prefixIcon: Icons.percent,
            keyboardType: TextInputType.number,
            validator: (v) => _validators.validateBodyFat(v, context),
          ),
          const SizedBox(height: 16),

          CustomTextField(
            controller: widget.controller.muscleMassController,
            label: s.muscleMassKg,
            hint: s.enterMuscleMass,
            prefixIcon: Icons.fitness_center,
            keyboardType: TextInputType.number,
            validator: (v) => _validators.validateMuscleMass(v, context),
          ),
          const SizedBox(height: 32),

          // Submit Button
          BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
            builder: (context, state) {
              return CustomButton(
                text: s.completeProfileButton,
                icon: Icons.check,
                isLoading: state.isLoading,
                onPressed: state.isLoading
                    ? null
                    : () {
                        setState(() {}); // Trigger validation
                        if (widget.formKey.currentState!.validate() &&
                            _validators.validateGender(
                                  widget.controller.selectedGender,
                                  context,
                                ) ==
                                null) {
                          _submitProfile();
                        }
                      },
              );
            },
          ),
        ],
      ),
    );
  }
}
