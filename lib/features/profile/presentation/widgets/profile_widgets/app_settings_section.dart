import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/cubit/theme_cubit.dart';
import '../../../../../core/theming/cubit/theme_state.dart';
import '../../cubits/localization/locale_cubit/locale_cubit.dart';
import '../../cubits/localization/locale_cubit/locale_state.dart';
import '../language_selector_sheet.dart';
import 'notification_switch_bloc_provider.dart';
import 'profile_section_title.dart';
import 'profile_settings_tile.dart';
import 'sound_switch_bloc_provider.dart';
import 'theme_selector_sheet.dart';

class AppSettingsSection extends StatelessWidget {
  const AppSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        ProfileSectionTitle(title: s.appSettings),
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
              // Language Selector
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
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.getPrimaryGreen(context),
                        ),
                      ),
                    ),
                    onTap: () => _showLanguageSelector(context),
                  );
                },
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),

              // Theme Selector ✅
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  String themeLabel;
                  IconData themeIcon;

                  switch (state.appThemeMode) {
                    case AppThemeMode.light:
                      themeLabel = s.light;
                      themeIcon = Icons.light_mode;
                      break;
                    case AppThemeMode.dark:
                      themeLabel = s.dark;
                      themeIcon = Icons.dark_mode;
                      break;
                    case AppThemeMode.system:
                      themeLabel = s.system;
                      themeIcon = Icons.brightness_auto;
                      break;
                  }

                  return ProfileSettingsTile(
                    icon: Icons.palette_outlined,
                    title: s.theme,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          themeIcon,
                          size: 18.sp,
                          color: ColorsManager.getPrimaryGreen(context),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          themeLabel,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.getPrimaryGreen(context),
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showThemeSelector(context),
                  );
                },
              ),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),

              // Notifications
              const NotificationSwitchBlocProvider(),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),

              // Sound
              const SoundSwitchBlocProvider(),
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

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ThemeSelectorSheet(),
    );
  }
}
