import 'package:flutter/material.dart';
import '../../../../../core/common_ui/widgets/adaptive_back_button.dart';

class RegisterBackButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const RegisterBackButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: AdaptiveBackButton(isLoading: isLoading, onPressed: onPressed),
    );
  }
}
