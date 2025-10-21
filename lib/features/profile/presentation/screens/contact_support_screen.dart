import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../widgets/animated_item.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          s.contactSupportTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedItem(
                controller: _controller,
                index: 0,
                child: _buildHeader(s, isDark),
              ),
            ),
            SizedBox(height: 32.h),
            AnimatedItem(
              controller: _controller,
              index: 1,
              child: _buildContactCard(
                s,
                isDark,
                icon: Icons.email,
                title: s.email,
                subtitle: 'appfitrix@gmail.com',
                buttonText: s.sendEmail,
                onTap: () => _launchEmail('appfitrix@gmail.com'),
              ),
            ),
            SizedBox(height: 16.h),
            AnimatedItem(
              controller: _controller,
              index: 2,
              child: _buildContactCard(
                s,
                isDark,
                icon: Icons.phone,
                title: s.callUs,
                subtitle: '+20 106 831 8382',
                buttonText: s.callUs,
                onTap: () => _launchPhone('+201068318382'),
              ),
            ),
            SizedBox(height: 16.h),
            AnimatedItem(
              controller: _controller,
              index: 3,
              child: _buildContactCard(
                s,
                isDark,
                icon: Icons.chat,
                title: s.whatsapp,
                subtitle: '+20 106 831 8382',
                buttonText: s.sendMessage,
                onTap: () => _launchWhatsApp('+201068318382'),
              ),
            ),
            SizedBox(height: 32.h),
            AnimatedItem(
              controller: _controller,
              index: 4,
              child: _buildFAQSection(s, isDark),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(S s, bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                colors: [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                ],
              )
            : ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.support_agent,
            color: isDark ? ColorsManager.darkScaffold : Colors.white,
            size: 48,
          ),
          SizedBox(height: 12.h),
          Text(
            s.howCanWeHelp,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDark ? ColorsManager.darkScaffold : Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            s.supportTeamReady,
            style: TextStyle(
              fontSize: 14,
              color: (isDark ? ColorsManager.darkScaffold : Colors.white)
                  .withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    S s,
    bool isDark, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
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
      child: ListTile(
        contentPadding: EdgeInsets.all(16.w),
        leading: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: ColorsManager.getPrimaryGreen(context)),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.getSecondaryText(context),
            ),
          ),
        ),
        trailing: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.getPrimaryGreen(context),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 12,
              color: isDark ? ColorsManager.darkScaffold : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFAQSection(S s, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          s.frequentlyAskedQuestions,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        SizedBox(height: 16.h),
        _buildFAQItem(s.faqResetPassword, s.faqResetPasswordAnswer, isDark),
        _buildFAQItem(s.faqSyncData, s.faqSyncDataAnswer, isDark),
        _buildFAQItem(s.faqTrackWorkouts, s.faqTrackWorkoutsAnswer, isDark),
      ],
    );
  }

  Widget _buildFAQItem(String question, String answer, bool isDark) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark ? ColorsManager.darkBorder : ColorsManager.lightBorder,
        ),
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          childrenPadding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
          ),
          title: Text(
            question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorsManager.getSecondaryText(context),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Fitrix Support Request',
    );
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    try {
      if (await canLaunchUrl(uri)) await launchUrl(uri);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _launchWhatsApp(String phone) async {
    final Uri uri = Uri.parse('https://wa.me/$phone');
    try {
      if (await canLaunchUrl(uri))
        await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
