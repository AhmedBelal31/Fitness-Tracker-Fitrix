import 'package:flutter/material.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../../core/theming/styles.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Text('${s.version} 1.0.0', style: TextStyles.bodySmall);
  }
}
