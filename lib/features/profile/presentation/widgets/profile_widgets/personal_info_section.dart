import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import 'package:intl/intl.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../../../core/theming/app_colors.dart';
import 'profile_info_tile.dart';
import 'profile_section_title.dart';

class PersonalInfoSection extends StatelessWidget {
  const PersonalInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    var profile = HiveService().getProfile();

    return Column(
      children: [
        ProfileSectionTitle(title: s.personalInformation),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: ColorsManager.cardShadow,
          ),
          child: Column(
            children: [
              ProfileInfoTile(
                icon: Icons.phone,
                title: s.phoneNumber,
                value: profile?.phoneNumber ?? '+20 123 456 7890',
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),
              ProfileInfoTile(
                icon: Icons.calendar_today,
                title: s.date_of_birth,
                value: profile?.dateOfBirth != null
                    ? DateFormat(
                        'dd MMM yyyy',
                      ).format(profile!.dateOfBirth!).toString()
                    : '',
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),
              ProfileInfoTile(icon: Icons.person, title: s.role, value: s.user),
            ],
          ),
        ),
      ],
    );
  }
}
