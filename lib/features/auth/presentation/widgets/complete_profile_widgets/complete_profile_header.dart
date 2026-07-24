import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../login_widgets/animated_fitness_icon.dart';

class CompleteProfileHeader extends StatelessWidget {
  const CompleteProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        const PulsingFitnessIcon(),
        const SizedBox(height: 24),
        Text(
          s.completeProfile,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          s.setupFitnessJourney,
          style: TextStyle(
            fontSize: 16,
            color: ColorsManager.getSecondaryText(context),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
