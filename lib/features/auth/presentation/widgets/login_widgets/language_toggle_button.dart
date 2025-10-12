import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../profile/presentation/cubits/localization/locale_cubit/locale_cubit.dart';
import '../../../../profile/presentation/cubits/localization/locale_cubit/locale_state.dart';

class LanguageToggleButton extends StatelessWidget {
  const LanguageToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final isArabic = state.locale.languageCode == 'ar';

        return InkWell(
          onTap: () => context.read<LocaleCubit>().toggleLanguage(),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: ColorsManager.lightBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorsManager.primaryGreen.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.language,
                  size: 20,
                  color: ColorsManager.primaryGreen,
                ),
                const SizedBox(width: 8),
                Text(
                  isArabic ? 'English' : 'العربية',
                  style: TextStyles.font14PrimaryGreenSemiBold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
