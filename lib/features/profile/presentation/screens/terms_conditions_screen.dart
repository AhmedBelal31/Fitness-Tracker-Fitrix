import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(s.termsConditionsTitle, style: TextStyles.headline2),
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

            // Acceptance of Terms
            _buildSection(s, s.acceptanceOfTerms, s.acceptanceOfTermsText),

            // User Account
            _buildSectionWithList(s, s.userAccount, s.userAccountText, [
              s.maintainCredentialsItem,
              s.accountActivitiesItem,
              s.accurateInfoItem,
              s.updateInfoItem,
            ]),

            // Acceptable Use
            _buildSectionWithList(s, s.acceptableUse, s.acceptableUseText, [
              s.inappropriateContentItem,
              s.harassUsersItem,
              s.unauthorizedAccessItem,
              s.commercialUseItem,
              s.violateLawsItem,
            ]),

            // Health Disclaimer
            _buildSectionWithList(
              s,
              s.healthDisclaimer,
              s.healthDisclaimerText,
              [
                s.notMedicalAdviceItem,
                s.consultProviderItem,
                s.useAtRiskItem,
                s.notLiableItem,
              ],
            ),

            // Intellectual Property
            _buildSection(
              s,
              s.intellectualProperty,
              s.intellectualPropertyText,
            ),

            // Termination
            _buildSection(s, s.termination, s.terminationText),

            // Changes to Terms
            _buildSection(s, s.changesToTerms, s.changesToTermsText),

            // Contact
            _buildSection(s, s.contactUsSection, s.legalContact),

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
        color: ColorsManager.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ColorsManager.primaryGreen.withOpacity(0.3)),
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
            '${s.lastUpdated}: December 2024',
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
