import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_ui/widgets/custom_button.dart';
import '../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../cubits/change_password_cubit/change_password_cubit.dart';
import '../cubits/change_password_cubit/change_password_state.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;
  bool _passwordsMatch = false;

  late AnimationController _controller;
  late AnimationController _headerController;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePassword);
    _confirmPasswordController.addListener(_validatePasswordMatch);
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
    _headerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _controller.dispose();
    _headerController.dispose();
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (context) => di<ChangePasswordCubit>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                _buildAppBar(s, isDark),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _AnimatedItem(
                            controller: _controller,
                            index: 0,
                            child: _buildCurrentPasswordField(s, isDark),
                          ),
                          SizedBox(height: 24.h),
                          _AnimatedItem(
                            controller: _controller,
                            index: 1,
                            child: _buildNewPasswordField(s, isDark),
                          ),
                          SizedBox(height: 16.h),
                          _buildPasswordStrengthIndicator(s),
                          SizedBox(height: 24.h),
                          _AnimatedItem(
                            controller: _controller,
                            index: 2,
                            child: _buildConfirmPasswordField(s, isDark),
                          ),
                          SizedBox(height: 16.h),
                          _AnimatedItem(
                            controller: _controller,
                            index: 3,
                            child: _buildPasswordRequirements(s, isDark),
                          ),
                          SizedBox(height: 32.h),
                          _AnimatedItem(
                            controller: _controller,
                            index: 4,
                            child: _buildChangePasswordButton(
                              context,
                              s,
                              state,
                              isDark,
                            ),
                          ),
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

  Widget _buildAppBar(S s, bool isDark) {
    return SliverAppBar(
      expandedHeight: 180.h,
      pinned: true,
      backgroundColor: ColorsManager.getPrimaryGreen(context),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: isDark ? ColorsManager.darkScaffold : Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          s.changeYourPassword,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? ColorsManager.darkScaffold : Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: isDark
                    ? LinearGradient(
                        colors: [
                          ColorsManager.darkPrimaryGreen,
                          ColorsManager.darkSecondaryGreen,
                        ],
                      )
                    : LinearGradient(
                        colors: [
                          ColorsManager.primaryGreen,
                          ColorsManager.secondaryGreen,
                        ],
                      ),
              ),
            ),
            AnimatedBuilder(
              animation: _headerController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _HeaderPainter(
                    animation: _headerController.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 800),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Icon(
                          Icons.security,
                          size: 64.sp,
                          color:
                              (isDark
                                      ? ColorsManager.darkScaffold
                                      : Colors.white)
                                  .withValues(alpha: 0.9),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    s.secure_your_account,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          (isDark ? ColorsManager.darkScaffold : Colors.white)
                              .withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPasswordField(S s, bool isDark) {
    return CustomTextField(
      controller: _currentPasswordController,
      label: s.current_password,
      hint: s.please_enter_current_password,
      obscureText: _obscureCurrentPassword,
      prefixIcon: Icons.lock_outline,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureCurrentPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorsManager.getSecondaryText(context),
        ),
        onPressed: () =>
            setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
      ),
      validator: (value) => (value == null || value.isEmpty)
          ? s.please_enter_current_password
          : null,
    );
  }

  Widget _buildNewPasswordField(S s, bool isDark) {
    return CustomTextField(
      controller: _newPasswordController,
      label: s.new_password,
      hint: s.please_confirm_new_password,
      obscureText: _obscureNewPassword,
      prefixIcon: Icons.vpn_key,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorsManager.getSecondaryText(context),
        ),
        onPressed: () =>
            setState(() => _obscureNewPassword = !_obscureNewPassword),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return s.please_enter_new_password;
        if (!_hasMinLength) return s.password_must_be_at_least_6_characters;
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
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _getStrengthColor(),
                  ),
                ),
                Text(
                  _getStrengthText(s),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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

  Widget _buildConfirmPasswordField(S s, bool isDark) {
    return CustomTextField(
      controller: _confirmPasswordController,
      label: s.confirm_new_password,
      hint: s.please_confirm_new_password,
      obscureText: _obscureConfirmPassword,
      prefixIcon: Icons.check_circle_outline,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          color: ColorsManager.getSecondaryText(context),
        ),
        onPressed: () =>
            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
      ),
      validator: (value) {
        if (value == null || value.isEmpty)
          return s.please_confirm_new_password;
        if (value != _newPasswordController.text)
          return s.passwords_do_not_match;
        return null;
      },
    );
  }

  Widget _buildPasswordRequirements(S s, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isDark ? ColorsManager.darkBorder : ColorsManager.lightBorder,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 20.sp,
                color: ColorsManager.getPrimaryGreen(context),
              ),
              SizedBox(width: 8.w),
              Text(
                s.password_requirements,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildRequirement(s.at_least_6_characters, _hasMinLength, isDark),
          SizedBox(height: 8.h),
          _buildRequirement(s.contains_uppercase_letter, _hasUppercase, isDark),
          SizedBox(height: 8.h),
          _buildRequirement(s.contains_number, _hasNumber, isDark),
          SizedBox(height: 8.h),
          _buildRequirement(
            s.contains_special_character,
            _hasSpecialChar,
            isDark,
          ),
          if (_confirmPasswordController.text.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _buildRequirement(s.passwords_match, _passwordsMatch, isDark),
          ],
        ],
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet, bool isDark) {
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
              color: isMet
                  ? ColorsManager.success
                  : ColorsManager.getSecondaryText(context),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isMet
                    ? ColorsManager.success
                    : ColorsManager.getSecondaryText(context),
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
    bool isDark,
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

class _HeaderPainter extends CustomPainter {
  final double animation;
  final bool isDark;

  const _HeaderPainter({required this.animation, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final color = isDark ? ColorsManager.darkScaffold : Colors.white;
    final paint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 2; i++) {
      final path = Path();
      final offset = animation * size.width;
      for (double x = -size.width; x < size.width * 2; x += 10) {
        final y =
            size.height * 0.5 + math.sin((x + offset) / 40 + (i * 0.5)) * 15;
        if (x == -size.width) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _HeaderPainter oldDelegate) =>
      animation != oldDelegate.animation;
}

class _AnimatedItem extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _AnimatedItem({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final delay = (index * 0.08).clamp(0.0, 0.7);
    final end = (delay + 0.3).clamp(delay + 0.1, 1.0);

    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, end, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
