import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../profile/presentation/cubits/localization/locale_cubit/locale_cubit.dart';
import '../../../../profile/presentation/cubits/localization/locale_cubit/locale_state.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final isArabic = state.locale.languageCode == 'ar';

        return InkWell(
          onTap: () => context.read<LocaleCubit>().toggleLanguage(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              // 🎨 Adaptive background
              color: isDark
                  ? ColorsManager.darkSurface.withOpacity(0.8)
                  : ColorsManager.lightBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorsManager.getPrimaryGreen(context).withOpacity(0.3),
                width: 1.5,
              ),
              // 🌟 Subtle shadow in light mode, glow in dark mode
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? ColorsManager.darkPrimaryGreen.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
                  blurRadius: isDark ? 8 : 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language,
                  size: 20,
                  color: ColorsManager.getPrimaryGreen(context),
                ),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'English' : 'العربية',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
