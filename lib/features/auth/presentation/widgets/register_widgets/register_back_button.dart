import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';

class RegisterBackButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterBackButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: ColorsManager.softShadow,
        ),
        child: IconButton(
          onPressed: isLoading ? null : onPressed,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.primaryGreen,
          ),
        ),
      ),
    );
  }
}
