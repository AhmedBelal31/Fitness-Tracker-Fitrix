import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../cubits/localization/locale_cubit/locale_cubit.dart';
import '../cubits/localization/locale_cubit/locale_state.dart';

// class LanguageSelectorSheet extends StatelessWidget {
//   const LanguageSelectorSheet({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       decoration: BoxDecoration(
//         color: isDark ? ColorsManager.cardBackground : Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       padding: EdgeInsets.all(20.w),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Handle bar
//           Container(
//             width: 40.w,
//             height: 4.h,
//             decoration: BoxDecoration(
//               color: ColorsManager.lightText,
//               borderRadius: BorderRadius.circular(2.r),
//             ),
//           ),
//           SizedBox(height: 20.h),
//
//           // Title
//           Text(s.languages, style: TextStyles.headline3),
//           SizedBox(height: 24.h),
//
//           // Language Options
//           BlocBuilder<LocaleCubit, LocaleState>(
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   _buildLanguageOption(
//                     context,
//                     flag: '🇬🇧',
//                     title: 'English',
//                     subtitle: 'English',
//                     languageCode: 'en',
//                     isSelected: state.locale.languageCode == 'en',
//                     onTap: () {
//                       context.read<LocaleCubit>().changeLocale('en');
//                       Navigator.pop(context);
//                     },
//                   ),
//                   SizedBox(height: 12.h),
//                   _buildLanguageOption(
//                     context,
//                     flag: '🇪🇬',
//                     title: 'العربية',
//                     subtitle: 'Arabic',
//                     languageCode: 'ar',
//                     isSelected: state.locale.languageCode == 'ar',
//                     onTap: () {
//                       context.read<LocaleCubit>().changeLocale('ar');
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//           SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLanguageOption(
//     BuildContext context, {
//     required String flag,
//     required String title,
//     required String subtitle,
//     required String languageCode,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12.r),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: isSelected
//               ? ColorsManager.primaryGreen.withOpacity(0.1)
//               : (isDark ? ColorsManager.scaffoldBackground : Colors.grey[100]),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: isSelected ? ColorsManager.primaryGreen : Colors.transparent,
//             width: 2,
//           ),
//         ),
//         child: Row(
//           children: [
//             // Flag
//             Container(
//               padding: EdgeInsets.all(10.w),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? ColorsManager.primaryGreen.withOpacity(0.2)
//                     : ColorsManager.lightText.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10.r),
//               ),
//               child: Text(flag, style: TextStyle(fontSize: 28.sp)),
//             ),
//             SizedBox(width: 16.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyles.font16PrimaryTextRegular.copyWith(
//                       color: isSelected
//                           ? ColorsManager.primaryGreen
//                           : (isDark
//                                 ? ColorsManager.primaryText
//                                 : ColorsManager.lightPrimaryText),
//                     ),
//                   ),
//                   SizedBox(height: 2.h),
//                   Text(subtitle, style: TextStyles.caption),
//                 ],
//               ),
//             ),
//             if (isSelected)
//               Icon(
//                 Icons.check_circle,
//                 color: ColorsManager.primaryGreen,
//                 size: 24.sp,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class LanguageSelectorSheet extends StatelessWidget {
  const LanguageSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: isDark
                  ? ColorsManager.darkBorder
                  : ColorsManager.lightBorder,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            s.languages,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 24.h),
          BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, state) {
              return Column(
                children: [
                  _buildLanguageOption(
                    context,
                    flag: '🇬🇧',
                    title: 'English',
                    subtitle: 'English',
                    languageCode: 'en',
                    isSelected: state.locale.languageCode == 'en',
                    onTap: () {
                      context.read<LocaleCubit>().changeLocale('en');
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildLanguageOption(
                    context,
                    flag: '🇪🇬',
                    title: 'العربية',
                    subtitle: 'Arabic',
                    languageCode: 'ar',
                    isSelected: state.locale.languageCode == 'ar',
                    onTap: () {
                      context.read<LocaleCubit>().changeLocale('ar');
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String flag,
    required String title,
    required String subtitle,
    required String languageCode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.2 : 0.1)
              : (isDark
                    ? ColorsManager.darkInputBackground
                    : ColorsManager.lightInputBackground),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? ColorsManager.getPrimaryGreen(context)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.2)
                    : (isDark
                          ? ColorsManager.darkBorder.withValues(alpha: 0.3)
                          : ColorsManager.lightBorder.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(flag, style: TextStyle(fontSize: 28.sp)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? ColorsManager.getPrimaryGreen(context)
                          : ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: ColorsManager.getPrimaryGreen(context),
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}
