import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        _buildLogo(context, isDark),
        const SizedBox(height: 24),
        Text(
          s.createAccount,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          s.joinFitrix,
          style: TextStyle(
            fontSize: 16,
            color: ColorsManager.getSecondaryText(context),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context, bool isDark) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: ColorsManager.getLogoGradient(context),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withOpacity(isDark ? 0.4 : 0.3),
            blurRadius: isDark ? 20 : 15,
            spreadRadius: isDark ? 2 : 1,
            offset: isDark ? const Offset(0, 0) : const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.person_add_outlined,
        size: 40,
        color: isDark ? ColorsManager.darkScaffold : Colors.white,
      ),
    );
  }
}
