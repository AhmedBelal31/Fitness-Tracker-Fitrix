import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class UserHomeSectionHeader extends StatelessWidget {
  final String? title;
  final VoidCallback? onSeeAll;

  const UserHomeSectionHeader({super.key, this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? "", style: TextStyles.subtitle1),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              s.view_all,
              style: TextStyles.font14PrimaryGreenSemiBold,
            ),
          ),
      ],
    );
  }
}
