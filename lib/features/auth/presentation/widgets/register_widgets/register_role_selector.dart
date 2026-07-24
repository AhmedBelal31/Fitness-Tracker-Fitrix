import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';
import 'register_role_option.dart';

import '../../../../../core/theming/app_colors.dart';

class RegisterRoleSelector extends StatefulWidget {
  final int selectedRole;
  final ValueChanged<int> onRoleChanged;

  const RegisterRoleSelector({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  State<RegisterRoleSelector> createState() => _RegisterRoleSelectorState();
}

class _RegisterRoleSelectorState extends State<RegisterRoleSelector> {
  late int _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.selectedRole;
  }

  void _handleRoleSelection(int role) {
    setState(() {
      _selectedRole = role;
    });
    widget.onRoleChanged(role);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            s.selectYourRole,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorsManager.getPrimaryText(context),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RegisterRoleOption(
                role: 1,
                label: s.normalUser,
                icon: Icons.person_outline,
                description: s.normalUserDesc,
                isSelected: _selectedRole == 1,
                onTap: () => _handleRoleSelection(1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RegisterRoleOption(
                role: 2,
                label: s.trainer,
                icon: Icons.fitness_center_outlined,
                description: s.trainerDesc,
                isSelected: _selectedRole == 2,
                onTap: () => _handleRoleSelection(2),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
