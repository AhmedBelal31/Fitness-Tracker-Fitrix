import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../../../core/theming/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        _buildBirthDatePicker(s, isDark),
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
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildBirthDatePicker(S s, bool isDark) {
    final selectedDate = widget.controller.selectedBirthDate;
    final displayText = selectedDate != null
        ? DateFormat('MMM d, yyyy').format(selectedDate)
        : s.select_birth_date;

    return GestureDetector(
      onTap: () => _showBirthDatePicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.cake_outlined,
              color: ColorsManager.getPrimaryGreen(context),
              size: 22.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.birth_date,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    displayText,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: selectedDate != null
                          ? ColorsManager.getPrimaryText(context)
                          : ColorsManager.getSecondaryText(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.calendar_today_rounded,
              color: ColorsManager.getPrimaryGreen(
                context,
              ).withValues(alpha: 0.7),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  void _showBirthDatePicker(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    DateTime tempDate =
        widget.controller.selectedBirthDate ?? DateTime(2000, 1, 1);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 350.h,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.birth_date,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          s.cancel,
                          style: TextStyle(
                            color: ColorsManager.getSecondaryText(context),
                          ),
                        ),
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
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryGreen(context),
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
              color: (isDark
                  ? ColorsManager.darkBorder
                  : ColorsManager.lightBorder),
            ),
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
