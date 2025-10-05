import 'package:flutter/material.dart';

import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';

/// Gender radio selector (custom UI for row with 'Male', 'Female', 'Other' or as needed)
class GenderSelector extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onChanged;
  const GenderSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _genderRadio(context, 'Male', 'Male', Icons.male),
        const SizedBox(width: 24),
        _genderRadio(context, 'Female', 'Female', Icons.female),
      ],
    );
  }

  Widget _genderRadio(
    BuildContext context,
    String value,
    String label,
    IconData icon,
  ) {
    final isSelected = selected == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorsManager.primaryGreen.withOpacity(0.14)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? ColorsManager.primaryGreen
                  : ColorsManager.lightText.withOpacity(0.2),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? ColorsManager.primaryGreen
                    : ColorsManager.lightText,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyles.font14Medium.copyWith(
                  color: isSelected
                      ? ColorsManager.primaryGreen
                      : ColorsManager.lightText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
