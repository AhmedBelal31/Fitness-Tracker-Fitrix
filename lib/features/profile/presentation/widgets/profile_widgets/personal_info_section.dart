import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../../../core/theming/app_colors.dart';
import 'profile_info_tile.dart';
import 'profile_section_title.dart';
import 'profile_settings_tile.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var profile = HiveService().getProfile();

    return Column(
      children: [
        ProfileSectionTitle(title: s.personalInformation),
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
              ProfileInfoTile(
                icon: Icons.phone,
                title: s.phoneNumber,
                value: profile?.phoneNumber ?? '+20 123 456 7890',
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              ProfileInfoTile(
                icon: Icons.calendar_today,
                title: s.date_of_birth,
                value: profile?.dateOfBirth != null
                    ? DateFormat('dd MMM yyyy').format(profile!.dateOfBirth!)
                    : '',
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              ProfileInfoTile(icon: Icons.person, title: s.role, value: s.user),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              ProfileSettingsTile(
                icon: Icons.lock,
                title: s.changeYourPassword,
                trailing: Icon(
                  Icons.chevron_right,
                  color: ColorsManager.getSecondaryText(context),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.changePassword);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
