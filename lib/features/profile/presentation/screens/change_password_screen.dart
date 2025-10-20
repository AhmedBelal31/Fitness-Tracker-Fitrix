// lib/features/profile/presentation/screens/change_password_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/networking/token_manager.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../cubits/change_password_cubit/change_password_cubit.dart';
import '../cubits/change_password_cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (context) => di<ChangePasswordCubit>(),
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackground,
        appBar: AppBar(
          title: Text(s.changeYourPassword, style: TextStyles.headline3),
          backgroundColor: ColorsManager.scaffoldBackground,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorsManager.primaryText,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.password_changed_successfully),
                  backgroundColor: ColorsManager.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
              Navigator.pop(context);
            } else if (state is ChangePasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: ColorsManager.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(s),
                    SizedBox(height: 32.h),
                    _buildEmailField(s),
                    SizedBox(height: 16.h),
                    _buildCurrentPasswordField(s),
                    SizedBox(height: 16.h),
                    _buildNewPasswordField(s),
                    SizedBox(height: 16.h),
                    _buildConfirmPasswordField(s),
                    SizedBox(height: 8.h),
                    _buildPasswordRequirements(s),
                    SizedBox(height: 32.h),
                    _buildChangePasswordButton(context, s, state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(S s) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(s.change_password_title, style: TextStyles.headline2),
        SizedBox(height: 8.h),
        Text(
          s.change_password_subtitle,
          style: TextStyles.bodyMedium.copyWith(
            color: ColorsManager.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(S s) {
    return CustomTextField(
      controller: _emailController,
      label: s.email,
      hint: s.enterYourEmail,
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Icons.email_outlined,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return s.please_enter_email;
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return s.please_enter_valid_email;
        }
        return null;
      },
    );
  }

  Widget _buildCurrentPasswordField(S s) {
    return CustomTextField(
      controller: _currentPasswordController,
      label: s.current_password,
      obscureText: _obscureCurrentPassword,
      prefixIcon: Icons.lock_outline,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorsManager.lightText,
        ),
        onPressed: () {
          setState(() => _obscureCurrentPassword = !_obscureCurrentPassword);
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return s.please_enter_current_password;
        }
        return null;
      },
    );
  }

  Widget _buildNewPasswordField(S s) {
    return CustomTextField(
      controller: _newPasswordController,
      label: s.new_password,
      obscureText: _obscureNewPassword,
      prefixIcon: Icons.lock_outline,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorsManager.lightText,
        ),
        onPressed: () {
          setState(() => _obscureNewPassword = !_obscureNewPassword);
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return s.please_enter_new_password;
        }
        if (value.length < 6) {
          return s.password_must_be_at_least_6_characters;
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField(S s) {
    return CustomTextField(
      controller: _confirmPasswordController,
      label: s.confirm_new_password,
      obscureText: _obscureConfirmPassword,
      prefixIcon: Icons.lock_outline,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorsManager.lightText,
        ),
        onPressed: () {
          setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return s.please_confirm_new_password;
        }
        if (value != _newPasswordController.text) {
          return s.passwords_do_not_match;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordRequirements(S s) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.info.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: ColorsManager.info.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 16.sp, color: ColorsManager.info),
              SizedBox(width: 8.w),
              Text(
                s.password_requirements,
                style: TextStyles.bodySmall.copyWith(
                  color: ColorsManager.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _buildRequirement(s.at_least_6_characters),
          _buildRequirement(s.contains_uppercase_letter),
          _buildRequirement(s.contains_number),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, top: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 14.sp,
            color: ColorsManager.lightText,
          ),
          SizedBox(width: 8.w),
          Text(text, style: TextStyles.caption),
        ],
      ),
    );
  }

  Widget _buildChangePasswordButton(
    BuildContext context,
    S s,
    ChangePasswordState state,
  ) {
    return CustomButton(
      text: s.change_password,
      isLoading: state is ChangePasswordLoading,
      onPressed: state is ChangePasswordLoading
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<ChangePasswordCubit>().changePassword(
                  email: _emailController.text.trim(),
                  newPassword: _newPasswordController.text,
                  confirmPassword: _confirmPasswordController.text,
                );
              }
            },
    );
  }
}
