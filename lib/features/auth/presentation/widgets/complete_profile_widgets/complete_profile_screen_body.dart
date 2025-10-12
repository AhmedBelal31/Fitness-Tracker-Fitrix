import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../core/helpers/constants.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../auth/presentation/widgets/login_widgets/animated_fitness_icon.dart';
import '../../../data/models/login_profile_model.dart';
import '../../../data/models/params/complete_profile_params.dart';
import '../../cubits/profile_cubit/complete_profile_cubit.dart';
import '../../cubits/profile_cubit/complete_profile_state.dart';
import 'complete_profile_form.dart';
import 'complete_profile_form_controller.dart';
import 'complete_profile_header.dart';
import 'gender_selector.dart';
import 'dart:developer' as dev;

// class CompleteProfileScreenBody extends StatefulWidget {
//   const CompleteProfileScreenBody({super.key});
//
//   @override
//   State<CompleteProfileScreenBody> createState() =>
//       _CompleteProfileScreenBodyState();
// }
//
// class _CompleteProfileScreenBodyState extends State<CompleteProfileScreenBody>
//     with TickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   String? _gender;
//
//   final _weightController = TextEditingController();
//   final _bodyFatController = TextEditingController();
//   final _muscleMassController = TextEditingController();
//
//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _weightController.dispose();
//     _bodyFatController.dispose();
//     _muscleMassController.dispose();
//     super.dispose();
//   }
//
//   void _submitProfile(BuildContext context) {
//     if (!_formKey.currentState!.validate()) return;
//
//     final params = CompleteProfileParams(
//       firstName: _firstNameController.text.trim(),
//       lastName: _lastNameController.text.trim(),
//       gender: _gender!,
//       weightKg: _weightController.text.isNotEmpty
//           ? double.tryParse(_weightController.text)
//           : null,
//       bodyFatPercent: _bodyFatController.text.isNotEmpty
//           ? double.tryParse(_bodyFatController.text)
//           : null,
//       muscleMassKg: _muscleMassController.text.isNotEmpty
//           ? double.tryParse(_muscleMassController.text)
//           : null,
//     );
//     context.read<CompleteProfileCubit>().submitProfile(params);
//   }
//
//   // 👇 NEW: Helper method for role-based navigation
//   String _getHomeRouteForProfile(LoginProfileModel? profile) {
//     if (profile == null) {
//       dev.log(
//         '⚠️ No profile data, defaulting to user home',
//         name: 'CompleteProfileScreen',
//       );
//       return Routes.userHostScreen;
//     }
//
//     if (profile.isUser) {
//       return Routes.userHostScreen;
//     } else if (profile.isTrainer) {
//       return Routes.trainerHostScreen;
//     } else {
//       // Fallback
//       dev.log(
//         '⚠️ Unknown role (${profile.role}), defaulting to user home',
//         name: 'CompleteProfileScreen',
//       );
//       return Routes.userHostScreen;
//     }
//   }
//
//   String? _validateRequired(String? value, String field) {
//     if (value == null || value.trim().isEmpty) {
//       return '$field is required';
//     }
//     return null;
//   }
//
//   String? _validateGender() {
//     if (_gender == null) return 'Gender is required';
//     if (_gender != "Male" && _gender != "Female") {
//       return 'Select Male or Female';
//     }
//     return null;
//   }
//
//   String? _validateWeight(String? value) {
//     if (value == null || value.trim().isEmpty) return null;
//     final num? weight = num.tryParse(value);
//     if (weight == null || weight <= 0) return 'Enter a valid weight in kg';
//     if (weight > 700) return 'Please check the weight entered';
//     return null;
//   }
//
//   String? _validateBodyFat(String? value) {
//     if (value == null || value.trim().isEmpty) return null;
//     final num? fat = num.tryParse(value);
//     if (fat == null) return 'Enter a number';
//     if (fat < 1 || fat > 70) return 'Enter realistic % fat (1-70)';
//     return null;
//   }
//
//   String? _validateMuscleMass(String? value) {
//     if (value == null || value.trim().isEmpty) return null;
//     final num? mass = num.tryParse(value);
//     if (mass == null || mass <= 0) return 'Enter a valid muscle mass (kg)';
//     if (mass > 250) return 'Please check muscle mass entered';
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<CompleteProfileCubit, CompleteProfileState>(
//       listener: (context, state) {
//         if (state.isSuccess) {
//           // 👇 Access profile from state
//           final profile = state.userProfile;
//
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Profile completed! Welcome to Fitrix, ${profile?.firstName ?? "User"}!',
//               ),
//               backgroundColor: ColorsManager.primaryGreen,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//
//           Future.delayed(const Duration(milliseconds: 500), () {
//             if (context.mounted) {
//               // 👇 Use dynamic role from profile
//               final route = _getHomeRouteForProfile(profile);
//
//               dev.log(
//                 '🎯 Profile completed for ${profile?.roleString ?? "Unknown"} (${profile?.firstName} ${profile?.lastName})',
//                 name: 'CompleteProfileScreen',
//               );
//               dev.log(
//                 '🚀 Navigating to: $route',
//                 name: 'CompleteProfileScreen',
//               );
//
//               Navigator.of(
//                 context,
//               ).pushNamedAndRemoveUntil(route, (route) => false);
//             }
//           });
//         } else if (state.errorMessage != null) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Row(
//                 children: [
//                   const Icon(Icons.error_outline, color: Colors.white),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       state.errorMessage!,
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//               backgroundColor: Colors.red,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: ColorsManager.scaffoldBackground,
//         body: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   const PulsingFitnessIcon(),
//                   const SizedBox(height: 24),
//                   Text('Complete Profile', style: TextStyles.headline2),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Let\'s set up your fitness journey',
//                     style: TextStyles.subtitle2,
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 32),
//                   CustomTextField(
//                     controller: _firstNameController,
//                     label: 'First Name',
//                     prefixIcon: Icons.person,
//                     validator: (v) => _validateRequired(v, 'First name'),
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextField(
//                     controller: _lastNameController,
//                     label: 'Last Name',
//                     prefixIcon: Icons.person_outline,
//                     validator: (v) => _validateRequired(v, 'Last name'),
//                   ),
//                   const SizedBox(height: 16),
//                   GenderSelector(
//                     selected: _gender,
//                     onChanged: (g) => setState(() => _gender = g),
//                   ),
//                   if (_validateGender() != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           _validateGender()!,
//                           style: const TextStyle(
//                             color: Colors.red,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),
//                     ),
//                   const SizedBox(height: 16),
//                   CustomTextField(
//                     controller: _weightController,
//                     label: 'Weight (kg)',
//                     prefixIcon: Icons.monitor_weight_outlined,
//                     keyboardType: TextInputType.number,
//                     validator: _validateWeight,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextField(
//                     controller: _bodyFatController,
//                     label: 'Body Fat %',
//                     prefixIcon: Icons.percent,
//                     keyboardType: TextInputType.number,
//                     validator: _validateBodyFat,
//                   ),
//                   const SizedBox(height: 16),
//                   CustomTextField(
//                     controller: _muscleMassController,
//                     label: 'Muscle Mass (kg)',
//                     prefixIcon: Icons.fitness_center,
//                     keyboardType: TextInputType.number,
//                     validator: _validateMuscleMass,
//                   ),
//                   const SizedBox(height: 32),
//                   BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
//                     builder: (context, state) {
//                       return CustomButton(
//                         text: 'Complete Profile',
//                         icon: Icons.check,
//                         isLoading: state.isLoading,
//                         onPressed: state.isLoading
//                             ? null
//                             : () {
//                                 setState(() {}); // validate gender error
//                                 if (_formKey.currentState!.validate() &&
//                                     _validateGender() == null) {
//                                   _submitProfile(context);
//                                 }
//                               },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
      backgroundColor: ColorsManager.scaffoldBackground,
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
