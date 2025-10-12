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

    return Column(
      children: [
        ProfileSectionTitle(title: s.helpSupport),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: ColorsManager.cardShadow,
          ),
          child: Column(
            children: [
              ProfileSettingsTile(
                icon: Icons.privacy_tip,
                title: s.privacyPolicy,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.privacyPolicyScreen);
                },
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),
              ProfileSettingsTile(
                icon: Icons.description,
                title: s.termsConditions,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.termsConditionsScreen);
                },
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),
              ProfileSettingsTile(
                icon: Icons.help,
                title: s.contactSupport,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.contactSupportScreen);
                },
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),
              ProfileSettingsTile(
                icon: Icons.info,
                title: s.about,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.aboutScreen);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
