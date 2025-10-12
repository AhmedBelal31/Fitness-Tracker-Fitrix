import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/cubit/theme_cubit.dart';
import '../../../../../core/theming/cubit/theme_state.dart';
import '../../../../../core/theming/styles.dart';
import '../../cubits/localization/locale_cubit/locale_cubit.dart';
import '../../cubits/localization/locale_cubit/locale_state.dart';
import '../language_selector_sheet.dart';
import 'profile_section_title.dart';
import 'profile_settings_tile.dart';

class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        ProfileSectionTitle(title: s.appSettings),
        SizedBox(height: 12.h),
        Container(
          decoration: BoxDecoration(
            color: ColorsManager.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: ColorsManager.cardShadow,
          ),
          child: Column(
            children: [
              // Language
              BlocBuilder<LocaleCubit, LocaleState>(
                builder: (context, state) {
                  return ProfileSettingsTile(
                    icon: Icons.language,
                    title: s.languages,
                    trailing: TextButton(
                      onPressed: () => _showLanguageSelector(context),
                      child: Text(
                        state.locale.languageCode == 'en'
                            ? 'English'
                            : 'العربية',
                        style: TextStyles.font14PrimaryGreenSemiBold,
                      ),
                    ),
                    onTap: () => _showLanguageSelector(context),
                  );
                },
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),

              // Notifications
              ProfileSettingsTile(
                icon: Icons.notifications,
                title: s.notifications,
                trailing: Switch(
                  value: true, // TODO: Connect to cubit
                  onChanged: (value) {
                    // TODO: Toggle notifications
                  },
                  activeColor: ColorsManager.primaryGreen,
                ),
                onTap: () {},
              ),
              const Divider(color: ColorsManager.lightBorder, height: 1),

              // Theme
              // BlocBuilder<ThemeCubit, ThemeState>(
              //   builder: (context, state) {
              //     final isDark = state.appThemeMode == AppThemeMode.dark;
              //     return ProfileSettingsTile(
              //       icon: Icons.dark_mode,
              //       title: s.theme,
              //       trailing: Switch(
              //         value: isDark,
              //         onChanged: (value) {
              //           context.read<ThemeCubit>().toggleTheme();
              //         },
              //         activeColor: ColorsManager.primaryGreen,
              //       ),
              //       onTap: () {
              //         context.read<ThemeCubit>().toggleTheme();
              //       },
              //     );
              //   },
              // ),
              // const Divider(color: ColorsManager.lightBorder, height: 1),

              // Change Password
              ProfileSettingsTile(
                icon: Icons.lock,
                title: s.changeYourPassword,
                trailing: const Icon(
                  Icons.chevron_right,
                  color: ColorsManager.lightText,
                ),
                onTap: () {
                  // TODO: Navigate to change password
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const LanguageSelectorSheet(),
    );
  }
}
