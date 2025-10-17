import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/data/models/params/update_profile_params.dart';
import '../../../../auth/presentation/widgets/complete_profile_widgets/gender_selector.dart';
import '../../cubits/update_profile_cubit/update_profile_cubit.dart';
import '../../cubits/update_profile_cubit/update_profile_state.dart';
import 'update_profile_form_controller.dart';
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
  final _validators = UpdateProfileValidators();

  // ✅ Section order and expansion state
  List<String> _sectionOrder = ['personal', 'measurements'];
  Map<String, bool> _expandedSections = {
    'personal': true,
    'measurements': true,
  };

  void _submitProfile() {
    if (!widget.formKey.currentState!.validate()) return;

    final formData = widget.controller.getFormData();

    int genderInt = 1;
    if (widget.controller.selectedGender == 'Female') {
      genderInt = 2;
    }

    final params = UpdateProfileParams(
      firstName: formData['firstName'] as String,
      lastName: formData['lastName'] as String,
      gender: genderInt,
      phoneNumber: formData['phoneNumber'] as String?,
      heightCm: formData['heightCm'] != null
          ? (formData['heightCm'] as double).toInt()
          : null,
      weightKg: formData['weightKg'] as double?,
      bodyFatPercent: formData['bodyFatPercent'] as double?,
      muscleMassKg: formData['muscleMassKg'] as double?,
      weightGoal: formData['weightGoal'] as double?,
      bodyFatGoal: formData['bodyFatGoal'] as double?,
      muscleMassGoal: formData['muscleMassGoal'] as double?,
    );

    context.read<UpdateProfileCubit>().updateProfile(params);
  }

  // ✅ Show reorder modal
  void _showReorderModal(S s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => _ReorderSectionsModal(
        sectionOrder: _sectionOrder,
        onReorder: (newOrder) {
          setState(() {
            _sectionOrder = newOrder;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          // ✅ Reorder button
          OutlinedButton.icon(
            onPressed: () => _showReorderModal(s),
            icon: Icon(Icons.reorder, size: 20.sp),
            label: Text(s.reorder_sections),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              side: BorderSide(color: ColorsManager.primaryGreen, width: 1.5),
              foregroundColor: ColorsManager.primaryGreen,
            ),
          ),
          SizedBox(height: 16.h),

          // ✅ Collapsible sections
          ..._sectionOrder.map((sectionKey) {
            return _buildCollapsibleSection(sectionKey, s);
          }).toList(),

          SizedBox(height: 32.h),

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
        ],
      ),
    );
  }

  // ✅ Build collapsible section
  Widget _buildCollapsibleSection(String sectionKey, S s) {
    final isExpanded = _expandedSections[sectionKey] ?? true;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Column(
        children: [
          // ✅ Section header (collapsible)
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[sectionKey] = !isExpanded;
              });
            },
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12.r),
              bottom: isExpanded ? Radius.zero : Radius.circular(12.r),
            ),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12.r),
                  bottom: isExpanded ? Radius.zero : Radius.circular(12.r),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getSectionIcon(sectionKey),
                    color: ColorsManager.primaryGreen,
                    size: 24.sp,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _getSectionTitle(sectionKey, s),
                      style: TextStyles.font16PrimaryTextSemiBold.copyWith(
                        color: ColorsManager.primaryGreen,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorsManager.primaryGreen,
                      size: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ✅ Section content (animated)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Padding(
                    padding: EdgeInsets.all(16.w),
                    child: _getSectionContent(sectionKey, s),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  IconData _getSectionIcon(String sectionKey) {
    switch (sectionKey) {
      case 'personal':
        return Icons.person;
      case 'measurements':
        return Icons.fitness_center;
      default:
        return Icons.label;
    }
  }

  String _getSectionTitle(String sectionKey, S s) {
    switch (sectionKey) {
      case 'personal':
        return s.personal_information;
      case 'measurements':
        return s.body_measurements_and_goals;
      default:
        return '';
    }
  }

  Widget _getSectionContent(String sectionKey, S s) {
    switch (sectionKey) {
      case 'personal':
        return _buildPersonalInfoContent(s);
      case 'measurements':
        return _buildMeasurementsContent(s);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPersonalInfoContent(S s) {
    return Column(
      children: [
        CustomTextField(
          controller: widget.controller.firstNameController,
          label: s.firstName,
          hint: s.enterFirstName,
          prefixIcon: Icons.person,
          validator: (v) =>
              _validators.validateRequired(v, s.firstName, context),
        ),
        SizedBox(height: 16.h),

        CustomTextField(
          controller: widget.controller.lastNameController,
          label: s.lastName,
          hint: s.enterLastName,
          prefixIcon: Icons.person_outline,
          validator: (v) =>
              _validators.validateRequired(v, s.lastName, context),
        ),
        SizedBox(height: 16.h),

        CustomTextField(
          controller: widget.controller.phoneController,
          label: s.phoneNumber,
          hint: s.enterPhoneNumber,
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) => _validators.validatePhone(v, context),
        ),
        SizedBox(height: 16.h),

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
            padding: EdgeInsets.only(top: 8.h),
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
      ],
    );
  }

  // Widget _buildMeasurementsContent(S s) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Expanded(
  //             child: CustomTextField(
  //               controller: widget.controller.weightController,
  //               label: '${s.current_weight} *',
  //               hint: s.enterWeight,
  //               prefixIcon: Icons.monitor_weight_outlined,
  //               keyboardType: TextInputType.number,
  //               validator: (v) => _validators.validateWeight(v, context),
  //             ),
  //           ),
  //           SizedBox(width: 12.w),
  //           Expanded(
  //             child: CustomTextField(
  //               controller: widget.controller.weightGoalController,
  //               label: s.goal_weight,
  //               hint: s.goal,
  //               prefixIcon: Icons.flag_outlined,
  //               keyboardType: TextInputType.number,
  //               validator: (v) =>
  //                   _validators.validateWeight(v, context, isRequired: false),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 16.h),
  //
  //       CustomTextField(
  //         controller: widget.controller.heightController,
  //         label: s.height,
  //         hint: s.enterHeight,
  //         prefixIcon: Icons.height,
  //         keyboardType: TextInputType.number,
  //         validator: (v) => _validators.validateHeight(v, context),
  //       ),
  //       SizedBox(height: 16.h),
  //
  //       Row(
  //         children: [
  //           Expanded(
  //             child: CustomTextField(
  //               controller: widget.controller.bodyFatController,
  //               label: s.current_body_fat,
  //               hint: s.enterBodyFat,
  //               prefixIcon: Icons.percent,
  //               keyboardType: TextInputType.number,
  //               validator: (v) => _validators.validateBodyFat(v, context),
  //             ),
  //           ),
  //           SizedBox(width: 12.w),
  //           Expanded(
  //             child: CustomTextField(
  //               controller: widget.controller.bodyFatGoalController,
  //               label: s.goal_body_fat,
  //               hint: s.goal,
  //               prefixIcon: Icons.trending_down,
  //               keyboardType: TextInputType.number,
  //               validator: (v) =>
  //                   _validators.validateBodyFat(v, context, isRequired: false),
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(height: 16.h),
  //
  //       Row(
  //         children: [
  //           Expanded(
  //             child: CustomTextField(
  //               controller: widget.controller.muscleMassController,
  //               label: s.current_muscle_mass,
  //               hint: s.enterMuscleMass,
  //               prefixIcon: Icons.fitness_center,
  //               keyboardType: TextInputType.number,
  //               validator: (v) => _validators.validateMuscleMass(v, context),
  //             ),
  //           ),
  //           SizedBox(width: 12.w),
  //           Expanded(
  //             child: CustomTextField(
  //               controller: widget.controller.muscleMassGoalController,
  //               label: s.goal_muscle_mass,
  //               hint: s.goal,
  //               prefixIcon: Icons.trending_up,
  //               keyboardType: TextInputType.number,
  //               validator: (v) => _validators.validateMuscleMass(
  //                 v,
  //                 context,
  //                 isRequired: false,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  Widget _buildMeasurementsContent(S s) {
    return Column(
      children: [
        // ✅ Weight Row - Aligned by baseline
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                controller: widget.controller.weightController,
                label: '${s.current_weight} *',
                hint: s.enterWeight,
                prefixIcon: Icons.monitor_weight_outlined,
                keyboardType: TextInputType.number,
                validator: (v) => _validators.validateWeight(v, context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomTextField(
                controller: widget.controller.weightGoalController,
                label: s.goal_weight,
                hint: s.goal,
                prefixIcon: Icons.flag_outlined,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    _validators.validateWeight(v, context, isRequired: false),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        CustomTextField(
          controller: widget.controller.heightController,
          label: s.height,
          hint: s.enterHeight,
          prefixIcon: Icons.height,
          keyboardType: TextInputType.number,
          validator: (v) => _validators.validateHeight(v, context),
        ),
        SizedBox(height: 16.h),

        // ✅ Body Fat Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                controller: widget.controller.bodyFatController,
                label: s.current_body_fat,
                hint: s.enterBodyFat,
                prefixIcon: Icons.percent,
                keyboardType: TextInputType.number,
                validator: (v) => _validators.validateBodyFat(v, context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomTextField(
                controller: widget.controller.bodyFatGoalController,
                label: s.goal_body_fat,
                hint: s.goal,
                prefixIcon: Icons.trending_down,
                keyboardType: TextInputType.number,
                validator: (v) =>
                    _validators.validateBodyFat(v, context, isRequired: false),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),

        // ✅ Muscle Mass Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CustomTextField(
                controller: widget.controller.muscleMassController,
                label: s.current_muscle_mass,
                hint: s.enterMuscleMass,
                prefixIcon: Icons.fitness_center,
                keyboardType: TextInputType.number,
                validator: (v) => _validators.validateMuscleMass(v, context),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomTextField(
                controller: widget.controller.muscleMassGoalController,
                label: s.goal_muscle_mass,
                hint: s.goal,
                prefixIcon: Icons.trending_up,
                keyboardType: TextInputType.number,
                validator: (v) => _validators.validateMuscleMass(
                  v,
                  context,
                  isRequired: false,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ✅ Reorder Modal (Compact & Easy)
class _ReorderSectionsModal extends StatefulWidget {
  final List<String> sectionOrder;
  final Function(List<String>) onReorder;

  const _ReorderSectionsModal({
    required this.sectionOrder,
    required this.onReorder,
  });

  @override
  State<_ReorderSectionsModal> createState() => _ReorderSectionsModalState();
}

class _ReorderSectionsModalState extends State<_ReorderSectionsModal> {
  late List<String> _currentOrder;

  @override
  void initState() {
    super.initState();
    _currentOrder = List.from(widget.sectionOrder);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(s.reorder_sections, style: TextStyles.headline3),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          Text(
            s.drag_sections_instruction,
            style: TextStyles.bodySmall.copyWith(
              color: ColorsManager.lightText,
            ),
          ),
          SizedBox(height: 24.h),

          // ✅ Compact reorderable list
          ReorderableListView(
            shrinkWrap: true,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = _currentOrder.removeAt(oldIndex);
                _currentOrder.insert(newIndex, item);
              });
            },
            children: _currentOrder.asMap().entries.map((entry) {
              final index = entry.key;
              final sectionKey = entry.value;

              return _buildReorderItem(sectionKey, index + 1, s);
            }).toList(),
          ),

          SizedBox(height: 24.h),

          CustomButton(
            text: s.apply_order,
            icon: Icons.check,
            onPressed: () {
              widget.onReorder(_currentOrder);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildReorderItem(String sectionKey, int number, S s) {
    final title = sectionKey == 'personal'
        ? s.personal_information
        : s.body_measurements_and_goals;

    final icon = sectionKey == 'personal' ? Icons.person : Icons.fitness_center;

    return Container(
      key: ValueKey(sectionKey),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: ColorsManager.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: TextStyles.font16WhiteRegular,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Icon(icon, color: ColorsManager.primaryGreen, size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(title, style: TextStyles.font16PrimaryTextSemiBold),
          ),
          Icon(
            Icons.drag_handle,
            color: ColorsManager.primaryGreen,
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
