// lib/features/trainer/presentation/widgets/assign_workout_dialog.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';

class AssignWorkoutDialog extends StatefulWidget {
  final String traineeId;

  const AssignWorkoutDialog({super.key, required this.traineeId});

  @override
  State<AssignWorkoutDialog> createState() => _AssignWorkoutDialogState();
}

class _AssignWorkoutDialogState extends State<AssignWorkoutDialog> {
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).assign_workout),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).workouts,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _selectedDate = date);
                }
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              S.of(context).notes_optional,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: S.of(context).add_message_optional,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).workout_assigned_successfully),
                backgroundColor: ColorsManager.success,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsManager.getPrimaryGreen(context),
          ),
          child: Text(S.of(context).assign),
        ),
      ],
    );
  }
}
