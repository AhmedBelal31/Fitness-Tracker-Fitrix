import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyles.subtitle1.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
