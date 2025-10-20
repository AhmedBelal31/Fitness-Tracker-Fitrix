import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import 'package:fitrix/core/routing/routes.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout),
        label: Text(s.logout),
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsManager.error,
          side: const BorderSide(color: ColorsManager.error, width: 2),
          padding: EdgeInsets.symmetric(vertical: 16.h),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final s = S.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.logoutConfirmTitle, style: TextStyles.headline3),
        content: Text(s.logoutConfirmMessage, style: TextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              await TokenManager.instance.clearAll();

              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(s.loggedOutSuccess),
                    backgroundColor: ColorsManager.success,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.error,
            ),
            child: Text(
              s.logout,
              style: TextStyles.font12Bold.copyWith(
                color: ColorsManager.whiteText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
