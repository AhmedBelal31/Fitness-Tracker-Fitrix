import 'package:flutter/material.dart';
import 'package:fitrix/features/auth/data/models/login_profile_model.dart';

// class UpdateProfileFormController {
//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final weightController = TextEditingController();
//   final heightController = TextEditingController();
//   final bodyFatController = TextEditingController();
//   final muscleMassController = TextEditingController();
//
//   String? selectedGender;
//   bool isInitialized = false;
//
//   void initializeWithProfile(LoginProfileModel profile) {
//     if (isInitialized) return;
//
//     firstNameController.text = profile.firstName ?? '';
//     lastNameController.text = profile.lastName ?? '';
//     phoneController.text = profile.phoneNumber ?? '';
//     weightController.text = profile.lastWeightKg?.toString() ?? '';
//     heightController.text = profile.heightCm?.toString() ?? '';
//     bodyFatController.text = profile.lastBodyFatPercent?.toString() ?? '';
//     muscleMassController.text = profile.lastMuscleMassKg?.toString() ?? '';
//     selectedGender = profile.genderString; // "Male" or "Female"
//
//     isInitialized = true;
//   }
//
//   void setGender(String? gender) {
//     selectedGender = gender;
//   }
//
//   Map<String, dynamic> getFormData() {
//     return {
//       'firstName': firstNameController.text.trim(),
//       'lastName': lastNameController.text.trim(),
//       'gender': selectedGender,
//       'phoneNumber': phoneController.text.trim(),
//       'weightKg': weightController.text.isNotEmpty
//           ? double.tryParse(weightController.text)
//           : null,
//       'heightCm': heightController.text.isNotEmpty
//           ? double.tryParse(heightController.text)
//           : null,
//       'bodyFatPercent': bodyFatController.text.isNotEmpty
//           ? double.tryParse(bodyFatController.text)
//           : null,
//       'muscleMassKg': muscleMassController.text.isNotEmpty
//           ? double.tryParse(muscleMassController.text)
//           : null,
//     };
//   }
//
//   void dispose() {
//     firstNameController.dispose();
//     lastNameController.dispose();
//     phoneController.dispose();
//     weightController.dispose();
//     heightController.dispose();
//     bodyFatController.dispose();
//     muscleMassController.dispose();
//   }
// }
// presentation/controllers/update_profile_form_controller.dart

class UpdateProfileFormController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bodyFatController = TextEditingController();
  final TextEditingController muscleMassController = TextEditingController();

  // ✅ Add goal controllers
  final TextEditingController weightGoalController = TextEditingController();
  final TextEditingController bodyFatGoalController = TextEditingController();
  final TextEditingController muscleMassGoalController =
      TextEditingController();

  String selectedGender = '';
  bool isInitialized = false;
  DateTime? selectedBirthDate;

  void initializeWithProfile(LoginProfileModel profile) {
    firstNameController.text = profile.firstName ?? '';
    lastNameController.text = profile.lastName ?? '';
    phoneController.text = profile.phoneNumber ?? '';
    selectedGender = (profile.gender == 1) ? 'Male' : 'Female';

    weightController.text = profile.lastWeightKg?.toString() ?? '';
    heightController.text = profile.heightCm?.toString() ?? '';
    bodyFatController.text = profile.lastBodyFatPercent?.toString() ?? '';
    muscleMassController.text = profile.lastMuscleMassKg?.toString() ?? '';

    // ✅ Initialize goal fields
    weightGoalController.text = profile.weightGoal?.toString() ?? '';
    bodyFatGoalController.text = profile.bodyFatGoal?.toString() ?? '';
    muscleMassGoalController.text = profile.muscleMassGoal?.toString() ?? '';
    selectedBirthDate = profile.dateOfBirth;

    isInitialized = true;
  }

  void setGender(String gender) {
    selectedGender = gender;
  }

  void setBirthDate(DateTime? date) {
    selectedBirthDate = date;
  }

  Map<String, dynamic> getFormData() {
    return {
      'firstName': firstNameController.text.trim(),
      'lastName': lastNameController.text.trim(),
      'phoneNumber': phoneController.text.trim().isEmpty
          ? null
          : phoneController.text.trim(),
      'gender': selectedGender,
      'weightKg': double.tryParse(weightController.text.trim()),
      'heightCm': double.tryParse(heightController.text.trim()),
      'bodyFatPercent': double.tryParse(bodyFatController.text.trim()),
      'muscleMassKg': double.tryParse(muscleMassController.text.trim()),
      // ✅ Add goal fields
      'weightGoal': double.tryParse(weightGoalController.text.trim()),
      'bodyFatGoal': double.tryParse(bodyFatGoalController.text.trim()),
      'muscleMassGoal': double.tryParse(muscleMassGoalController.text.trim()),
      'birthDate': selectedBirthDate,
    };
  }

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    weightController.dispose();
    heightController.dispose();
    bodyFatController.dispose();
    muscleMassController.dispose();
    // ✅ Dispose goal controllers
    weightGoalController.dispose();
    bodyFatGoalController.dispose();
    muscleMassGoalController.dispose();
  }
}
