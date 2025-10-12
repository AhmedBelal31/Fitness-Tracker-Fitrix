import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../widgets/profile_widgets/app_settings_section.dart';
import '../widgets/profile_widgets/help_support_section.dart';
import '../widgets/profile_widgets/logout_button.dart';
import '../widgets/profile_widgets/user_profile_header.dart';
import '../widgets/profile_widgets/version_text.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(s.profile, style: TextStyles.headline2),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: ColorsManager.primaryGreen),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UserProfileHeader(),
            SizedBox(height: 32.h),
            // const PersonalInfoSection(),
            // SizedBox(height: 24.h),
            const AppSettingsSection(),
            SizedBox(height: 24.h),
            const HelpSupportSection(),
            SizedBox(height: 24.h),
            const LogoutButton(),
            SizedBox(height: 12.h),
            const VersionText(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
