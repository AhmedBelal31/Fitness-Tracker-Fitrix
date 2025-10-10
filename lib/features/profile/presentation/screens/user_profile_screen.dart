import 'package:fitrix/core/routing/export_routes.dart';
import 'package:fitrix/core/services/hive_service.dart';
import 'package:fitrix/features/auth/presentation/cubits/login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/networking/token_manager.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/cubit/theme_cubit.dart';
import '../../../../core/theming/cubit/theme_state.dart';
import '../../../../generated/l10n.dart';
import '../cubits/localization/locale_cubit/locale_cubit.dart';
import '../cubits/localization/locale_cubit/locale_state.dart';
import '../widgets/language_selector_sheet.dart';

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
          children: [
            // Profile Header
            UserProfileHeader(),
            SizedBox(height: 32.h),

            // Personal Information Section
            _buildSectionTitle(s.personal_information),
            SizedBox(height: 12.h),
            _buildInfoCard(s),
            SizedBox(height: 24.h),

            // App Settings Section
            _buildSectionTitle(s.app_settings),
            SizedBox(height: 12.h),
            _buildSettingsCard(context, s),
            SizedBox(height: 24.h),

            // Help & Support Section
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
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.calendar_today, s.member_since, 'January 2024'),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.person, 'Role', s.user),
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

  Widget _buildSettingsCard(BuildContext context, S s) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          // Language Setting with Switch
          _buildSettingsTile(
            context,
            icon: Icons.language,
            title: s.languages,
            trailing: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const LanguageSelectorSheet(),
                    );
                  },
                  child: Text(
                    state.locale.languageCode == 'en' ? 'English' : 'العربية',
                    style: TextStyles.font14PrimaryGreenSemiBold,
                  ),
                );
              },
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const LanguageSelectorSheet(),
              );
            },
          ),
          const Divider(color: ColorsManager.lightBorder, height: 1),

          // Notifications Setting
          _buildSettingsTile(
            context,
            icon: Icons.notifications,
            title: s.notifications,
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: ColorsManager.primaryGreen,
            ),
            onTap: () {},
          ),
          const Divider(color: ColorsManager.lightBorder, height: 1),

          // Theme Setting with Switch
          _buildSettingsTile(
            context,
            icon: Icons.dark_mode,
            title: s.theme,
            trailing: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDark = state.appThemeMode == AppThemeMode.dark;
                return Switch(
                  value: isDark,
                  onChanged: (value) {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  activeColor: ColorsManager.primaryGreen,
                );
              },
            ),
            onTap: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
          const Divider(color: ColorsManager.lightBorder, height: 1),

          // Change Password
          _buildSettingsTile(
            context,
            icon: Icons.lock,
            title: s.change_your_password,
            trailing: const Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
            ),
            onTap: () {},
          ),
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
          _buildSettingsTile(
            null,
            icon: Icons.privacy_tip,
            title: s.privacy_policy,
            trailing: const Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
            ),
            onTap: () {},
          ),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(
            null,
            icon: Icons.description,
            title: s.terms_conditions,
            trailing: const Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
            ),
            onTap: () {},
          ),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(
            null,
            icon: Icons.help,
            title: s.contact_support,
            trailing: const Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
            ),
            onTap: () {},
          ),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildSettingsTile(
            null,
            icon: Icons.info,
            title: s.about,
            trailing: const Icon(
              Icons.chevron_right,
              color: ColorsManager.lightText,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext? context, {
    required IconData icon,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: ColorsManager.primaryGreen),
      title: Text(title, style: TextStyles.bodyMedium),
      trailing: trailing,
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
            onPressed: () async {
              Navigator.pop(context);

              // Clear all tokens and saved data directly
              await TokenManager.instance.clearAll();

              // Navigate to login screen and clear navigation stack
              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    backgroundColor: ColorsManager.success,
                  ),
                );
              }
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

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    var profile = HiveService().getProfile();
    String firstName = profile?.firstName ?? 'F';
    String lastName = profile?.lastName ?? 'R';
    return Container(
      width: double.infinity,
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
                    "${firstName.isNotEmpty ? firstName[0] : 'F'}.${lastName.isNotEmpty ? lastName[0] : 'R'}",
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
          Text(
            "${firstName + " " + lastName} ",
            style: TextStyles.font24WhiteBold,
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
}
