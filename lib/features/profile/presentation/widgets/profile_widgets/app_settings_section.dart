import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../cubits/localization/locale_cubit/locale_cubit.dart';
import '../../cubits/localization/locale_cubit/locale_state.dart';
import '../language_selector_sheet.dart';
import 'notification_switch_bloc_provider.dart';
import 'profile_section_title.dart';
import 'profile_settings_tile.dart';

import 'sound_switch_bloc_provider.dart';

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
              const NotificationSwitchBlocProvider(),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
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
}
