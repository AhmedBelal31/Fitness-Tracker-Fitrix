import 'package:flutter/material.dart';
import 'package:fitrix/core/theming/styles.dart';
import '../../../../core/theming/app_colors.dart';

class ProgressAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ProgressAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: TextStyles.headline3),
      backgroundColor: ColorsManager.scaffoldBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
