import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class ProgressLoadingState extends StatelessWidget {
  const ProgressLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
    );
  }
}
