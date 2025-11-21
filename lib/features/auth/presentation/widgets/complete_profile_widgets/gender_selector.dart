import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.2 : 0.14)
                : Colors.transparent,
            border: Border.all(
              color: isSelected
                  ? ColorsManager.getPrimaryGreen(context)
                  : (isDark
                        ? ColorsManager.darkBorder
                        : ColorsManager.lightBorder),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? ColorsManager.getPrimaryGreen(context)
                    : ColorsManager.getSecondaryText(context),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? ColorsManager.getPrimaryGreen(context)
                      : ColorsManager.getSecondaryText(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
