import 'package:fitrix/features/profile/presentation/widgets/update_profile_widgets/personal_info_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/data/models/params/update_profile_params.dart';
import '../../cubits/update_profile_cubit/update_profile_cubit.dart';
import '../../cubits/update_profile_cubit/update_profile_state.dart';
import 'measurements_section.dart';
import 'section_reorder_bottom_sheet.dart';
import 'update_profile_form_controller.dart';

// class UpdateProfileForm extends StatefulWidget {
//   final GlobalKey<FormState> formKey;
//   final UpdateProfileFormController controller;
//
//   const UpdateProfileForm({
//     super.key,
//     required this.formKey,
//     required this.controller,
//   });
//
//   @override
//   State<UpdateProfileForm> createState() => _UpdateProfileFormState();
// }
//
// class _UpdateProfileFormState extends State<UpdateProfileForm> {
//   final _validators = UpdateProfileValidators();
//
//   // ✅ Section order and expansion state
//   List<String> _sectionOrder = ['personal', 'measurements'];
//   Map<String, bool> _expandedSections = {
//     'personal': true,
//     'measurements': true,
//   };
//
//   void _submitProfile() {
//     if (!widget.formKey.currentState!.validate()) return;
//
//     final formData = widget.controller.getFormData();
//
//     int genderInt = 1;
//     if (widget.controller.selectedGender == 'Female') {
//       genderInt = 2;
//     }
//
//     final params = UpdateProfileParams(
//       firstName: formData['firstName'] as String,
//       lastName: formData['lastName'] as String,
//       gender: genderInt,
//       phoneNumber: formData['phoneNumber'] as String?,
//       birthDate: formData['birthDate'] as DateTime?,
//       heightCm: formData['heightCm'] != null
//           ? (formData['heightCm'] as double).toInt()
//           : null,
//       weightKg: formData['weightKg'] as double?,
//       bodyFatPercent: formData['bodyFatPercent'] as double?,
//       muscleMassKg: formData['muscleMassKg'] as double?,
//       weightGoal: formData['weightGoal'] as double?,
//       bodyFatGoal: formData['bodyFatGoal'] as double?,
//       muscleMassGoal: formData['muscleMassGoal'] as double?,
//     );
//
//     context.read<UpdateProfileCubit>().updateProfile(params);
//   }
//
//   // ✅ Show reorder modal
//   void _showReorderModal(S s) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: ColorsManager.cardBackground,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (context) => ReorderSectionsModal(
//         sectionOrder: _sectionOrder,
//         onReorder: (newOrder) {
//           setState(() {
//             _sectionOrder = newOrder;
//           });
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Form(
//       key: widget.formKey,
//       child: Column(
//         children: [
//           // ✅ Reorder button
//           OutlinedButton.icon(
//             onPressed: () => _showReorderModal(s),
//             icon: Icon(Icons.reorder, size: 20.sp),
//             label: Text(s.reorder_sections),
//             style: OutlinedButton.styleFrom(
//               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//               side: BorderSide(color: ColorsManager.primaryGreen, width: 1.5),
//               foregroundColor: ColorsManager.primaryGreen,
//             ),
//           ),
//           SizedBox(height: 16.h),
//
//           // ✅ Collapsible sections
//           ..._sectionOrder.map((sectionKey) {
//             return _buildCollapsibleSection(sectionKey, s);
//           }).toList(),
//
//           SizedBox(height: 32.h),
//
//           BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
//             builder: (context, state) {
//               return CustomButton(
//                 text: s.saveChanges,
//                 icon: Icons.save,
//                 isLoading: state.isLoading,
//                 onPressed: state.isLoading
//                     ? null
//                     : () {
//                         setState(() {}); // Trigger validation
//                         if (widget.formKey.currentState!.validate() &&
//                             _validators.validateGender(
//                                   widget.controller.selectedGender,
//                                   context,
//                                 ) ==
//                                 null) {
//                           _submitProfile();
//                         }
//                       },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ✅ Build collapsible section
//   Widget _buildCollapsibleSection(String sectionKey, S s) {
//     final isExpanded = _expandedSections[sectionKey] ?? true;
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.h),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(12.r),
//         border: Border.all(
//           color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
//           width: 1,
//         ),
//         boxShadow: ColorsManager.softShadow,
//       ),
//       child: Column(
//         children: [
//           // ✅ Section header (collapsible)
//           InkWell(
//             onTap: () {
//               setState(() {
//                 _expandedSections[sectionKey] = !isExpanded;
//               });
//             },
//             borderRadius: BorderRadius.vertical(
//               top: Radius.circular(12.r),
//               bottom: isExpanded ? Radius.zero : Radius.circular(12.r),
//             ),
//             child: Container(
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(12.r),
//                   bottom: isExpanded ? Radius.zero : Radius.circular(12.r),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     _getSectionIcon(sectionKey),
//                     color: ColorsManager.primaryGreen,
//                     size: 24.sp,
//                   ),
//                   SizedBox(width: 12.w),
//                   Expanded(
//                     child: Text(
//                       _getSectionTitle(sectionKey, s),
//                       style: TextStyles.font16PrimaryTextSemiBold.copyWith(
//                         color: ColorsManager.primaryGreen,
//                       ),
//                     ),
//                   ),
//                   AnimatedRotation(
//                     turns: isExpanded ? 0.5 : 0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Icon(
//                       Icons.keyboard_arrow_down,
//                       color: ColorsManager.primaryGreen,
//                       size: 24.sp,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           // ✅ Section content (animated)
//           AnimatedSize(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             child: isExpanded
//                 ? Padding(
//                     padding: EdgeInsets.all(16.w),
//                     child: _getSectionContent(sectionKey, s),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   IconData _getSectionIcon(String sectionKey) {
//     switch (sectionKey) {
//       case 'personal':
//         return Icons.person;
//       case 'measurements':
//         return Icons.fitness_center;
//       default:
//         return Icons.label;
//     }
//   }
//
//   String _getSectionTitle(String sectionKey, S s) {
//     switch (sectionKey) {
//       case 'personal':
//         return s.personal_information;
//       case 'measurements':
//         return s.body_measurements_and_goals;
//       default:
//         return '';
//     }
//   }
//
//   Widget _getSectionContent(String sectionKey, S s) {
//     switch (sectionKey) {
//       case 'personal':
//         return _buildPersonalInfoContent(s);
//       case 'measurements':
//         return _buildMeasurementsContent(s);
//       default:
//         return const SizedBox.shrink();
//     }
//   }
//
//   // Widget _buildPersonalInfoContent(S s) {
//   //   return Column(
//   //     children: [
//   //       CustomTextField(
//   //         controller: widget.controller.firstNameController,
//   //         label: s.firstName,
//   //         hint: s.enterFirstName,
//   //         prefixIcon: Icons.person,
//   //         validator: (v) =>
//   //             _validators.validateRequired(v, s.firstName, context),
//   //       ),
//   //       SizedBox(height: 16.h),
//   //
//   //       CustomTextField(
//   //         controller: widget.controller.lastNameController,
//   //         label: s.lastName,
//   //         hint: s.enterLastName,
//   //         prefixIcon: Icons.person_outline,
//   //         validator: (v) =>
//   //             _validators.validateRequired(v, s.lastName, context),
//   //       ),
//   //       SizedBox(height: 16.h),
//   //
//   //       CustomTextField(
//   //         controller: widget.controller.phoneController,
//   //         label: s.phoneNumber,
//   //         hint: s.enterPhoneNumber,
//   //         prefixIcon: Icons.phone_outlined,
//   //         keyboardType: TextInputType.phone,
//   //         validator: (v) => _validators.validatePhone(v, context),
//   //       ),
//   //       SizedBox(height: 16.h),
//   //
//   //       GenderSelector(
//   //         selected: widget.controller.selectedGender,
//   //         onChanged: (gender) {
//   //           setState(() {
//   //             widget.controller.setGender(gender);
//   //           });
//   //         },
//   //       ),
//   //       if (_validators.validateGender(
//   //             widget.controller.selectedGender,
//   //             context,
//   //           ) !=
//   //           null)
//   //         Padding(
//   //           padding: EdgeInsets.only(top: 8.h),
//   //           child: Align(
//   //             alignment: Alignment.centerLeft,
//   //             child: Text(
//   //               _validators.validateGender(
//   //                 widget.controller.selectedGender,
//   //                 context,
//   //               )!,
//   //               style: const TextStyle(color: Colors.red, fontSize: 13),
//   //             ),
//   //           ),
//   //         ),
//   //     ],
//   //   );
//   // }
//   // ✅ Add this to _buildPersonalInfoContent
//   Widget _buildPersonalInfoContent(S s) {
//     return Column(
//       children: [
//         CustomTextField(
//           controller: widget.controller.firstNameController,
//           label: s.firstName,
//           hint: s.enterFirstName,
//           prefixIcon: Icons.person,
//           validator: (v) =>
//               _validators.validateRequired(v, s.firstName, context),
//         ),
//         SizedBox(height: 16.h),
//
//         CustomTextField(
//           controller: widget.controller.lastNameController,
//           label: s.lastName,
//           hint: s.enterLastName,
//           prefixIcon: Icons.person_outline,
//           validator: (v) =>
//               _validators.validateRequired(v, s.lastName, context),
//         ),
//         SizedBox(height: 16.h),
//
//         // ✅ ADD BIRTH DATE PICKER
//         _buildBirthDatePicker(s),
//         SizedBox(height: 16.h),
//
//         CustomTextField(
//           controller: widget.controller.phoneController,
//           label: s.phoneNumber,
//           hint: s.enterPhoneNumber,
//           prefixIcon: Icons.phone_outlined,
//           keyboardType: TextInputType.phone,
//           validator: (v) => _validators.validatePhone(v, context),
//         ),
//         SizedBox(height: 16.h),
//
//         GenderSelector(
//           selected: widget.controller.selectedGender,
//           onChanged: (gender) {
//             setState(() {
//               widget.controller.setGender(gender);
//             });
//           },
//         ),
//         if (_validators.validateGender(
//               widget.controller.selectedGender,
//               context,
//             ) !=
//             null)
//           Padding(
//             padding: EdgeInsets.only(top: 8.h),
//             child: Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 _validators.validateGender(
//                   widget.controller.selectedGender,
//                   context,
//                 )!,
//                 style: const TextStyle(color: Colors.red, fontSize: 13),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   // ✅ Birth Date Picker Widget
//   Widget _buildBirthDatePicker(S s) {
//     final selectedDate = widget.controller.selectedBirthDate;
//     final displayText = selectedDate != null
//         ? DateFormat('MMM d, yyyy').format(selectedDate)
//         : s.select_birth_date;
//
//     return GestureDetector(
//       onTap: () => _showBirthDatePicker(context),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//         decoration: BoxDecoration(
//           color: ColorsManager.cardBackground,
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: ColorsManager.primaryGreen.withOpacity(0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               Icons.cake_outlined,
//               color: ColorsManager.primaryGreen,
//               size: 22.sp,
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     s.birth_date,
//                     style: TextStyles.font12Regular.copyWith(
//                       color: ColorsManager.secondaryText,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     displayText,
//                     style: TextStyles.font14PrimaryTextMedium.copyWith(
//                       color: selectedDate != null
//                           ? ColorsManager.primaryText
//                           : ColorsManager.secondaryText,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.calendar_today_rounded,
//               color: ColorsManager.primaryGreen.withOpacity(0.7),
//               size: 20.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ Cupertino Date Picker Modal
//   void _showBirthDatePicker(BuildContext context) {
//     final s = S.of(context);
//     DateTime tempDate =
//         widget.controller.selectedBirthDate ?? DateTime(2000, 1, 1);
//
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: 350.h,
//         decoration: BoxDecoration(
//           color: ColorsManager.scaffoldBackground,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//         ),
//         child: Column(
//           children: [
//             // Header
//             Padding(
//               padding: EdgeInsets.all(16.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(s.birth_date, style: TextStyles.font18PrimaryTextBold),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text(s.cancel),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             widget.controller.setBirthDate(tempDate);
//                           });
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           s.done,
//                           style: TextStyles.font14Bold.copyWith(
//                             color: ColorsManager.primaryGreen,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Divider(height: 1, color: ColorsManager.lightText.withOpacity(0.2)),
//
//             // Cupertino Date Picker
//             Expanded(
//               child: CupertinoDatePicker(
//                 mode: CupertinoDatePickerMode.date,
//                 initialDateTime: tempDate,
//                 minimumDate: DateTime(1920, 1, 1),
//                 maximumDate: DateTime.now(),
//                 onDateTimeChanged: (DateTime newDate) {
//                   tempDate = newDate;
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Widget _buildMeasurementsContent(S s) {
//   //   return Column(
//   //     children: [
//   //       // ✅ Weight Row - Aligned by baseline
//   //       Row(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Expanded(
//   //             child: CustomTextField(
//   //               controller: widget.controller.weightController,
//   //               label: '${s.current_weight} *',
//   //               hint: s.enterWeight,
//   //               prefixIcon: Icons.monitor_weight_outlined,
//   //               keyboardType: TextInputType.number,
//   //               validator: (v) => _validators.validateWeight(v, context),
//   //             ),
//   //           ),
//   //           SizedBox(width: 12.w),
//   //           Expanded(
//   //             child: CustomTextField(
//   //               controller: widget.controller.weightGoalController,
//   //               label: s.goal_weight,
//   //               hint: s.goal,
//   //               prefixIcon: Icons.flag_outlined,
//   //               keyboardType: TextInputType.number,
//   //               validator: (v) =>
//   //                   _validators.validateWeight(v, context, isRequired: false),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //       SizedBox(height: 16.h),
//   //
//   //       CustomTextField(
//   //         controller: widget.controller.heightController,
//   //         label: s.height,
//   //         hint: s.enterHeight,
//   //         prefixIcon: Icons.height,
//   //         keyboardType: TextInputType.number,
//   //         validator: (v) => _validators.validateHeight(v, context),
//   //       ),
//   //       SizedBox(height: 16.h),
//   //
//   //       // ✅ Body Fat Row
//   //       Row(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Expanded(
//   //             child: CustomTextField(
//   //               controller: widget.controller.bodyFatController,
//   //               label: s.current_body_fat,
//   //               hint: s.enterBodyFat,
//   //               prefixIcon: Icons.percent,
//   //               keyboardType: TextInputType.number,
//   //               validator: (v) => _validators.validateBodyFat(v, context),
//   //             ),
//   //           ),
//   //           SizedBox(width: 12.w),
//   //           Expanded(
//   //             child: CustomTextField(
//   //               controller: widget.controller.bodyFatGoalController,
//   //               label: s.goal_body_fat,
//   //               hint: s.goal,
//   //               prefixIcon: Icons.trending_down,
//   //               keyboardType: TextInputType.number,
//   //               validator: (v) =>
//   //                   _validators.validateBodyFat(v, context, isRequired: false),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //       SizedBox(height: 16.h),
//   //
//   //       // ✅ Muscle Mass Row
//   //       Row(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Expanded(
//   //             child: CustomTextField(
//   //               controller: widget.controller.muscleMassController,
//   //               label: s.current_muscle_mass,
//   //               hint: s.enterMuscleMass,
//   //               prefixIcon: Icons.fitness_center,
//   //               keyboardType: TextInputType.number,
//   //               validator: (v) => _validators.validateMuscleMass(v, context),
//   //             ),
//   //           ),
//   //           SizedBox(width: 12.w),
//   //           Expanded(
//   //             child: CustomTextField(
//   //               controller: widget.controller.muscleMassGoalController,
//   //               label: s.goal_muscle_mass,
//   //               hint: s.goal,
//   //               prefixIcon: Icons.trending_up,
//   //               keyboardType: TextInputType.number,
//   //               validator: (v) => _validators.validateMuscleMass(
//   //                 v,
//   //                 context,
//   //                 isRequired: false,
//   //               ),
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ],
//   //   );
//   // }
//
//   // Widget _buildMeasurementsContent(S s) {
//   //   return Column(
//   //     children: [
//   //       // Height Slider Card
//   //       _buildHeightSliderCard(s),
//   //       SizedBox(height: 20.h),
//   //
//   //       // Weight Progress Card
//   //       _buildWeightProgressCard(s),
//   //       SizedBox(height: 20.h),
//   //
//   //       // Body Fat Dual Slider
//   //       _buildBodyFatCard(s),
//   //       SizedBox(height: 20.h),
//   //
//   //       // Muscle Mass Dual Slider
//   //       _buildMuscleMassCard(s),
//   //     ],
//   //   );
//   // }
//
//   // // ✅ Height Slider Card
//   // Widget _buildHeightSliderCard(S s) {
//   //   double currentHeight =
//   //       double.tryParse(widget.controller.heightController.text) ?? 170.0;
//   //
//   //   return Container(
//   //     padding: EdgeInsets.all(20.w),
//   //     decoration: BoxDecoration(
//   //       gradient: LinearGradient(
//   //         colors: [
//   //           ColorsManager.info.withOpacity(0.1),
//   //           ColorsManager.info.withOpacity(0.05),
//   //         ],
//   //         begin: Alignment.topLeft,
//   //         end: Alignment.bottomRight,
//   //       ),
//   //       borderRadius: BorderRadius.circular(16.r),
//   //       border: Border.all(
//   //         color: ColorsManager.info.withOpacity(0.3),
//   //         width: 1.5,
//   //       ),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: [
//   //             Container(
//   //               padding: EdgeInsets.all(10.w),
//   //               decoration: BoxDecoration(
//   //                 color: ColorsManager.info.withOpacity(0.2),
//   //                 borderRadius: BorderRadius.circular(10.r),
//   //               ),
//   //               child: Icon(
//   //                 Icons.height,
//   //                 color: ColorsManager.info,
//   //                 size: 24.sp,
//   //               ),
//   //             ),
//   //             SizedBox(width: 12.w),
//   //             Expanded(
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text(s.height, style: TextStyles.font16Bold),
//   //                   Text(
//   //                     '${currentHeight.toInt()} cm',
//   //                     style: TextStyles.font24Bold.copyWith(
//   //                       color: ColorsManager.info,
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 16.h),
//   //
//   //         // Slider
//   //         SliderTheme(
//   //           data: SliderTheme.of(context).copyWith(
//   //             activeTrackColor: ColorsManager.info,
//   //             inactiveTrackColor: ColorsManager.info.withOpacity(0.2),
//   //             thumbColor: ColorsManager.info,
//   //             overlayColor: ColorsManager.info.withOpacity(0.2),
//   //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.r),
//   //             trackHeight: 6.h,
//   //           ),
//   //           child: Slider(
//   //             value: currentHeight,
//   //             min: 100,
//   //             max: 250,
//   //             divisions: 150,
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 widget.controller.heightController.text = value
//   //                     .toInt()
//   //                     .toString();
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //
//   //         // Range labels
//   //         Row(
//   //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //           children: [
//   //             Text('100 cm', style: TextStyles.caption),
//   //             Text('250 cm', style: TextStyles.caption),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   // // ✅ Weight Progress Card with Goal Indicator
//   // Widget _buildWeightProgressCard(S s) {
//   //   double currentWeight =
//   //       double.tryParse(widget.controller.weightController.text) ?? 70.0;
//   //   double goalWeight =
//   //       double.tryParse(widget.controller.weightGoalController.text) ?? 65.0;
//   //
//   //   double progress = goalWeight > 0
//   //       ? (currentWeight / goalWeight).clamp(0.0, 2.0)
//   //       : 0.0;
//   //   bool isGaining = goalWeight > currentWeight;
//   //
//   //   return Container(
//   //     padding: EdgeInsets.all(20.w),
//   //     decoration: BoxDecoration(
//   //       gradient: LinearGradient(
//   //         colors: [
//   //           ColorsManager.primaryGreen.withOpacity(0.1),
//   //           ColorsManager.secondaryGreen.withOpacity(0.05),
//   //         ],
//   //         begin: Alignment.topLeft,
//   //         end: Alignment.bottomRight,
//   //       ),
//   //       borderRadius: BorderRadius.circular(16.r),
//   //       border: Border.all(
//   //         color: ColorsManager.primaryGreen.withOpacity(0.3),
//   //         width: 1.5,
//   //       ),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: [
//   //             Container(
//   //               padding: EdgeInsets.all(10.w),
//   //               decoration: BoxDecoration(
//   //                 gradient: ColorsManager.primaryGradient,
//   //                 borderRadius: BorderRadius.circular(10.r),
//   //               ),
//   //               child: Icon(
//   //                 Icons.monitor_weight_outlined,
//   //                 color: Colors.white,
//   //                 size: 24.sp,
//   //               ),
//   //             ),
//   //             SizedBox(width: 12.w),
//   //             Expanded(
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text(s.weight, style: TextStyles.font16Bold),
//   //                   Row(
//   //                     children: [
//   //                       Text(
//   //                         '${currentWeight.toStringAsFixed(1)} kg',
//   //                         style: TextStyles.font20Bold.copyWith(
//   //                           color: ColorsManager.primaryGreen,
//   //                         ),
//   //                       ),
//   //                       SizedBox(width: 8.w),
//   //                       Icon(
//   //                         isGaining ? Icons.trending_up : Icons.trending_down,
//   //                         color: isGaining
//   //                             ? ColorsManager.success
//   //                             : ColorsManager.warning,
//   //                         size: 20.sp,
//   //                       ),
//   //                       Text(
//   //                         ' ${s.goal}: ${goalWeight.toStringAsFixed(1)} kg',
//   //                         style: TextStyles.font13Regular.copyWith(
//   //                           color: ColorsManager.secondaryText,
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 20.h),
//   //
//   //         // Current Weight Input
//   //         Text(s.current_weight, style: TextStyles.font14Bold),
//   //         SizedBox(height: 8.h),
//   //         Row(
//   //           children: [
//   //             Expanded(
//   //               child: Container(
//   //                 decoration: BoxDecoration(
//   //                   color: Colors.white,
//   //                   borderRadius: BorderRadius.circular(12.r),
//   //                   border: Border.all(
//   //                     color: ColorsManager.primaryGreen.withOpacity(0.3),
//   //                   ),
//   //                 ),
//   //                 child: TextField(
//   //                   controller: widget.controller.weightController,
//   //                   keyboardType: TextInputType.number,
//   //                   style: TextStyles.font16Regular,
//   //                   decoration: InputDecoration(
//   //                     border: InputBorder.none,
//   //                     contentPadding: EdgeInsets.symmetric(
//   //                       horizontal: 16.w,
//   //                       vertical: 12.h,
//   //                     ),
//   //                     hintText: s.enterWeight,
//   //                     suffixText: 'kg',
//   //                   ),
//   //                   onChanged: (_) => setState(() {}),
//   //                 ),
//   //               ),
//   //             ),
//   //             SizedBox(width: 12.w),
//   //             IconButton(
//   //               onPressed: () {
//   //                 double current = currentWeight - 0.5;
//   //                 if (current >= 30) {
//   //                   widget.controller.weightController.text = current
//   //                       .toStringAsFixed(1);
//   //                   setState(() {});
//   //                 }
//   //               },
//   //               icon: Icon(
//   //                 Icons.remove_circle_outline,
//   //                 color: ColorsManager.error,
//   //               ),
//   //             ),
//   //             IconButton(
//   //               onPressed: () {
//   //                 double current = currentWeight + 0.5;
//   //                 if (current <= 300) {
//   //                   widget.controller.weightController.text = current
//   //                       .toStringAsFixed(1);
//   //                   setState(() {});
//   //                 }
//   //               },
//   //               icon: Icon(
//   //                 Icons.add_circle_outline,
//   //                 color: ColorsManager.success,
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 16.h),
//   //
//   //         // Goal Weight Input
//   //         Text(s.goal_weight, style: TextStyles.font14Bold),
//   //         SizedBox(height: 8.h),
//   //         Container(
//   //           decoration: BoxDecoration(
//   //             color: Colors.white,
//   //             borderRadius: BorderRadius.circular(12.r),
//   //             border: Border.all(
//   //               color: ColorsManager.primaryGreen.withOpacity(0.3),
//   //             ),
//   //           ),
//   //           child: TextField(
//   //             controller: widget.controller.weightGoalController,
//   //             keyboardType: TextInputType.number,
//   //             style: TextStyles.font16Regular,
//   //             decoration: InputDecoration(
//   //               border: InputBorder.none,
//   //               contentPadding: EdgeInsets.symmetric(
//   //                 horizontal: 16.w,
//   //                 vertical: 12.h,
//   //               ),
//   //               hintText: s.goal,
//   //               suffixText: 'kg',
//   //             ),
//   //             onChanged: (_) => setState(() {}),
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   // // ✅ Body Fat Dual Slider Card
//   // Widget _buildBodyFatCard(S s) {
//   //   double currentBodyFat =
//   //       double.tryParse(widget.controller.bodyFatController.text) ?? 20.0;
//   //   double goalBodyFat =
//   //       double.tryParse(widget.controller.bodyFatGoalController.text) ?? 15.0;
//   //
//   //   return Container(
//   //     padding: EdgeInsets.all(20.w),
//   //     decoration: BoxDecoration(
//   //       gradient: LinearGradient(
//   //         colors: [
//   //           ColorsManager.warning.withOpacity(0.1),
//   //           ColorsManager.warning.withOpacity(0.05),
//   //         ],
//   //         begin: Alignment.topLeft,
//   //         end: Alignment.bottomRight,
//   //       ),
//   //       borderRadius: BorderRadius.circular(16.r),
//   //       border: Border.all(
//   //         color: ColorsManager.warning.withOpacity(0.3),
//   //         width: 1.5,
//   //       ),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: [
//   //             Container(
//   //               padding: EdgeInsets.all(10.w),
//   //               decoration: BoxDecoration(
//   //                 color: ColorsManager.warning.withOpacity(0.2),
//   //                 borderRadius: BorderRadius.circular(10.r),
//   //               ),
//   //               child: Icon(
//   //                 Icons.percent,
//   //                 color: ColorsManager.warning,
//   //                 size: 24.sp,
//   //               ),
//   //             ),
//   //             SizedBox(width: 12.w),
//   //             Expanded(
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text(s.body_fat, style: TextStyles.font16Bold),
//   //                   Row(
//   //                     children: [
//   //                       Text(
//   //                         '${currentBodyFat.toStringAsFixed(1)}%',
//   //                         style: TextStyles.font20Bold.copyWith(
//   //                           color: ColorsManager.warning,
//   //                         ),
//   //                       ),
//   //                       Icon(
//   //                         Icons.arrow_forward,
//   //                         size: 16.sp,
//   //                         color: ColorsManager.secondaryText,
//   //                       ),
//   //                       Text(
//   //                         ' ${goalBodyFat.toStringAsFixed(1)}%',
//   //                         style: TextStyles.font16Regular.copyWith(
//   //                           color: ColorsManager.secondaryText,
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 20.h),
//   //
//   //         // Current Body Fat Slider
//   //         Text(s.current_body_fat, style: TextStyles.font13Regular),
//   //         SliderTheme(
//   //           data: SliderTheme.of(context).copyWith(
//   //             activeTrackColor: ColorsManager.warning,
//   //             inactiveTrackColor: ColorsManager.warning.withOpacity(0.2),
//   //             thumbColor: ColorsManager.warning,
//   //             overlayColor: ColorsManager.warning.withOpacity(0.2),
//   //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
//   //             trackHeight: 5.h,
//   //           ),
//   //           child: Slider(
//   //             value: currentBodyFat,
//   //             min: 5,
//   //             max: 50,
//   //             divisions: 45,
//   //             label: '${currentBodyFat.toStringAsFixed(1)}%',
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 widget.controller.bodyFatController.text = value
//   //                     .toStringAsFixed(1);
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //         SizedBox(height: 12.h),
//   //
//   //         // Goal Body Fat Slider
//   //         Text(s.goal_body_fat, style: TextStyles.font13Regular),
//   //         SliderTheme(
//   //           data: SliderTheme.of(context).copyWith(
//   //             activeTrackColor: ColorsManager.success,
//   //             inactiveTrackColor: ColorsManager.success.withOpacity(0.2),
//   //             thumbColor: ColorsManager.success,
//   //             overlayColor: ColorsManager.success.withOpacity(0.2),
//   //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
//   //             trackHeight: 5.h,
//   //           ),
//   //           child: Slider(
//   //             value: goalBodyFat,
//   //             min: 5,
//   //             max: 50,
//   //             divisions: 45,
//   //             label: '${goalBodyFat.toStringAsFixed(1)}%',
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 widget.controller.bodyFatGoalController.text = value
//   //                     .toStringAsFixed(1);
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//   //
//   // // ✅ Muscle Mass Dual Slider Card
//   // Widget _buildMuscleMassCard(S s) {
//   //   double currentMuscleMass =
//   //       double.tryParse(widget.controller.muscleMassController.text) ?? 30.0;
//   //   double goalMuscleMass =
//   //       double.tryParse(widget.controller.muscleMassGoalController.text) ??
//   //       35.0;
//   //
//   //   return Container(
//   //     padding: EdgeInsets.all(20.w),
//   //     decoration: BoxDecoration(
//   //       gradient: LinearGradient(
//   //         colors: [
//   //           ColorsManager.success.withOpacity(0.1),
//   //           ColorsManager.success.withOpacity(0.05),
//   //         ],
//   //         begin: Alignment.topLeft,
//   //         end: Alignment.bottomRight,
//   //       ),
//   //       borderRadius: BorderRadius.circular(16.r),
//   //       border: Border.all(
//   //         color: ColorsManager.success.withOpacity(0.3),
//   //         width: 1.5,
//   //       ),
//   //     ),
//   //     child: Column(
//   //       crossAxisAlignment: CrossAxisAlignment.start,
//   //       children: [
//   //         Row(
//   //           children: [
//   //             Container(
//   //               padding: EdgeInsets.all(10.w),
//   //               decoration: BoxDecoration(
//   //                 color: ColorsManager.success.withOpacity(0.2),
//   //                 borderRadius: BorderRadius.circular(10.r),
//   //               ),
//   //               child: Icon(
//   //                 Icons.fitness_center,
//   //                 color: ColorsManager.success,
//   //                 size: 24.sp,
//   //               ),
//   //             ),
//   //             SizedBox(width: 12.w),
//   //             Expanded(
//   //               child: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   Text(s.muscle_mass, style: TextStyles.font16Bold),
//   //                   Row(
//   //                     children: [
//   //                       Text(
//   //                         '${currentMuscleMass.toStringAsFixed(1)} kg',
//   //                         style: TextStyles.font20Bold.copyWith(
//   //                           color: ColorsManager.success,
//   //                         ),
//   //                       ),
//   //                       Icon(
//   //                         Icons.arrow_forward,
//   //                         size: 16.sp,
//   //                         color: ColorsManager.secondaryText,
//   //                       ),
//   //                       Text(
//   //                         ' ${goalMuscleMass.toStringAsFixed(1)} kg',
//   //                         style: TextStyles.font16Regular.copyWith(
//   //                           color: ColorsManager.secondaryText,
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         ),
//   //         SizedBox(height: 20.h),
//   //
//   //         // Current Muscle Mass Slider
//   //         Text(s.current_muscle_mass, style: TextStyles.font13Regular),
//   //         SliderTheme(
//   //           data: SliderTheme.of(context).copyWith(
//   //             activeTrackColor: ColorsManager.success,
//   //             inactiveTrackColor: ColorsManager.success.withOpacity(0.2),
//   //             thumbColor: ColorsManager.success,
//   //             overlayColor: ColorsManager.success.withOpacity(0.2),
//   //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
//   //             trackHeight: 5.h,
//   //           ),
//   //           child: Slider(
//   //             value: currentMuscleMass,
//   //             min: 10,
//   //             max: 80,
//   //             divisions: 70,
//   //             label: '${currentMuscleMass.toStringAsFixed(1)} kg',
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 widget.controller.muscleMassController.text = value
//   //                     .toStringAsFixed(1);
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //         SizedBox(height: 12.h),
//   //
//   //         // Goal Muscle Mass Slider
//   //         Text(s.goal_muscle_mass, style: TextStyles.font13Regular),
//   //         SliderTheme(
//   //           data: SliderTheme.of(context).copyWith(
//   //             activeTrackColor: ColorsManager.primaryGreen,
//   //             inactiveTrackColor: ColorsManager.primaryGreen.withOpacity(0.2),
//   //             thumbColor: ColorsManager.primaryGreen,
//   //             overlayColor: ColorsManager.primaryGreen.withOpacity(0.2),
//   //             thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
//   //             trackHeight: 5.h,
//   //           ),
//   //           child: Slider(
//   //             value: goalMuscleMass,
//   //             min: 10,
//   //             max: 80,
//   //             divisions: 70,
//   //             label: '${goalMuscleMass.toStringAsFixed(1)} kg',
//   //             onChanged: (value) {
//   //               setState(() {
//   //                 widget.controller.muscleMassGoalController.text = value
//   //                     .toStringAsFixed(1);
//   //               });
//   //             },
//   //           ),
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
//
//   Widget _buildMeasurementsContent(S s) {
//     return Column(
//       children: [
//         // Height Meter
//         _buildHeightMeter(s),
//         SizedBox(height: 12.h),
//
//         // Weight Dials Row
//         Row(
//           children: [
//             Expanded(child: _buildWeightDial(s)),
//             SizedBox(width: 12.w),
//             Expanded(child: _buildGoalWeightDial(s)),
//           ],
//         ),
//         SizedBox(height: 12.h),
//
//         // Body Fat & Muscle Row
//         Row(
//           children: [
//             Expanded(child: _buildBodyFatRing(s)),
//             SizedBox(width: 12.w),
//             Expanded(child: _buildMuscleMassRing(s)),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // ✅ FIXED: Weight Dial - Reduced height and better spacing
//   Widget _buildWeightDial(S s) {
//     double currentWeight =
//         double.tryParse(widget.controller.weightController.text) ?? 70.0;
//
//     return Container(
//       height: 130.h, // ✅ Reduced from 140
//       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             ColorsManager.primaryGreen.withOpacity(0.15),
//             ColorsManager.primaryGreen.withOpacity(0.05),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: ColorsManager.primaryGreen.withOpacity(0.3),
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Label with icon
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.monitor_weight_outlined,
//                 color: ColorsManager.primaryGreen,
//                 size: 16.sp,
//               ), // ✅ Smaller
//               SizedBox(width: 4.w),
//               Expanded(
//                 child: Text(
//                   s.current_weight,
//                   style: TextStyles.font11Regular.copyWith(
//                     // ✅ Smaller font
//                     color: ColorsManager.primaryText,
//                   ),
//                   overflow: TextOverflow.ellipsis, // ✅ Prevent overflow
//                   maxLines: 1,
//                 ),
//               ),
//             ],
//           ),
//
//           // Value with controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   if (currentWeight > 30) {
//                     setState(() {
//                       widget.controller.weightController.text =
//                           (currentWeight - 0.5).toStringAsFixed(1);
//                     });
//                   }
//                 },
//                 icon: Icon(
//                   Icons.remove_circle,
//                   color: ColorsManager.error,
//                   size: 22.sp,
//                 ), // ✅ Smaller
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(minWidth: 30.w, minHeight: 30.h),
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         currentWeight.toStringAsFixed(1),
//                         style: TextStyles.font24Bold.copyWith(
//                           color: ColorsManager.primaryGreen,
//                           height: 1,
//                         ),
//                       ),
//                     ),
//                     Text('kg', style: TextStyles.caption),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 8.w),
//               IconButton(
//                 onPressed: () {
//                   if (currentWeight < 300) {
//                     setState(() {
//                       widget.controller.weightController.text =
//                           (currentWeight + 0.5).toStringAsFixed(1);
//                     });
//                   }
//                 },
//                 icon: Icon(
//                   Icons.add_circle,
//                   color: ColorsManager.success,
//                   size: 22.sp,
//                 ),
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(minWidth: 30.w, minHeight: 30.h),
//               ),
//             ],
//           ),
//
//           // Hint text
//           Text(
//             'Tap +/-',
//             style: TextStyles.caption.copyWith(fontSize: 9.sp),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ✅ FIXED: Goal Weight Dial
//   Widget _buildGoalWeightDial(S s) {
//     double goalWeight =
//         double.tryParse(widget.controller.weightGoalController.text) ?? 65.0;
//
//     return Container(
//       height: 130.h,
//       padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             ColorsManager.warning.withOpacity(0.15),
//             ColorsManager.warning.withOpacity(0.05),
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.circular(16.r),
//         border: Border.all(
//           color: ColorsManager.warning.withOpacity(0.3),
//           width: 1.5,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.flag_outlined,
//                 color: ColorsManager.warning,
//                 size: 16.sp,
//               ),
//               SizedBox(width: 4.w),
//               Expanded(
//                 child: Text(
//                   s.goal_weight,
//                   style: TextStyles.font11Regular.copyWith(
//                     color: ColorsManager.primaryText,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 onPressed: () {
//                   if (goalWeight > 30) {
//                     setState(() {
//                       widget.controller.weightGoalController.text =
//                           (goalWeight - 0.5).toStringAsFixed(1);
//                     });
//                   }
//                 },
//                 icon: Icon(
//                   Icons.remove_circle,
//                   color: ColorsManager.error,
//                   size: 22.sp,
//                 ),
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(minWidth: 30.w, minHeight: 30.h),
//               ),
//               SizedBox(width: 8.w),
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         goalWeight.toStringAsFixed(1),
//                         style: TextStyles.font24Bold.copyWith(
//                           color: ColorsManager.orange,
//                           height: 1,
//                         ),
//                       ),
//                     ),
//
//                     Text('kg', style: TextStyles.caption),
//                   ],
//                 ),
//               ),
//               SizedBox(width: 8.w),
//               IconButton(
//                 onPressed: () {
//                   if (goalWeight < 300) {
//                     setState(() {
//                       widget.controller.weightGoalController.text =
//                           (goalWeight + 0.5).toStringAsFixed(1);
//                     });
//                   }
//                 },
//                 icon: Icon(
//                   Icons.add_circle,
//                   color: ColorsManager.success,
//                   size: 22.sp,
//                 ),
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(minWidth: 30.w, minHeight: 30.h),
//               ),
//             ],
//           ),
//           Text(
//             'Optional',
//             style: TextStyles.caption.copyWith(fontSize: 9.sp),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ✅ FIXED: Body Fat Ring - Better sizing
//   Widget _buildBodyFatRing(S s) {
//     double currentBodyFat =
//         double.tryParse(widget.controller.bodyFatController.text) ?? 20.0;
//     double goalBodyFat =
//         double.tryParse(widget.controller.bodyFatGoalController.text) ?? 15.0;
//
//     return GestureDetector(
//       onTap: () => _showBodyFatSliders(context, currentBodyFat, goalBodyFat),
//       child: Container(
//         height: 150.h, // ✅ Reduced from 160
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               ColorsManager.warning.withOpacity(0.12),
//               ColorsManager.warning.withOpacity(0.04),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color: ColorsManager.warning.withOpacity(0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Circular progress
//             SizedBox(
//               width: 75.w, // ✅ Reduced from 80
//               height: 75.h,
//               child: Stack(
//                 children: [
//                   SizedBox(
//                     width: 75.w,
//                     height: 75.h,
//                     child: CircularProgressIndicator(
//                       value: currentBodyFat / 50,
//                       strokeWidth: 6, // ✅ Reduced from 8
//                       backgroundColor: ColorsManager.warning.withOpacity(0.2),
//                       valueColor: AlwaysStoppedAnimation(ColorsManager.orange),
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             '${currentBodyFat.toStringAsFixed(1)}%',
//                             style: TextStyles.font16Bold.copyWith(
//                               color: ColorsManager.orange,
//                               height: 1,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           'Body Fat',
//                           style: TextStyles.caption.copyWith(fontSize: 10.sp),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10.h),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.trending_down,
//                   color: ColorsManager.success,
//                   size: 12.sp,
//                 ),
//                 SizedBox(width: 4.w),
//                 Expanded(
//                   child: Text(
//                     'Goal: ${goalBodyFat.toStringAsFixed(1)}%',
//                     style: TextStyles.caption.copyWith(
//                       fontSize: 10.sp,
//                       color: Colors.black,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               'Tap to edit',
//               style: TextStyles.caption.copyWith(fontSize: 9.sp),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ FIXED: Muscle Mass Ring
//   Widget _buildMuscleMassRing(S s) {
//     double currentMuscleMass =
//         double.tryParse(widget.controller.muscleMassController.text) ?? 30.0;
//     double goalMuscleMass =
//         double.tryParse(widget.controller.muscleMassGoalController.text) ??
//         35.0;
//
//     return GestureDetector(
//       onTap: () =>
//           _showMuscleMassSliders(context, currentMuscleMass, goalMuscleMass),
//       child: Container(
//         height: 150.h,
//         padding: EdgeInsets.all(12.w),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               ColorsManager.success.withOpacity(0.12),
//               ColorsManager.success.withOpacity(0.04),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color: ColorsManager.success.withOpacity(0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: 75.w,
//               height: 75.h,
//               child: Stack(
//                 children: [
//                   SizedBox(
//                     width: 75.w,
//                     height: 75.h,
//                     child: CircularProgressIndicator(
//                       value: currentMuscleMass / 80,
//                       strokeWidth: 6,
//                       backgroundColor: ColorsManager.success.withOpacity(0.2),
//                       valueColor: AlwaysStoppedAnimation(ColorsManager.success),
//                     ),
//                   ),
//                   Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         FittedBox(
//                           fit: BoxFit.scaleDown,
//                           child: Text(
//                             currentMuscleMass.toStringAsFixed(1),
//                             style: TextStyles.font16Bold.copyWith(
//                               color: ColorsManager.success,
//                               height: 1,
//                             ),
//                           ),
//                         ),
//                         Text(
//                           'kg Muscle',
//                           style: TextStyles.caption.copyWith(fontSize: 10.sp),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 10.h),
//
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.trending_up,
//                   color: ColorsManager.primaryGreen,
//                   size: 12.sp,
//                 ),
//                 SizedBox(width: 4.w),
//                 Expanded(
//                   child: Text(
//                     'Goal: ${goalMuscleMass.toStringAsFixed(1)} kg',
//                     style: TextStyles.caption.copyWith(
//                       fontSize: 10.sp,
//                       color: Colors.black,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               'Tap to edit',
//               style: TextStyles.caption.copyWith(fontSize: 9.sp),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ 1. HEIGHT METER - Vertical Ruler Style Picker
//   Widget _buildHeightMeter(S s) {
//     double currentHeight =
//         double.tryParse(widget.controller.heightController.text) ?? 170.0;
//
//     return GestureDetector(
//       onTap: () => _showHeightPicker(context, currentHeight),
//       child: Container(
//         height: 90.h,
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               ColorsManager.info.withOpacity(0.15),
//               ColorsManager.info.withOpacity(0.05),
//             ],
//           ),
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color: ColorsManager.info.withOpacity(0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Icon side
//             Container(
//               width: 50.w,
//               decoration: BoxDecoration(
//                 color: ColorsManager.info.withValues(alpha: 0.2),
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.height, color: ColorsManager.info, size: 28.sp),
//                   SizedBox(height: 4.h),
//                   Text('cm', style: TextStyles.caption),
//                 ],
//               ),
//             ),
//             SizedBox(width: 16.w),
//
//             // Value display
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(s.height, style: TextStyles.font13Regular),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         '${currentHeight.toInt()}',
//                         style: TextStyles.font32Bold.copyWith(
//                           color: ColorsManager.info,
//                           height: 1,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 6.h, left: 4.w),
//                         child: Text(
//                           'cm',
//                           style: TextStyles.font14Regular.copyWith(
//                             color: ColorsManager.secondaryText,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // Tap indicator
//             Icon(
//               Icons.edit_outlined,
//               color: ColorsManager.secondaryText,
//               size: 20.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showHeightPicker(BuildContext context, double currentHeight) {
//     var screenHeight = MediaQuery.of(context).size.height;
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: screenHeight * 0.55, // ✅ Adjusted height to 60% of screen
//         decoration: BoxDecoration(
//           color: ColorsManager.scaffoldBackground,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//         ),
//         child: Column(
//           children: [
//             // Header
//             Padding(
//               padding: EdgeInsets.all(16.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     S.of(context).height,
//                     style: TextStyles.font18PrimaryTextBold,
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Cupertino-style picker
//             Expanded(
//               child: CupertinoPicker(
//                 scrollController: FixedExtentScrollController(
//                   initialItem: (currentHeight - 100).toInt(),
//                 ),
//                 itemExtent: 50.h,
//                 onSelectedItemChanged: (index) {
//                   setState(() {
//                     widget.controller.heightController.text = (index + 100)
//                         .toString();
//                   });
//                 },
//                 children: List.generate(151, (index) {
//                   final height = index + 100;
//                   return Center(
//                     child: Text(
//                       '$height cm',
//                       style: TextStyles.font20PrimaryTextBold,
//                     ),
//                   );
//                 }),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ✅ FIXED: Body Fat Modal - No Overflow
//   void _showBodyFatSliders(
//     BuildContext context,
//     double currentBodyFat,
//     double goalBodyFat,
//   ) {
//     double tempCurrent = currentBodyFat;
//     double tempGoal = goalBodyFat;
//     var screenHeight = MediaQuery.of(context).size.height;
//
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setModalState) => Container(
//           height: screenHeight * 0.55, // ✅ Adjusted height to 60% of screen
//           decoration: BoxDecoration(
//             color: ColorsManager.scaffoldBackground,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//           ),
//           child: Column(
//             children: [
//               // Header
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       S.of(context).body_fat,
//                       style: TextStyles.font18PrimaryTextBold,
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text(S.of(context).cancel),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               widget.controller.bodyFatController.text =
//                                   tempCurrent.toStringAsFixed(1);
//                               widget.controller.bodyFatGoalController.text =
//                                   tempGoal.toStringAsFixed(1);
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             S.of(context).done,
//                             style: TextStyles.font14Bold.copyWith(
//                               color: ColorsManager.primaryGreen,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Divider(
//                 height: 1,
//                 color: ColorsManager.lightText.withOpacity(0.2),
//               ),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   // ✅ Added scrolling
//                   padding: EdgeInsets.all(20.w),
//                   child: Column(
//                     children: [
//                       // Current Body Fat
//                       Container(
//                         padding: EdgeInsets.all(16.w), // ✅ Reduced from 20
//                         decoration: BoxDecoration(
//                           color: ColorsManager.warning.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(16.r),
//                           border: Border.all(
//                             color: ColorsManager.warning.withOpacity(0.3),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   // ✅ Added Expanded
//                                   child: Text(
//                                     S.of(context).current_body_fat,
//                                     style: TextStyles.font12Bold,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Text(
//                                   '${tempCurrent.toStringAsFixed(1)}%',
//                                   style: TextStyles.font20Bold.copyWith(
//                                     // ✅ Reduced from 24
//                                     color: ColorsManager.warning,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.h),
//                             SliderTheme(
//                               data: SliderTheme.of(context).copyWith(
//                                 activeTrackColor: ColorsManager.warning,
//                                 inactiveTrackColor: ColorsManager.warning
//                                     .withOpacity(0.2),
//                                 thumbColor: ColorsManager.warning,
//                                 overlayColor: ColorsManager.warning.withOpacity(
//                                   0.2,
//                                 ),
//                                 thumbShape: RoundSliderThumbShape(
//                                   enabledThumbRadius: 10.r,
//                                 ),
//                                 trackHeight: 5.h,
//                               ),
//                               child: Slider(
//                                 value: tempCurrent,
//                                 min: 5,
//                                 max: 50,
//                                 divisions: 45,
//                                 onChanged: (value) {
//                                   setModalState(() {
//                                     tempCurrent = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('5%', style: TextStyles.caption),
//                                 Text('50%', style: TextStyles.caption),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//
//                       // Goal Body Fat
//                       Container(
//                         padding: EdgeInsets.all(16.w),
//                         decoration: BoxDecoration(
//                           color: ColorsManager.success.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(16.r),
//                           border: Border.all(
//                             color: ColorsManager.success.withOpacity(0.3),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     S.of(context).goal_body_fat,
//                                     style: TextStyles.font12Bold,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Text(
//                                   '${tempGoal.toStringAsFixed(1)}%',
//                                   style: TextStyles.font20Bold.copyWith(
//                                     color: ColorsManager.success,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.h),
//                             SliderTheme(
//                               data: SliderTheme.of(context).copyWith(
//                                 activeTrackColor: ColorsManager.success,
//                                 inactiveTrackColor: ColorsManager.success
//                                     .withOpacity(0.2),
//                                 thumbColor: ColorsManager.success,
//                                 overlayColor: ColorsManager.success.withOpacity(
//                                   0.2,
//                                 ),
//                                 thumbShape: RoundSliderThumbShape(
//                                   enabledThumbRadius: 10.r,
//                                 ),
//                                 trackHeight: 5.h,
//                               ),
//                               child: Slider(
//                                 value: tempGoal,
//                                 min: 5,
//                                 max: 50,
//                                 divisions: 45,
//                                 onChanged: (value) {
//                                   setModalState(() {
//                                     tempGoal = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('5%', style: TextStyles.caption),
//                                 Text('50%', style: TextStyles.caption),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ✅ FIXED: Muscle Mass Modal - No Overflow
//   void _showMuscleMassSliders(
//     BuildContext context,
//     double currentMuscleMass,
//     double goalMuscleMass,
//   ) {
//     double tempCurrent = currentMuscleMass;
//     double tempGoal = goalMuscleMass;
//     var screenHeight = MediaQuery.of(context).size.height;
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setModalState) => Container(
//           height: screenHeight * 0.55, // ✅ Adjusted height to 60% of screen
//           decoration: BoxDecoration(
//             color: ColorsManager.scaffoldBackground,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//           ),
//           child: Column(
//             children: [
//               // Header
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       S.of(context).muscle_mass,
//                       style: TextStyles.font18PrimaryTextBold,
//                     ),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: Text(S.of(context).cancel),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             setState(() {
//                               widget.controller.muscleMassController.text =
//                                   tempCurrent.toStringAsFixed(1);
//                               widget.controller.muscleMassGoalController.text =
//                                   tempGoal.toStringAsFixed(1);
//                             });
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             S.of(context).done,
//                             style: TextStyles.font14Bold.copyWith(
//                               color: ColorsManager.primaryGreen,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Divider(
//                 height: 1,
//                 color: ColorsManager.lightText.withOpacity(0.2),
//               ),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(20.w),
//                   child: Column(
//                     children: [
//                       // Current Muscle Mass
//                       Container(
//                         padding: EdgeInsets.all(16.w),
//                         decoration: BoxDecoration(
//                           color: ColorsManager.success.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(16.r),
//                           border: Border.all(
//                             color: ColorsManager.success.withOpacity(0.3),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     S.of(context).current_muscle_mass,
//                                     style: TextStyles.font12Bold,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Text(
//                                   '${tempCurrent.toStringAsFixed(1)} kg',
//                                   style: TextStyles.font20Bold.copyWith(
//                                     color: ColorsManager.success,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.h),
//                             SliderTheme(
//                               data: SliderTheme.of(context).copyWith(
//                                 activeTrackColor: ColorsManager.success,
//                                 inactiveTrackColor: ColorsManager.success
//                                     .withOpacity(0.2),
//                                 thumbColor: ColorsManager.success,
//                                 overlayColor: ColorsManager.success.withOpacity(
//                                   0.2,
//                                 ),
//                                 thumbShape: RoundSliderThumbShape(
//                                   enabledThumbRadius: 10.r,
//                                 ),
//                                 trackHeight: 5.h,
//                               ),
//                               child: Slider(
//                                 value: tempCurrent,
//                                 min: 10,
//                                 max: 80,
//                                 divisions: 70,
//                                 onChanged: (value) {
//                                   setModalState(() {
//                                     tempCurrent = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('10 kg', style: TextStyles.caption),
//                                 Text('80 kg', style: TextStyles.caption),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//
//                       // Goal Muscle Mass
//                       Container(
//                         padding: EdgeInsets.all(16.w),
//                         decoration: BoxDecoration(
//                           color: ColorsManager.primaryGreen.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(16.r),
//                           border: Border.all(
//                             color: ColorsManager.primaryGreen.withOpacity(0.3),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     S.of(context).goal_muscle_mass,
//                                     style: TextStyles.font12Bold,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Text(
//                                   '${tempGoal.toStringAsFixed(1)} kg',
//                                   style: TextStyles.font20Bold.copyWith(
//                                     color: ColorsManager.primaryGreen,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10.h),
//                             SliderTheme(
//                               data: SliderTheme.of(context).copyWith(
//                                 activeTrackColor: ColorsManager.primaryGreen,
//                                 inactiveTrackColor: ColorsManager.primaryGreen
//                                     .withOpacity(0.2),
//                                 thumbColor: ColorsManager.primaryGreen,
//                                 overlayColor: ColorsManager.primaryGreen
//                                     .withOpacity(0.2),
//                                 thumbShape: RoundSliderThumbShape(
//                                   enabledThumbRadius: 10.r,
//                                 ),
//                                 trackHeight: 5.h,
//                               ),
//                               child: Slider(
//                                 value: tempGoal,
//                                 min: 10,
//                                 max: 80,
//                                 divisions: 70,
//                                 onChanged: (value) {
//                                   setModalState(() {
//                                     tempGoal = value;
//                                   });
//                                 },
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('10 kg', style: TextStyles.caption),
//                                 Text('80 kg', style: TextStyles.caption),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'profile_tutorial.dart';
import 'dart:convert';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/common_ui/widgets/custom_button.dart';
import 'update_profile_validators.dart';

class UpdateProfileForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final UpdateProfileFormController controller;

  const UpdateProfileForm({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  State<UpdateProfileForm> createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  // Tutorial keys
  final GlobalKey _heightKey = GlobalKey();
  final GlobalKey _weightKey = GlobalKey();
  final GlobalKey _bodyFatKey = GlobalKey();
  final GlobalKey _muscleMassKey = GlobalKey();

  TutorialCoachMark? _tutorialCoachMark;
  final _validators = UpdateProfileValidators();

  // Section order and expansion state
  List<String> _sectionOrder = ['personal', 'measurements'];
  final Map<String, bool> _expandedSections = {
    'personal': true,
    'measurements': true,
  };

  static const String _sectionOrderKey = 'profile_section_order';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadSectionOrder();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _loadSectionOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedOrder = prefs.getString(_sectionOrderKey);

    if (savedOrder != null) {
      final List<dynamic> decoded = jsonDecode(savedOrder);
      setState(() {
        _sectionOrder = decoded.cast<String>();
      });
    }
  }

  Future<void> _saveSectionOrder() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sectionOrderKey, jsonEncode(_sectionOrder));
  }

  Future<void> _checkAndShowTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenTutorial = prefs.getBool('has_seen_profile_tutorial') ?? false;

    if (!hasSeenTutorial) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) _showTutorial();
      });
    }
  }

  void _showTutorial() async {
    // ✅ Simply ensure measurements section is expanded
    setState(() {
      _expandedSections['measurements'] = true;
    });

    // Wait for rebuild
    await Future.delayed(const Duration(milliseconds: 400));

    _tutorialCoachMark = ProfileTutorial.createTutorial(
      context: context,
      heightKey: _heightKey,
      weightKey: _weightKey,
      bodyFatKey: _bodyFatKey,
      muscleMassKey: _muscleMassKey,
      onFinish: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('has_seen_profile_tutorial', true);
      },
    );
    _tutorialCoachMark?.show(context: context);
  }

  void _showReorderBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SectionReorderBottomSheet(
        currentOrder: _sectionOrder,
        onReorder: (newOrder) {
          setState(() {
            _sectionOrder = newOrder;
          });
          _saveSectionOrder();
        },
      ),
    );
  }

  void _submitProfile() {
    if (!widget.formKey.currentState!.validate()) return;

    final formData = widget.controller.getFormData();

    // Convert gender string to int
    int genderInt = 1; // Male
    if (widget.controller.selectedGender == 'Female') {
      genderInt = 2;
    }

    final params = UpdateProfileParams(
      firstName: formData['firstName'] as String,
      lastName: formData['lastName'] as String,
      gender: genderInt,
      phoneNumber: formData['phoneNumber'] as String?,
      birthDate: formData['birthDate'] as DateTime?,
      heightCm: formData['heightCm'] != null
          ? (formData['heightCm'] as double).toInt()
          : null,
      weightKg: formData['weightKg'] as double?,
      weightGoal: formData['goalWeightKg'] as double?,
      bodyFatPercent: formData['bodyFatPercentage'] as double?,
      bodyFatGoal: formData['goalBodyFatPercentage'] as double?,
      muscleMassKg: formData['muscleMassKg'] as double?,
      muscleMassGoal: formData['goalMuscleMassKg'] as double?,
    );

    context.read<UpdateProfileCubit>().updateProfile(params);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // Reorder Button
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: OutlinedButton.icon(
              onPressed: _showReorderBottomSheet,
              icon: const Icon(Icons.swap_vert),
              label: Text(s.reorder_sections),
              style: OutlinedButton.styleFrom(
                foregroundColor: ColorsManager.primaryGreen,
                side: BorderSide(color: ColorsManager.primaryGreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              ),
            ),
          ),

          // Sections
          ..._sectionOrder.map((section) => _buildSection(section, s)),

          // Submit Button
          SizedBox(height: 24.h),
          BlocBuilder<UpdateProfileCubit, UpdateProfileState>(
            builder: (context, state) {
              return CustomButton(
                text: s.saveChanges,
                icon: Icons.save,
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
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSection(String section, S s) {
    return Container(
      key: ValueKey(section),
      margin: EdgeInsets.only(bottom: 16.h),
      child: ExpansionTile(
        initiallyExpanded: _expandedSections[section] ?? true,
        onExpansionChanged: (expanded) {
          setState(() => _expandedSections[section] = expanded);
        },
        title: Text(
          _getSectionTitle(section, s),
          style: TextStyles.font18PrimaryTextBold,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (section == 'measurements')
              // IconButton(
              //   icon: const Icon(Icons.help_outline),
              //   onPressed: _showTutorial,
              //   tooltip: s.show_tutorial,
              // ),
              Icon(
                _expandedSections[section] ?? true
                    ? Icons.expand_less
                    : Icons.expand_more,
              ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _getSectionContent(section),
          ),
        ],
      ),
    );
  }

  String _getSectionTitle(String section, S s) {
    switch (section) {
      case 'personal':
        return s.personal_information;
      case 'measurements':
        return s.body_measurements_and_goals;
      default:
        return '';
    }
  }

  Widget _getSectionContent(String section) {
    switch (section) {
      case 'personal':
        return PersonalInfoSection(controller: widget.controller);
      case 'measurements':
        return MeasurementsSection(
          controller: widget.controller,
          heightKey: _heightKey,
          weightKey: _weightKey,
          bodyFatKey: _bodyFatKey,
          muscleMassKey: _muscleMassKey,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tutorialCoachMark?.finish();
    super.dispose();
  }
}
