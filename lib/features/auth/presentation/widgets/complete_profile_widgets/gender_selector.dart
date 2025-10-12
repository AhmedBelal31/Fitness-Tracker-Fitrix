import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

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
    final locale = S.of(context);

    return Row(
      children: [
        _genderRadio(context, 'Male', locale.male, Icons.male),
        const SizedBox(width: 24),
        // 👇 Pass English value "Female", display localized text
        _genderRadio(context, 'Female', locale.female, Icons.female),
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
                ? ColorsManager.primaryGreen.withValues(alpha: 0.14)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? ColorsManager.primaryGreen
                  : ColorsManager.lightText.withValues(alpha: 0.2),
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
