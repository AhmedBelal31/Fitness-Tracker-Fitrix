import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import 'animated_fitness_icon.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Column(
      children: [
        const PulsingFitnessIcon(),
        const SizedBox(height: 24),
        Text(l10n.welcomeBack, style: TextStyles.headline1),
        const SizedBox(height: 8),
        Text(
          l10n.signInToContinue,
          style: TextStyles.subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
