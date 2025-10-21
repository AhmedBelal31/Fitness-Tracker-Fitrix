import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';

class UserHomeHeader extends StatelessWidget {
  const UserHomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = HiveService().getProfile();
    final s = S.of(context);
    var firstAndLastName =
        ((profile?.firstName?.isNotEmpty ?? false) ||
            (profile?.lastName?.isNotEmpty ?? false))
        ? '${profile?.firstName ?? ""} ${profile?.lastName ?? ""}'.trim()
        : s.fitrixUser;

    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            s.welcome_back,
            style: TextStyle(
              fontSize: 14,
              color: ColorsManager.getSecondaryText(context),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            firstAndLastName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
        ],
      ),
    );
  }
}
