import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../cubit/workouts_cubit.dart';
import '../cubit/workouts_state.dart';

class AddSetDialog extends StatefulWidget {
  final String sessionId;
  final String exerciseId;
  final int setNumber;
  final int? initialReps;
  final double? initialWeight;
  final int? initialRestTime;
  final String? initialNotes;
  final String? setId;
  final bool isEdit;
  final VoidCallback onSetAdded;

  const AddSetDialog({
    super.key,
    required this.sessionId,
    required this.exerciseId,
    required this.setNumber,
    this.initialReps,
    this.initialWeight,
    this.initialRestTime,
    this.initialNotes,
    this.setId,
    this.isEdit = false,
    required this.onSetAdded,
  });

  @override
  State<AddSetDialog> createState() => _AddSetDialogState();
}

class _AddSetDialogState extends State<AddSetDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _repsController;
  late final TextEditingController _weightController;
  late final TextEditingController _restTimeController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _repsController = TextEditingController(
      text: widget.initialReps?.toString() ?? '',
    );
    _weightController = TextEditingController(
      text: widget.initialWeight?.toString() ?? '',
    );
    _restTimeController = TextEditingController(
      text: widget.initialRestTime?.toString() ?? '',
    );
    _notesController = TextEditingController(text: widget.initialNotes ?? '');
  }

  @override
  void dispose() {
    _repsController.dispose();
    _weightController.dispose();
    _restTimeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final reps = int.parse(_repsController.text);
      final weight = double.parse(_weightController.text);
      final restTime = _restTimeController.text.isNotEmpty
          ? int.parse(_restTimeController.text)
          : null;
      final notes = _notesController.text.isNotEmpty
          ? _notesController.text
          : null;

      if (widget.isEdit && widget.setId != null) {
        context.read<WorkoutsCubit>().updateExerciseSet(
          sessionId: widget.sessionId,
          exerciseId: widget.exerciseId,
          setId: widget.setId!,
          setNumber: widget.setNumber,
          reps: reps,
          weightKg: weight,
          restTimeSeconds: restTime,
          notes: notes,
          isCompleted: true,
          isPersonalRecord: false,
        );
      } else {
        context.read<WorkoutsCubit>().addSetToExercise(
          sessionId: widget.sessionId,
          exerciseId: widget.exerciseId,
          setNumber: widget.setNumber,
          reps: reps,
          weightKg: weight,
          restTimeSeconds: restTime,
          notes: notes,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      backgroundColor: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
        listener: (context, state) {
          if (state is SetAddedToExercise || state is SetUpdated) {
            widget.onSetAdded();
          }

          if (state is WorkoutsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is WorkoutsLoading;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.isEdit ? s.edit_set : s.add_set,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorsManager.getPrimaryGreen(
                              context,
                            ).withValues(alpha: isDark ? 0.15 : 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '${s.set} ${widget.setNumber}',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorsManager.getPrimaryGreen(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _repsController,
                            label: s.reps,
                            hint: '12',
                            isRequired: true,
                            enabled: !isLoading,
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.repeat,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return s.please_enter_reps;
                              if (int.tryParse(value) == null)
                                return s.please_enter_valid_number;
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomTextField(
                            controller: _weightController,
                            label: s.weight_kg,
                            hint: '10',
                            isRequired: true,
                            enabled: !isLoading,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            prefixIcon: Icons.fitness_center,
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return s.please_enter_weight;
                              if (double.tryParse(value) == null)
                                return s.please_enter_valid_number;
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _restTimeController,
                      label: s.rest_time_seconds,
                      hint: '60',
                      enabled: !isLoading,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.timer,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: _notesController,
                      label: s.notes,
                      hint: s.optional_notes,
                      enabled: !isLoading,
                      maxLines: 2,
                      prefixIcon: Icons.note_outlined,
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.pop(context),
                            child: Text(
                              s.cancel,
                              style: TextStyle(
                                fontSize: 14,
                                color: ColorsManager.getPrimaryText(context),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.getPrimaryGreen(
                                context,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: isDark
                                          ? ColorsManager.darkScaffold
                                          : Colors.white,
                                    ),
                                  )
                                : Text(
                                    widget.isEdit ? s.update : s.add,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: isDark
                                          ? ColorsManager.darkScaffold
                                          : Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
