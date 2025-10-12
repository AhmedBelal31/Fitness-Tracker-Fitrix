import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(s.aboutTitle, style: TextStyles.headline2),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildAppLogo(),
            SizedBox(height: 24.h),
            Text('Fitrix', style: TextStyles.headline1),
            SizedBox(height: 8.h),
            Text(
              s.personalFitnessCompanion,
              style: TextStyles.subtitle2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            _buildInfoCard(s),
            SizedBox(height: 24.h),
            _buildSocialLinks(s),
            SizedBox(height: 24.h),
            _buildActionButtons(s, context),
            SizedBox(height: 32.h),
            _buildDescription(s),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(Icons.fitness_center, size: 60, color: Colors.white),
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
          _buildInfoTile(Icons.info, s.version, '1.0.0'),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.build, s.buildNumber, '100'),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.code, s.developer, s.fitrixTeam),
          const Divider(color: ColorsManager.lightBorder, height: 1),
          _buildInfoTile(Icons.web, s.website, 'www.fitrix.com'),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: ColorsManager.primaryGreen, size: 20),
      ),
      title: Text(title, style: TextStyles.bodySmall),
      trailing: Text(value, style: TextStyles.font14PrimaryTextMedium),
    );
  }

  Widget _buildSocialLinks(S s) {
    return Column(
      children: [
        Text(s.followUs, style: TextStyles.subtitle1),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              Icons.facebook,
              () => _launchURL('https://www.facebook.com/abdo.shady.1420#'),
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              Icons.camera_alt,
              () => _launchURL('https://www.instagram.com/abdo_m.shady550/'),
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              Icons.send,
              () => _launchWhatsApp('+201068318382'),
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              Icons.link,
              () => _launchURL('https://www.facebook.com/abdo.shady.1420#'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
          ),
        ),
        child: Icon(icon, color: ColorsManager.primaryGreen, size: 24),
      ),
    );
  }

  Widget _buildActionButtons(S s, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _rateApp(),
            icon: const Icon(Icons.star, color: Colors.white),
            label: Text(s.rateApp, style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryGreen,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _shareApp(s),
            icon: const Icon(Icons.share),
            label: Text(s.shareApp),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorsManager.primaryGreen,
              side: const BorderSide(
                color: ColorsManager.primaryGreen,
                width: 2,
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(S s) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.primaryGreen.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
        ),
      ),
      child: Text(
        s.appDescription,
        style: TextStyles.bodyMedium.copyWith(height: 1.6),
        textAlign: TextAlign.center,
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  void _rateApp() {
    // TODO: Implement app store rating
    // For iOS: https://apps.apple.com/app/idYOUR_APP_ID
    // For Android: https://play.google.com/store/apps/details?id=YOUR_PACKAGE_NAME

    _launchURL('https://play.google.com/store/apps/details?id=com.fitrix.app');
  }

  Future<void> _shareApp(S s) async {
    try {
      await Share.share(
        '${s.appDescription}\n\nDownload Fitrix now:\nhttps://fitrix.com/download',
        subject: 'Check out Fitrix!',
      );
    } catch (e) {
      debugPrint('Error sharing app: $e');
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final Uri whatsappUri = Uri.parse('https://wa.me/$phone');

    try {
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
    }
  }
}
