import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(s.privacyPolicyTitle, style: TextStyles.headline2),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLastUpdated(s),
            SizedBox(height: 24.h),

            // Introduction
            _buildSection(s, s.introduction, s.introductionText),

            // Information We Collect
            _buildSectionWithList(
              s,
              s.informationWeCollect,
              s.informationWeCollectText,
              [
                s.personalInformationItem,
                s.profileInformationItem,
                s.healthDataItem,
                s.usageDataItem,
              ],
            ),

            // How We Use Your Information
            _buildSectionWithList(s, s.howWeUseInfo, s.howWeUseInfoText, [
              s.provideServicesItem,
              s.personalizeExperienceItem,
              s.trackProgressItem,
              s.sendNotificationsItem,
              s.improveServicesItem,
            ]),

            // Data Security
            _buildSection(s, s.dataSecurity, s.dataSecurityText),

            // Your Rights
            _buildSectionWithList(s, s.yourRights, s.yourRightsText, [
              s.accessDataItem,
              s.correctDataItem,
              s.deleteDataItem,
              s.optOutItem,
              s.exportDataItem,
            ]),

            // Contact Us
            _buildSection(s, s.contactUsSection, s.contactUsText),

            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLastUpdated(S s) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.calendar_today,
            color: ColorsManager.primaryGreen,
            size: 16,
          ),
          SizedBox(width: 8.w),
          Text(
            '${s.lastUpdated}: ${s.lastUpdatedDate}',
            style: TextStyles.font14PrimaryGreenSemiBold,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(S s, String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.headline3),
          SizedBox(height: 12.h),
          Text(content, style: TextStyles.bodyMedium.copyWith(height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildSectionWithList(
    S s,
    String title,
    String intro,
    List<String> items,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.headline3),
          SizedBox(height: 12.h),
          Text(intro, style: TextStyles.bodyMedium.copyWith(height: 1.6)),
          SizedBox(height: 8.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(left: 16.w, top: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyles.bodyMedium),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyles.bodyMedium.copyWith(height: 1.6),
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
