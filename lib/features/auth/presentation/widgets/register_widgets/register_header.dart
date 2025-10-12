import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        _buildLogo(),
        const SizedBox(height: 24),
        Text(s.createAccount, style: TextStyles.headline2),
        const SizedBox(height: 8),
        Text(
          s.joinFitrix,
          style: TextStyles.subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: ColorsManager.primaryGradient,
        boxShadow: ColorsManager.primaryShadow,
      ),
      child: const Icon(
        Icons.person_add_outlined,
        size: 40,
        color: ColorsManager.whiteText,
      ),
    );
  }
}
