import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';

class RegisterRoleOption extends StatelessWidget {
  final int role;
  final String label;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const RegisterRoleOption({
    super.key,
    required this.role,
    required this.label,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(16),
        decoration: _buildDecoration(),
        child: Column(
          children: [
            _buildIcon(),
            const SizedBox(height: 12),
            _buildLabel(),
            const SizedBox(height: 4),
            _buildDescription(),
            const SizedBox(height: 8),
            _buildSelectionIndicator(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: isSelected
          ? ColorsManager.primaryGreen.withValues(alpha: 0.1)
          : ColorsManager.cardBackground,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected
            ? ColorsManager.primaryGreen
            : ColorsManager.cardBackground,
        width: 2,
      ),
      boxShadow: isSelected
          ? [
              BoxShadow(
                color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ]
          : ColorsManager.softShadow,
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: isSelected
            ? ColorsManager.primaryGradient
            : LinearGradient(
                colors: [
                  ColorsManager.lightText.withValues(alpha: 0.1),
                  ColorsManager.lightText.withValues(alpha: 0.05),
                ],
              ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        size: 28,
        color: isSelected ? ColorsManager.whiteText : ColorsManager.lightText,
      ),
    );
  }

  Widget _buildLabel() {
    return Text(
      label,
      style: TextStyles.font14Medium.copyWith(
        color: isSelected ? ColorsManager.primaryGreen : ColorsManager.grey800,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDescription() {
    return Text(
      description,
      style: TextStyles.subtitle2.copyWith(fontSize: 11),
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildSelectionIndicator() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isSelected ? 24 : 20,
      height: isSelected ? 24 : 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? ColorsManager.primaryGreen
              : ColorsManager.lightText.withValues(alpha: 0.3),
          width: 2,
        ),
        color: isSelected ? ColorsManager.primaryGreen : Colors.transparent,
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 14, color: ColorsManager.whiteText)
          : null,
    );
  }
}
