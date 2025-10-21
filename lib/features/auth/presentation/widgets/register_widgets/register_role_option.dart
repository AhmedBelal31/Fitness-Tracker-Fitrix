import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

class RegisterRoleOption extends StatelessWidget {
  final int role;
  final String label;
  final IconData icon;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  const RegisterRoleOption({
    super.key,
    required this.role,
    required this.label,
    required this.icon,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final s = S.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isSelected
              ? (isDark
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorsManager.darkSurface,
                          ColorsManager.darkSurfaceElevated,
                        ],
                      )
                    : LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          ColorsManager.primaryGreen.withValues(alpha: 0.05),
                        ],
                      ))
              : null,
          color: !isSelected
              ? (isDark
                    ? ColorsManager.darkSurface.withValues(alpha: 0.4)
                    : ColorsManager.grey50)
              : null,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? ColorsManager.getPrimaryGreen(context)
                : (isDark
                      ? ColorsManager.darkBorder.withValues(alpha: 0.3)
                      : ColorsManager.lightBorder),
            width: isSelected ? 2.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: isDark
                        ? ColorsManager.darkPrimaryGreen.withValues(alpha: 0.3)
                        : ColorsManager.primaryGreen.withValues(alpha: 0.15),
                    blurRadius: isDark ? 16 : 12,
                    spreadRadius: isDark ? 1 : 0,
                    offset: const Offset(0, 4),
                  ),
                  if (isDark)
                    BoxShadow(
                      color: ColorsManager.darkPrimaryGreen.withValues(
                        alpha: 0.1,
                      ),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 0),
                    ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: isDark ? 0.2 : 0.1)
                    : (isDark
                          ? ColorsManager.darkSurfaceElevated
                          : ColorsManager.grey100),
                border: isSelected
                    ? Border.all(
                        color: ColorsManager.getPrimaryGreen(
                          context,
                        ).withValues(alpha: 0.3),
                        width: 2,
                      )
                    : null,
              ),
              child: Icon(
                icon,
                size: 36,
                color: isSelected
                    ? ColorsManager.getPrimaryGreen(context)
                    : (isDark
                          ? Colors.white.withValues(alpha: 0.5)
                          : ColorsManager.grey600),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? ColorsManager.getPrimaryGreen(context)
                    : ColorsManager.getPrimaryText(context),
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: ColorsManager.getSecondaryText(
                  context,
                ).withValues(alpha: 0.8),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (isSelected) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: ColorsManager.getPrimaryGreen(context),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: isDark ? ColorsManager.darkScaffold : Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      s.selected,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? ColorsManager.darkScaffold
                            : Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
