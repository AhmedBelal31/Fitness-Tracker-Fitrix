import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../../core/theming/app_colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../auth/presentation/widgets/complete_profile_widgets/gender_selector.dart'
    show GenderSelector;
import 'update_profile_form_controller.dart';
import 'update_profile_validators.dart';

class PersonalInfoSection extends StatefulWidget {
  final UpdateProfileFormController controller;

  const PersonalInfoSection({super.key, required this.controller});

  @override
  State<PersonalInfoSection> createState() => _PersonalInfoSectionState();
}

class _PersonalInfoSectionState extends State<PersonalInfoSection> {
  final _validators = UpdateProfileValidators();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        // First Name
        CustomTextField(
          controller: widget.controller.firstNameController,
          label: s.firstName,
          hint: s.enterFirstName,
          prefixIcon: Icons.person,
          validator: (v) =>
              _validators.validateRequired(v, s.firstName, context),
        ),
        SizedBox(height: 16.h),

        // Last Name
        CustomTextField(
          controller: widget.controller.lastNameController,
          label: s.lastName,
          hint: s.enterLastName,
          prefixIcon: Icons.person_outline,
          validator: (v) =>
              _validators.validateRequired(v, s.lastName, context),
        ),
        SizedBox(height: 16.h),

        // Birth Date Picker
        _buildBirthDatePicker(s),
        SizedBox(height: 16.h),

        // Phone Number
        CustomTextField(
          controller: widget.controller.phoneController,
          label: s.phoneNumber,
          hint: s.enterPhoneNumber,
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) => _validators.validatePhone(v, context),
        ),
        SizedBox(height: 16.h),

        // Gender Selector
        GenderSelector(
          selected: widget.controller.selectedGender,
          onChanged: (gender) {
            setState(() {
              widget.controller.setGender(gender);
            });
          },
        ),

        // Gender Validation Error
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
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildBirthDatePicker(S s) {
    final selectedDate = widget.controller.selectedBirthDate;
    final displayText = selectedDate != null
        ? DateFormat('MMM d, yyyy').format(selectedDate)
        : s.select_birth_date;

    return GestureDetector(
      onTap: () => _showBirthDatePicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.cake_outlined,
              color: ColorsManager.primaryGreen,
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.birth_date,
                    style: TextStyles.font12Regular.copyWith(
                      color: ColorsManager.secondaryText,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    displayText,
                    style: TextStyles.font14PrimaryTextMedium.copyWith(
                      color: selectedDate != null
                          ? ColorsManager.primaryText
                          : ColorsManager.secondaryText,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: ColorsManager.primaryGreen.withValues(alpha: 0.7),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showBirthDatePicker(BuildContext context) {
    final s = S.of(context);
    DateTime tempDate =
        widget.controller.selectedBirthDate ?? DateTime(2000, 1, 1);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 350.h,
        decoration: BoxDecoration(
          color: ColorsManager.scaffoldBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.birth_date, style: TextStyles.font18PrimaryTextBold),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(s.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.controller.setBirthDate(tempDate);
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          s.done,
                          style: TextStyles.font14Bold.copyWith(
                            color: ColorsManager.primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: ColorsManager.lightText.withValues(alpha: 0.2),
            ),

            // Cupertino Date Picker
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                minimumDate: DateTime(1920, 1, 1),
                maximumDate: DateTime.now(),
                onDateTimeChanged: (DateTime newDate) {
                  tempDate = newDate;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
