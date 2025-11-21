import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/services/hive_service.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    var profile = HiveService().getProfile();
    String firstName = profile?.firstName ?? 'F';
    String lastName = profile?.lastName ?? 'R';
    String fullName = '$firstName $lastName';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${s.welcome_back},', style: TextStyles.bodyMedium),
        SizedBox(height: 4.h),
        Text(fullName, style: TextStyles.headline2),
        SizedBox(height: 8.h),
        Text(
          _getMotivationalQuote(s),
          style: TextStyles.bodySmall.copyWith(
            color: ColorsManager.primaryGreen,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  String _getMotivationalQuote(S s) {
    // Get a quote based on day of the month for variety
    final quoteIndex = (DateTime.now().day % 8) + 1;

    switch (quoteIndex) {
      case 1:
        return s.motivational_quote_1;
      case 2:
        return s.motivational_quote_2;
      case 3:
        return s.motivational_quote_3;
      case 4:
        return s.motivational_quote_4;
      case 5:
        return s.motivational_quote_5;
      case 6:
        return s.motivational_quote_6;
      case 7:
        return s.motivational_quote_7;
      case 8:
        return s.motivational_quote_8;
      default:
        return s.motivational_quote_1;
    }
  }
}
