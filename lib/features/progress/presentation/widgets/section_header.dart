import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ColorsManager.getPrimaryText(context),
      ),
    );
  }
}
