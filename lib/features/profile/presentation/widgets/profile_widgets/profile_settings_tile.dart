import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';

// class ProfileSettingsTile extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final Widget trailing;
//   final VoidCallback onTap;
//
//   const ProfileSettingsTile({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.trailing,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: Icon(icon, color: ColorsManager.primaryGreen),
//       title: Text(title, style: TextStyles.bodyMedium),
//       trailing: trailing,
//       onTap: onTap,
//     );
//   }
// }

class ProfileSettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ProfileSettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorsManager.primaryGreen),
      title: Text(title, style: TextStyles.bodyMedium),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
