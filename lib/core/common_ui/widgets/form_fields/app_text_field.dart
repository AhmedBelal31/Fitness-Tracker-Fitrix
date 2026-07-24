import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theming/app_colors.dart';
import '../../../theming/styles.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool isRequired;
  final bool enabled;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.isRequired = false,
    this.enabled = true,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.isRequired ? '${widget.label} *' : widget.label,
          style: TextStyles.subtitle1,
        ),
        SizedBox(height: 8.h),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: _isFocused
                ? [
                    BoxShadow(
                      color: ColorsManager.primaryGreen.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() => _isFocused = hasFocus);
            },
            child: TextFormField(
              controller: widget.controller,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              keyboardType: widget.keyboardType,
              style: TextStyles.bodyMedium.copyWith(
                color: ColorsManager.primaryText,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyles.bodyMedium.copyWith(
                  color: Colors.grey[600],
                ),
                filled: true,
                fillColor: ColorsManager.inputBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: ColorsManager.primaryGreen,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
              ),
              validator: widget.validator,
            ),
          ),
        ),
      ],
    );
  }
}
