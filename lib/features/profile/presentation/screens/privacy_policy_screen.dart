import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../widgets/animated_item.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
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
          s.privacyPolicyTitle,
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
            AnimatedItem(
              controller: _controller,
              index: 0,
              child: _buildLastUpdated(s, isDark),
            ),
            SizedBox(height: 24.h),
            AnimatedItem(
              controller: _controller,
              index: 1,
              child: _buildSection(
                s,
                s.introduction,
                s.introductionText,
                isDark,
              ),
            ),
            AnimatedItem(
              controller: _controller,
              index: 2,
              child: _buildSectionWithList(
                s,
                s.informationWeCollect,
                s.informationWeCollectText,
                [
                  s.personalInformationItem,
                  s.profileInformationItem,
                  s.healthDataItem,
                  s.usageDataItem,
                ],
                isDark,
              ),
            ),
            AnimatedItem(
              controller: _controller,
              index: 3,
              child:
                  _buildSectionWithList(s, s.howWeUseInfo, s.howWeUseInfoText, [
                    s.provideServicesItem,
                    s.personalizeExperienceItem,
                    s.trackProgressItem,
                    s.sendNotificationsItem,
                    s.improveServicesItem,
                  ], isDark),
            ),
            AnimatedItem(
              controller: _controller,
              index: 4,
              child: _buildSection(
                s,
                s.dataSecurity,
                s.dataSecurityText,
                isDark,
              ),
            ),
            AnimatedItem(
              controller: _controller,
              index: 5,
              child: _buildSectionWithList(s, s.yourRights, s.yourRightsText, [
                s.accessDataItem,
                s.correctDataItem,
                s.deleteDataItem,
                s.optOutItem,
                s.exportDataItem,
              ], isDark),
            ),
            AnimatedItem(
              controller: _controller,
              index: 6,
              child: _buildSection(
                s,
                s.contactUsSection,
                s.contactUsText,
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
            '${s.lastUpdated}: ${s.lastUpdatedDate}',
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
