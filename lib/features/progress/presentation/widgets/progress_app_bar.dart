import 'package:flutter/material.dart';
import '../../../../core/theming/app_colors.dart';

class ProgressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ProgressAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsManager.getPrimaryText(context),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: ColorsManager.getPrimaryText(context)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
