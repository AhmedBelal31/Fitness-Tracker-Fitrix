import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class TermsConditionsScreen extends StatefulWidget {
  const TermsConditionsScreen({super.key});

  @override
  State<TermsConditionsScreen> createState() => _TermsConditionsScreenState();
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen>
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
          s.termsConditionsTitle,
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
            _AnimatedItem(
              controller: _controller,
              index: 0,
              child: _buildLastUpdated(s, isDark),
            ),
            SizedBox(height: 24.h),
            _AnimatedItem(
              controller: _controller,
              index: 1,
              child: _buildSection(
                s,
                s.acceptanceOfTerms,
                s.acceptanceOfTermsText,
                isDark,
              ),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 2,
              child:
                  _buildSectionWithList(s, s.userAccount, s.userAccountText, [
                    s.maintainCredentialsItem,
                    s.accountActivitiesItem,
                    s.accurateInfoItem,
                    s.updateInfoItem,
                  ], isDark),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 3,
              child: _buildSectionWithList(
                s,
                s.acceptableUse,
                s.acceptableUseText,
                [
                  s.inappropriateContentItem,
                  s.harassUsersItem,
                  s.unauthorizedAccessItem,
                  s.commercialUseItem,
                  s.violateLawsItem,
                ],
                isDark,
              ),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 4,
              child: _buildSectionWithList(
                s,
                s.healthDisclaimer,
                s.healthDisclaimerText,
                [
                  s.notMedicalAdviceItem,
                  s.consultProviderItem,
                  s.useAtRiskItem,
                  s.notLiableItem,
                ],
                isDark,
              ),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 5,
              child: _buildSection(
                s,
                s.intellectualProperty,
                s.intellectualPropertyText,
                isDark,
              ),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 6,
              child: _buildSection(s, s.termination, s.terminationText, isDark),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 7,
              child: _buildSection(
                s,
                s.changesToTerms,
                s.changesToTermsText,
                isDark,
              ),
            ),
            _AnimatedItem(
              controller: _controller,
              index: 8,
              child: _buildSection(
                s,
                s.contactUsSection,
                s.legalContact,
                isDark,
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLastUpdated(S s, bool isDark) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.getPrimaryGreen(
          context,
        ).withValues(alpha: isDark ? 0.15 : 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.getPrimaryGreen(context).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: ColorsManager.getPrimaryGreen(context),
            size: 16,
          ),
          SizedBox(width: 8.w),
          Text(
            '${s.lastUpdated}: December 2024',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ColorsManager.getPrimaryGreen(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(S s, String title, String content, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionWithList(
    S s,
    String title,
    String intro,
    List<String> items,
    bool isDark,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            intro,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
          SizedBox(height: 8.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(left: 16.w, top: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    final delay = (index * 0.08).clamp(0.0, 0.7);
    final end = (delay + 0.3).clamp(delay + 0.1, 1.0);

    final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(delay, end, curve: Curves.easeOut),
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
