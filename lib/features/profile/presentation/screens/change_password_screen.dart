import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../cubits/change_password_cubit/change_password_cubit.dart';
import '../cubits/change_password_cubit/change_password_state.dart';
//
// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});
//
//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }
//
// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _currentPasswordController = TextEditingController();
//   final _newPasswordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   bool _obscureCurrentPassword = true;
//   bool _obscureNewPassword = true;
//   bool _obscureConfirmPassword = true;
//
//   @override
//   void dispose() {
//     _currentPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return BlocProvider(
//       create: (context) => di<ChangePasswordCubit>(),
//       child: Scaffold(
//         backgroundColor: ColorsManager.scaffoldBackground,
//         appBar: AppBar(
//           title: Text(s.changeYourPassword, style: TextStyles.headline3),
//           backgroundColor: ColorsManager.scaffoldBackground,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back_ios,
//               color: ColorsManager.primaryText,
//             ),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
//           listener: (context, state) {
//             if (state is ChangePasswordSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(s.password_changed_successfully),
//                   backgroundColor: ColorsManager.success,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                 ),
//               );
//               Navigator.pop(context);
//             } else if (state is ChangePasswordError) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(state.message),
//                   backgroundColor: ColorsManager.error,
//                   behavior: SnackBarBehavior.floating,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             return SingleChildScrollView(
//               padding: EdgeInsets.all(20.w),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildHeader(s),
//                     SizedBox(height: 32.h),
//                     _buildCurrentPasswordField(s),
//                     SizedBox(height: 16.h),
//                     _buildNewPasswordField(s),
//                     SizedBox(height: 16.h),
//                     _buildConfirmPasswordField(s),
//                     SizedBox(height: 8.h),
//                     _buildPasswordRequirements(s),
//                     SizedBox(height: 32.h),
//                     _buildChangePasswordButton(context, s, state),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(S s) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(s.change_password_title, style: TextStyles.headline2),
//         SizedBox(height: 8.h),
//         Text(
//           s.change_password_subtitle,
//           style: TextStyles.bodyMedium.copyWith(
//             color: ColorsManager.secondaryText,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCurrentPasswordField(S s) {
//     return CustomTextField(
//       controller: _currentPasswordController,
//       label: s.current_password,
//       obscureText: _obscureCurrentPassword,
//       prefixIcon: Icons.lock_outline,
//       suffixIcon: IconButton(
//         icon: Icon(
//           _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
//           color: ColorsManager.lightText,
//         ),
//         onPressed: () {
//           setState(() => _obscureCurrentPassword = !_obscureCurrentPassword);
//         },
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return s.please_enter_current_password;
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildNewPasswordField(S s) {
//     return CustomTextField(
//       controller: _newPasswordController,
//       label: s.new_password,
//       obscureText: _obscureNewPassword,
//       prefixIcon: Icons.lock_outline,
//       suffixIcon: IconButton(
//         icon: Icon(
//           _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
//           color: ColorsManager.lightText,
//         ),
//         onPressed: () {
//           setState(() => _obscureNewPassword = !_obscureNewPassword);
//         },
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return s.please_enter_new_password;
//         }
//         if (value.length < 6) {
//           return s.password_must_be_at_least_6_characters;
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildConfirmPasswordField(S s) {
//     return CustomTextField(
//       controller: _confirmPasswordController,
//       label: s.confirm_new_password,
//       obscureText: _obscureConfirmPassword,
//       prefixIcon: Icons.lock_outline,
//       suffixIcon: IconButton(
//         icon: Icon(
//           _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
//           color: ColorsManager.lightText,
//         ),
//         onPressed: () {
//           setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
//         },
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return s.please_confirm_new_password;
//         }
//         if (value != _newPasswordController.text) {
//           return s.passwords_do_not_match;
//         }
//         return null;
//       },
//     );
//   }
//
//   Widget _buildPasswordRequirements(S s) {
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.info.withValues(alpha: )(0.1),
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: ColorsManager.info.withValues(alpha: )(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.info_outline, size: 16.sp, color: ColorsManager.info),
//               SizedBox(width: 8.w),
//               Text(
//                 s.password_requirements,
//                 style: TextStyles.bodySmall.copyWith(
//                   color: ColorsManager.info,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 8.h),
//           _buildRequirement(s.at_least_6_characters),
//           _buildRequirement(s.contains_uppercase_letter),
//           _buildRequirement(s.contains_number),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRequirement(String text) {
//     return Padding(
//       padding: EdgeInsets.only(left: 24.w, top: 4.h),
//       child: Row(
//         children: [
//           Icon(
//             Icons.check_circle_outline,
//             size: 14.sp,
//             color: ColorsManager.lightText,
//           ),
//           SizedBox(width: 8.w),
//           Text(text, style: TextStyles.caption),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildChangePasswordButton(
//     BuildContext context,
//     S s,
//     ChangePasswordState state,
//   ) {
//     return CustomButton(
//       text: s.change_password,
//       isLoading: state is ChangePasswordLoading,
//       onPressed: state is ChangePasswordLoading
//           ? null
//           : () {
//               if (_formKey.currentState!.validate()) {
//                 context.read<ChangePasswordCubit>().changePassword(
//                   currentPassword: _currentPasswordController.text,
//                   newPassword: _newPasswordController.text,
//                   confirmPassword: _confirmPasswordController.text,
//                 );
//               }
//             },
//     );
//   }
// }

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Password strength indicators
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _passwordsMatch = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePasswordMatch);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _newPasswordController.text;
    setState(() {
      _hasMinLength = password.length >= 6;
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
    _validatePasswordMatch();
  }

  void _validatePasswordMatch() {
    setState(() {
      _passwordsMatch =
          _newPasswordController.text.isNotEmpty &&
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  double _getPasswordStrength() {
    int strength = 0;
    if (_hasMinLength) strength++;
    if (_hasUppercase) strength++;
    if (_hasNumber) strength++;
    if (_hasSpecialChar) strength++;
    return strength / 4;
  }

  Color _getStrengthColor() {
    final strength = _getPasswordStrength();
    if (strength >= 0.75) return ColorsManager.success;
    if (strength >= 0.5) return ColorsManager.warning;
    return ColorsManager.error;
  }

  String _getStrengthText(S s) {
    final strength = _getPasswordStrength();
    if (strength >= 0.75) return s.strong;
    if (strength >= 0.5) return s.medium;
    if (strength > 0) return s.weak;
    return s.very_weak;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocProvider(
      create: (context) => di<ChangePasswordCubit>(),
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackground,
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 12.w),
                      Expanded(child: Text(s.password_changed_successfully)),
                    ],
                  ),
                  backgroundColor: ColorsManager.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
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
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                _buildAppBar(s),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCurrentPasswordField(s),
                          SizedBox(height: 24.h),
                          _buildNewPasswordField(s),
                          SizedBox(height: 16.h),
                          _buildPasswordStrengthIndicator(s),
                          SizedBox(height: 24.h),
                          _buildConfirmPasswordField(s),
                          SizedBox(height: 16.h),
                          _buildPasswordRequirements(s),
                          SizedBox(height: 32.h),
                          _buildChangePasswordButton(context, s, state),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(S s) {
    return SliverAppBar(
      expandedHeight: 180.h,
      pinned: true,
      backgroundColor: ColorsManager.primaryGreen,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(s.changeYourPassword, style: TextStyles.font18WhiteBold),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsManager.primaryGreen,
                ColorsManager.secondaryGreen,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Icon(
                  Icons.security,
                  size: 64.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
                SizedBox(height: 12.h),
                Text(
                  s.secure_your_account,
                  style: TextStyles.font14WhiteMedium.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentPasswordField(S s) {
    return CustomTextField(
      controller: _currentPasswordController,
      label: s.current_password,
      hint: s.please_enter_current_password,
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
      hint: s.please_confirm_new_password,
      obscureText: _obscureNewPassword,
      prefixIcon: Icons.vpn_key,
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
        if (!_hasMinLength) {
          return s.password_must_be_at_least_6_characters;
        }
        return null;
      },
    );
  }

  Widget _buildPasswordStrengthIndicator(S s) {
    if (_newPasswordController.text.isEmpty) return const SizedBox();

    return AnimatedOpacity(
      opacity: _newPasswordController.text.isNotEmpty ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: _getStrengthColor().withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _getStrengthColor().withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.password_strength,
                  style: TextStyles.font14Bold.copyWith(
                    color: _getStrengthColor(),
                  ),
                ),
                Text(
                  _getStrengthText(s),
                  style: TextStyles.font14SemiBold.copyWith(
                    color: _getStrengthColor(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                value: _getPasswordStrength(),
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(_getStrengthColor()),
                minHeight: 8.h,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(S s) {
    return CustomTextField(
      controller: _confirmPasswordController,
      label: s.confirm_new_password,
      hint: s.please_confirm_new_password,
      obscureText: _obscureConfirmPassword,
      prefixIcon: Icons.check_circle_outline,
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorsManager.lightBorder, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20.sp,
                color: ColorsManager.primaryGreen,
              ),
              SizedBox(width: 8.w),
              Text(
                s.password_requirements,
                style: TextStyles.font16Bold.copyWith(
                  color: ColorsManager.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildRequirement(s.at_least_6_characters, _hasMinLength),
          SizedBox(height: 8.h),
          _buildRequirement(s.contains_uppercase_letter, _hasUppercase),
          SizedBox(height: 8.h),
          _buildRequirement(s.contains_number, _hasNumber),
          SizedBox(height: 8.h),
          _buildRequirement(s.contains_special_character, _hasSpecialChar),
          if (_confirmPasswordController.text.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildRequirement(s.passwords_match, _passwordsMatch),
          ],
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isMet
            ? ColorsManager.success.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              isMet ? Icons.check_circle : Icons.circle_outlined,
              key: ValueKey(isMet),
              size: 20.sp,
              color: isMet ? ColorsManager.success : ColorsManager.lightText,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyles.font14Medium.copyWith(
                color: isMet
                    ? ColorsManager.success
                    : ColorsManager.secondaryText,
                decoration: isMet ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
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
                  currentPassword: _currentPasswordController.text,
                  newPassword: _newPasswordController.text,
                  confirmPassword: _confirmPasswordController.text,
                );
              }
            },
    );
  }
}
