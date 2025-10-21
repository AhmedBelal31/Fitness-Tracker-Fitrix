import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import 'profile_section_title.dart';
import 'profile_settings_tile.dart';

class HelpSupportSection extends StatelessWidget {
  const HelpSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        ProfileSectionTitle(title: s.helpSupport),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : Colors.black.withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              ProfileSettingsTile(
                icon: Icons.privacy_tip,
                title: s.privacyPolicy,
                trailing: Icon(
                  Icons.chevron_right,
                  color: ColorsManager.getSecondaryText(context),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, Routes.privacyPolicyScreen),
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              ProfileSettingsTile(
                icon: Icons.description,
                title: s.termsConditions,
                trailing: Icon(
                  Icons.chevron_right,
                  color: ColorsManager.getSecondaryText(context),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, Routes.termsConditionsScreen),
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              ProfileSettingsTile(
                icon: Icons.help,
                title: s.contactSupport,
                trailing: Icon(
                  Icons.chevron_right,
                  color: ColorsManager.getSecondaryText(context),
                ),
                onTap: () =>
                    Navigator.pushNamed(context, Routes.contactSupportScreen),
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              ProfileSettingsTile(
                icon: Icons.info,
                title: s.about,
                trailing: Icon(
                  Icons.chevron_right,
                  color: ColorsManager.getSecondaryText(context),
                ),
                onTap: () => Navigator.pushNamed(context, Routes.aboutScreen),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
