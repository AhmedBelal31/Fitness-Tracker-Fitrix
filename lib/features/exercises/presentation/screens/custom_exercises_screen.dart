import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/mock_exercises_data.dart';
import '../widgets/exercise_card.dart';

class CustomExercisesScreen extends StatelessWidget {
  const CustomExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final customExercises = MockExercisesData.getMockCustomExercises();

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.my_custom_exercises, style: TextStyles.headline2),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
      ),
      body: customExercises.isNotEmpty
          ? ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: customExercises.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: ExerciseCard(
                    exercise: customExercises[index],
                    onTap: () {
                      _showExerciseOptions(context, customExercises[index], s);
                    },
                  ),
                );
              },
            )
          : _buildEmptyState(context, s),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateExerciseDialog(context, s);
        },
        backgroundColor: ColorsManager.primaryGreen,
        icon: const Icon(Icons.add),
        label: Text(s.create_custom_exercise, style: TextStyles.buttonMedium),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, S s) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center_outlined,
              size: 100.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 24.h),
            Text(
              s.no_custom_exercises_yet,
              style: TextStyles.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              s.create_your_own_exercises,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () {
                _showCreateExerciseDialog(context, s);
              },
              icon: const Icon(Icons.add),
              label: Text(s.create_your_first_exercise),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryGreen,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExerciseOptions(BuildContext context, exercise, S s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(exercise.name, style: TextStyles.headline3),
              SizedBox(height: 20.h),
              ListTile(
                leading: const Icon(
                  Icons.edit,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.edit_exercise),
                onTap: () {
                  Navigator.pop(context);
                  _showEditExerciseDialog(context, exercise, s);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_circle,
                  color: ColorsManager.info,
                ),
                title: Text(s.add_to_workout),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(s.added_to_workout),
                      backgroundColor: ColorsManager.success,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: ColorsManager.error),
                title: Text(s.delete_exercise),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, exercise, s);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCreateExerciseDialog(BuildContext context, S s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.create_custom_exercise, style: TextStyles.headline3),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: s.exercise_name,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                decoration: InputDecoration(
                  labelText: s.description,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: s.section,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: 'Chest', child: Text(s.chest)),
                  DropdownMenuItem(value: 'Back', child: Text(s.back)),
                  DropdownMenuItem(value: 'Legs', child: Text(s.legs)),
                  DropdownMenuItem(
                    value: 'Shoulders',
                    child: Text(s.shoulders),
                  ),
                  DropdownMenuItem(value: 'Arms', child: Text(s.arms)),
                  DropdownMenuItem(value: 'Core', child: Text(s.core)),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: s.equipment,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: 'Barbell', child: Text(s.barbell)),
                  DropdownMenuItem(
                    value: 'Dumbbells',
                    child: Text(s.dumbbells),
                  ),
                  DropdownMenuItem(
                    value: 'Cable Machine',
                    child: Text(s.cable_machine),
                  ),
                  DropdownMenuItem(
                    value: 'Bodyweight',
                    child: Text(s.bodyweight),
                  ),
                  DropdownMenuItem(value: 'Machine', child: Text(s.machine)),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: 16.h),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: s.difficulty,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                items: [
                  DropdownMenuItem(value: 'Beginner', child: Text(s.beginner)),
                  DropdownMenuItem(
                    value: 'Intermediate',
                    child: Text(s.intermediate),
                  ),
                  DropdownMenuItem(value: 'Advanced', child: Text(s.advanced)),
                ],
                onChanged: (value) {},
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.exercise_created_successfully),
                  backgroundColor: ColorsManager.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryGreen,
            ),
            child: Text(s.create),
          ),
        ],
      ),
    );
  }

  void _showEditExerciseDialog(BuildContext context, exercise, S s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(s.edit_exercise, style: TextStyles.headline3),
        content: Text(
          'Edit functionality will be implemented',
          style: TextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.save),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, exercise, S s) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          s.delete_exercise_confirmation,
          style: TextStyles.headline3,
        ),
        content: Text(s.delete_exercise_message, style: TextStyles.bodyMedium),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.exercise_deleted),
                  backgroundColor: ColorsManager.error,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.error,
            ),
            child: Text(s.delete),
          ),
        ],
      ),
    );
  }
}
