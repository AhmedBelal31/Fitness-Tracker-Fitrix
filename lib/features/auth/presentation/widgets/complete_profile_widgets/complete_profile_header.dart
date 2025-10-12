import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';
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
        Text(s.completeProfile, style: TextStyles.headline2),
        const SizedBox(height: 8),
        Text(
          s.setupFitnessJourney,
          style: TextStyles.subtitle2,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
