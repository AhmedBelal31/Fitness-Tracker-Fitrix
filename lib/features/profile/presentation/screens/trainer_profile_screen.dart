import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

class TrainerProfileScreen extends StatelessWidget {
  const TrainerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.profile, style: TextStyles.headline2),
        backgroundColor: ColorsManager.scaffoldBackground,
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
          children: [
            // Profile Header
            _buildProfileHeader(s),
            SizedBox(height: 32.h),

            // Trainer Stats
            _buildSectionTitle('Trainer Stats'),
            SizedBox(height: 12.h),
            _buildTrainerStats(s),
            SizedBox(height: 24.h),

            // Personal Information
            _buildSectionTitle(s.personal_information),
            SizedBox(height: 12.h),
            _buildInfoCard(s),
            SizedBox(height: 24.h),

            // App Settings
            _buildSectionTitle(s.app_settings),
            SizedBox(height: 12.h),
            _buildSettingsCard(s),
            SizedBox(height: 24.h),

            // Help & Support
            _buildSectionTitle(s.help_support),
            SizedBox(height: 12.h),
            _buildHelpCard(s),
            SizedBox(height: 24.h),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showLogoutDialog(context, s);
                },
                icon: const Icon(Icons.logout),
                label: Text(s.logout),
                style: OutlinedButton.styleFrom(
                  foregroundColor: ColorsManager.error,
                  side: const BorderSide(color: ColorsManager.error, width: 2),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Version
            Text('${s.version} 1.0.0', style: TextStyles.bodySmall),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(S s) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: ColorsManager.primaryShadow,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManager.whiteText, width: 4),
                  color: ColorsManager.whiteText,
                ),
                child: Center(
                  child: Text(
                    'CA',
                    style: TextStyles.headline1.copyWith(
                      color: ColorsManager.primaryGreen,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: const BoxDecoration(
                    color: ColorsManager.whiteText,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    size: 20.sp,
                    color: ColorsManager.primaryGreen,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text('Coach Ahmed', style: TextStyles.font24WhiteBold),
          SizedBox(height: 4.h),
          Text('coach.ahmed@fitrix.com', style: TextStyles.font14WhiteMedium),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: ColorsManager.whiteText.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'Professional Trainer',
              style: TextStyles.font12WhiteRegular,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.whiteText,
              foregroundColor: ColorsManager.primaryGreen,
            ),
            child: Text(s.edit_your_profile),
          ),
        ],
      ),
    );
  }

  Widget _buildTrainerStats(S s) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('4', s.trainees, ColorsManager.info),
          Container(width: 1, height: 40.h, color: ColorsManager.lightBorder),
          _buildStatItem('156', s.workouts, ColorsManager.success),
          Container(width: 1, height: 40.h, color: ColorsManager.lightBorder),
          _buildStatItem('3', 'Years', ColorsManager.warning),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyles.font24PrimaryTextBold.copyWith(color: color),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyles.caption),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(title, style: TextStyles.subtitle1),
    );
  }

  Widget _buildInfoCard(S s) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          _buildInfoTile(Icons.phone, s.phone_number, '+20 123 456 7890'),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.calendar_today, s.member_since, 'January 2022'),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.person, 'Role', s.trainer),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.badge, 'Certificate', 'NASM Certified'),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: ColorsManager.primaryGreen),
      title: Text(title, style: TextStyles.bodySmall),
      subtitle: Text(value, style: TextStyles.font14PrimaryTextMedium),
    );
  }

  Widget _buildSettingsCard(S s) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          _buildSettingsTile(Icons.language, s.languages, () {}),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(Icons.notifications, s.notifications, () {}),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(Icons.dark_mode, s.theme, () {}),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(Icons.lock, s.change_your_password, () {}),
        ],
      ),
    );
  }

  Widget _buildHelpCard(S s) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          _buildSettingsTile(Icons.privacy_tip, s.privacy_policy, () {}),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(Icons.description, s.terms_conditions, () {}),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(Icons.help, s.contact_support, () {}),
          Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(Icons.info, s.about, () {}),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: ColorsManager.primaryGreen),
      title: Text(title, style: TextStyles.bodyMedium),
      trailing: Icon(Icons.chevron_right, color: ColorsManager.lightText),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, S s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.logout, style: TextStyles.headline3),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: ColorsManager.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.error,
            ),
            child: Text(s.logout),
          ),
        ],
      ),
    );
  }
}
