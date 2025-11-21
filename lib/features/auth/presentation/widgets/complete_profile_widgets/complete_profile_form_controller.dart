import 'package:flutter/material.dart';

class CompleteProfileFormController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final weightController = TextEditingController();
  final bodyFatController = TextEditingController();
  final muscleMassController = TextEditingController();

  String? selectedGender = 'Male';

  void setGender(String? gender) {
    selectedGender = gender;
  }

  Map<String, dynamic> getFormData() {
    return {
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'gender': selectedGender,
      // 👇 Weight is now required, parse directly
      'weightKg': double.tryParse(weightController.text.trim()),
      'bodyFatPercent': bodyFatController.text.isNotEmpty
          ? double.tryParse(bodyFatController.text)
          : null,
      'muscleMassKg': muscleMassController.text.isNotEmpty
          ? double.tryParse(muscleMassController.text)
          : null,
    };
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    weightController.dispose();
    bodyFatController.dispose();
    muscleMassController.dispose();
  }
}
