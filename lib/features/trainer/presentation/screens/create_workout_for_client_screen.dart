import 'package:fitrix/core/common_ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../workout/presentation/cubit/workouts_cubit.dart';
import '../../../workout/presentation/cubit/workouts_state.dart';
import '../../data/models/trainee_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateWorkoutForClientScreen extends StatefulWidget {
  final TraineeData trainee;

  const CreateWorkoutForClientScreen({super.key, required this.trainee});

  @override
  State<CreateWorkoutForClientScreen> createState() =>
      _CreateWorkoutForClientScreenState();
}

class _CreateWorkoutForClientScreenState
    extends State<CreateWorkoutForClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final initialDate = _selectedDate;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(today) ? today : initialDate,
      firstDate: today,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: ColorsManager.darkPrimaryGreen,
                    onPrimary: ColorsManager.darkScaffold,
                    surface: ColorsManager.darkCardBackground,
                    onSurface: Colors.white,
                  )
                : ColorScheme.light(
                    primary: ColorsManager.primaryGreen,
                    onPrimary: Colors.white,
                    surface: ColorsManager.cardBackground,
                    onSurface: ColorsManager.primaryText,
                  ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  String _getDateLabel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final selectedDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );

    final s = S.of(context);
    if (selectedDay == today) return s.today;
    if (selectedDay == tomorrow) return s.tomorrow;
    return DateFormat('EEEE, MMM d, yyyy').format(_selectedDate);
  }

  Future<void> _createWorkout() async {
    if (_formKey.currentState!.validate()) {
      // Create workout for trainee
      await context.read<WorkoutsCubit>().createWorkoutSessionForTrainee(
        traineeId: widget.trainee.id,
        date: _selectedDate,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<WorkoutsCubit, WorkoutsState>(
      listener: (context, state) {
        if (state is WorkoutSessionLoaded) {
          // Success - Show success message
          showSuccessSnackBar(
            context: context,
            message: s.workout_created_successfully,
          );

          // Pop this screen and navigate to workout details
          Navigator.pop(context);

          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              Navigator.pushNamed(
                context,
                Routes.workoutDetails,
                arguments: state.session.id,
              );
            }
          });
        } else if (state is WorkoutsError) {
          // Error - Show error message
          showFailureSnackBar(context: context, message: s.error);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: ColorsManager.getSecondaryGreen(context),
          title: Text(s.create_workout_for_client),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Client Info Card
                _buildClientInfoCard(isDark),

                SizedBox(height: 24.h),

                // Date Selector
                Text(
                  s.workout_date,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
                SizedBox(height: 8.h),
                _buildDateSelector(s, isDark),

                SizedBox(height: 24.h),

                // Notes
                Text(
                  s.notes_optional,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  controller: _notesController,
                  maxLines: 4,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: s.add_workout_notes,
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).cardTheme.color,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? ColorsManager.darkBorder
                            : ColorsManager.lightBorder,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: isDark
                            ? ColorsManager.darkBorder
                            : ColorsManager.lightBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color: ColorsManager.getPrimaryGreen(context),
                        width: 2,
                      ),
                    ),
                    counterStyle: TextStyle(
                      fontSize: 10.sp,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // Create Button
                BlocBuilder<WorkoutsCubit, WorkoutsState>(
                  builder: (context, state) {
                    final isLoading = state is WorkoutsLoading;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _createWorkout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.getPrimaryGreen(
                            context,
                          ),
                          disabledBackgroundColor:
                              ColorsManager.getPrimaryGreen(
                                context,
                              ).withValues(alpha: 0.5),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    isDark
                                        ? ColorsManager.darkScaffold
                                        : Colors.white,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: isDark
                                        ? ColorsManager.darkScaffold
                                        : Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    s.create_workout,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: isDark
                                          ? ColorsManager.darkScaffold
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClientInfoCard(bool isDark) {
    final s = S.of(context);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.scale(
          scale: 0.9 + (value * 0.1),
          child: Opacity(
            opacity: value,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(
                  context,
                ).withValues(alpha: isDark ? 0.15 : 0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.4 : 0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28.r,
                    backgroundColor: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: 0.2),
                    backgroundImage:
                        widget.trainee.image != null &&
                            widget.trainee.image!.isNotEmpty
                        ? NetworkImage(widget.trainee.image!)
                        : null,
                    child:
                        widget.trainee.image == null ||
                            widget.trainee.image!.isEmpty
                        ? Text(
                            '${widget.trainee.firstName[0]}${widget.trainee.lastName[0]}'
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.getPrimaryGreen(context),
                            ),
                          )
                        : null,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.creating_workout_for,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.trainee.fullName ??
                              '${widget.trainee.firstName} ${widget.trainee.lastName}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.getPrimaryGreen(context),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fitness_center,
                      color: isDark ? ColorsManager.darkScaffold : Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateSelector(S s, bool isDark) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(20 * (1 - value), 0),
          child: Opacity(
            opacity: value,
            child: InkWell(
              onTap: _selectDate,
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.15 : 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: isDark ? 0.4 : 0.3),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: ColorsManager.getPrimaryGreen(context),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.calendar_today,
                        color: isDark
                            ? ColorsManager.darkScaffold
                            : Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            s.select_workout_date,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            _getDateLabel(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: ColorsManager.getPrimaryGreen(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: ColorsManager.getPrimaryGreen(context),
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
