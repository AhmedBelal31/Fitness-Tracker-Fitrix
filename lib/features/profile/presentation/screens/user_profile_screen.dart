import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../widgets/profile_widgets/app_settings_section.dart';
import '../widgets/profile_widgets/help_support_section.dart';
import '../widgets/profile_widgets/logout_button.dart';
import '../widgets/profile_widgets/personal_info_section.dart';
import '../widgets/profile_widgets/user_profile_header.dart';
import '../widgets/profile_widgets/version_text.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final List<String> funnyMessages = [
      'إيه يا نجم! الزرار ده ديكور بس 😂',
      'واضح إنك بتحب تدوس كتير 😎',
      'لسه الزرار ده بيتدرب 😂',
      'تمام كده.. ولا حصل أي حاجة 😅',
      'الزرار ده مش شغال.. بس شكله حلو 🤭',
      'ماهو كلنا بنجرب 😂',
      'إيدك خفيفة أوي يا معلم 😄',
      'حاولت تشغله؟ أنا كمان حاولت ومفيش فايدة 😂',
      'استنى شوية.. لأ بهزر، مفيش حاجة هتحصل 😜',
      'هو زرار فعلاً بس مش جاد 😂',
      'ماتخافش، مش هيكسر حاجة 😅',
      'تمام كده، التطبيق بقى أحسن بكتير 🙃',
      'إيه الحماس ده يا نجم 😎',
      'أنا شايفك بتجرب كل حاجة 😂',
      'ده اختبار صبر، كمل دوس عليه شوية 🤭',
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(s.profile, style: TextStyles.headline2),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: ColorsManager.primaryGreen),
            // onPressed: () {},
            onPressed: () {
              final randomMessage = (funnyMessages..shuffle()).first;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(randomMessage),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: ColorsManager.primaryGreen,
                ),
              );
            },
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
