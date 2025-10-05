import 'package:flutter/material.dart';
import '../../../../../core/theming/styles.dart';
import 'register_role_option.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            'Select Your Role',
            style: TextStyles.font16LightTextRegular.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: RegisterRoleOption(
                role: 1,
                label: 'Normal User',
                icon: Icons.person_outline,
                description: 'Track workouts & progress',
                isSelected: _selectedRole == 1,
                onTap: () => _handleRoleSelection(1),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: RegisterRoleOption(
                role: 2,
                label: 'Trainer',
                icon: Icons.fitness_center_outlined,
                description: 'Create & manage plans',
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
