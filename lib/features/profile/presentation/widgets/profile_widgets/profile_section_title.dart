import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';

class ProfileSectionTitle extends StatelessWidget {
  final String title;

  const ProfileSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(title, style: TextStyles.subtitle1),
    );
  }
}
