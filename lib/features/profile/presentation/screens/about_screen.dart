import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
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
          s.aboutTitle,
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
          children: [
            _AnimatedItem(
              controller: _controller,
              index: 0,
              child: _buildAppLogo(isDark),
            ),
            SizedBox(height: 24.h),
            _AnimatedItem(
              controller: _controller,
              index: 1,
              child: Text(
                'Fitrix',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryText(context),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            _AnimatedItem(
              controller: _controller,
              index: 2,
              child: Text(
                s.personalFitnessCompanion,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorsManager.getSecondaryText(context),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 32.h),
            _AnimatedItem(
              controller: _controller,
              index: 3,
              child: _buildInfoCard(s, isDark),
            ),
            SizedBox(height: 24.h),
            // _AnimatedItem(
            //   controller: _controller,
            //   index: 4,
            //   child: _buildSocialLinks(s, isDark),
            // ),
            SizedBox(height: 24.h),
            _AnimatedItem(
              controller: _controller,
              index: 5,
              child: _buildActionButtons(s, context, isDark),
            ),
            SizedBox(height: 32.h),
            _AnimatedItem(
              controller: _controller,
              index: 6,
              child: _buildDescription(s, isDark),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo(bool isDark) {
    return Container(
      width: 120.w,
      height: 120.h,
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                colors: [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                ],
              )
            : ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Icon(
        Icons.fitness_center,
        size: 60,
        color: isDark ? ColorsManager.darkScaffold : Colors.white,
      ),
    );
  }

  Widget _buildInfoCard(S s, bool isDark) {
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
      child: Column(
        children: [
          _buildInfoTile(Icons.info, s.version, '1.0.0', isDark),
          Divider(
            color: isDark
                ? ColorsManager.darkBorder
                : ColorsManager.lightBorder,
            height: 1,
          ),
          _buildInfoTile(Icons.build, s.buildNumber, '100', isDark),
          Divider(
            color: isDark
                ? ColorsManager.darkBorder
                : ColorsManager.lightBorder,
            height: 1,
          ),
          _buildInfoTile(Icons.code, s.developer, s.fitrixTeam, isDark),
          Divider(
            color: isDark
                ? ColorsManager.darkBorder
                : ColorsManager.lightBorder,
            height: 1,
          ),
          _buildInfoTile(Icons.web, s.website, 'www.fitrix.com', isDark),
        ],
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String title,
    String value,
    bool isDark,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: ColorsManager.getPrimaryGreen(
            context,
          ).withValues(alpha: isDark ? 0.2 : 0.1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: ColorsManager.getPrimaryGreen(context),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: ColorsManager.getSecondaryText(context),
        ),
      ),
      trailing: Text(
        value,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorsManager.getPrimaryText(context),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(S s, bool isDark) {
    return Column(
      children: [
        Text(
          s.followUs,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              Icons.facebook,
              () => _launchURL('https://www.facebook.com/abdo.shady.1420#'),
              isDark,
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              Icons.camera_alt,
              () => _launchURL('https://www.instagram.com/abdo_m.shady550/'),
              isDark,
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              Icons.send,
              () => _launchWhatsApp('+201068318382'),
              isDark,
            ),
            SizedBox(width: 16.w),
            _buildSocialButton(
              Icons.link,
              () => _launchURL('https://www.facebook.com/abdo.shady.1420#'),
              isDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, VoidCallback onTap, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.3),
                ),
              ),
              child: Icon(
                icon,
                color: ColorsManager.getPrimaryGreen(context),
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(S s, BuildContext context, bool isDark) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _rateApp(),
            icon: Icon(
              Icons.star,
              color: isDark ? ColorsManager.darkScaffold : Colors.white,
            ),
            label: Text(
              s.rateApp,
              style: TextStyle(
                color: isDark ? ColorsManager.darkScaffold : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.getPrimaryGreen(context),
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
            icon: Icon(Icons.share),
            label: Text(s.shareApp),
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorsManager.getPrimaryGreen(context),
              side: BorderSide(
                color: ColorsManager.getPrimaryGreen(context),
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

  Widget _buildDescription(S s, bool isDark) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.getPrimaryGreen(
          context,
        ).withValues(alpha: isDark ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        s.appDescription,
        style: TextStyle(
          fontSize: 14,
          height: 1.6,
          color: ColorsManager.getPrimaryText(context),
        ),
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
      debugPrint('Error: $e');
    }
  }

  void _rateApp() {
    _launchURL('https://play.google.com/store/apps/details?id=com.fitrix.app');
  }

  Future<void> _shareApp(S s) async {
    try {
      await Share.share(
        '${s.appDescription}\n\nDownload Fitrix now:\nhttps://fitrix.com/download',
        subject: 'Check out Fitrix!',
      );
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

class _AnimatedItem extends StatelessWidget {
  final AnimationController controller;
  final int index;
  final Widget child;

  const _AnimatedItem({
    required this.controller,
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final delay = index * 0.1;
    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, delay + 0.4, curve: Curves.easeOut),
      ),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
