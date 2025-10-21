import 'package:flutter/material.dart';
import '../../../../../core/theming/app_colors.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorsManager.getPrimaryGreen(context)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          color: ColorsManager.getSecondaryText(context),
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ColorsManager.getPrimaryText(context),
        ),
      ),
    );
  }
}
