import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import 'package:intl/intl.dart';

// class CreateWorkoutDialog extends StatefulWidget {
//   final Function(DateTime date, String? notes) onConfirm;
//
//   const CreateWorkoutDialog({super.key, required this.onConfirm});
//
//   @override
//   State<CreateWorkoutDialog> createState() => _CreateWorkoutDialogState();
// }
//
// class _CreateWorkoutDialogState extends State<CreateWorkoutDialog>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
//
//   late DateTime _selectedDate;
//   final TextEditingController _notesController = TextEditingController();
//   bool _showAdvancedOptions = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = DateTime.now();
//     _setupAnimations();
//     _controller.forward();
//   }
//
//   void _setupAnimations() {
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
//
//     _fadeAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     _notesController.dispose();
//     super.dispose();
//   }
//
//   void _closeDialog() async {
//     await _controller.reverse();
//     if (mounted) Navigator.pop(context);
//   }
//
//   void _confirmAndClose() async {
//     final notes = _notesController.text.trim();
//     await _controller.reverse();
//     if (mounted) {
//       Navigator.pop(context);
//       widget.onConfirm(_selectedDate, notes.isEmpty ? null : notes);
//     }
//   }
//
//   Future<void> _selectDate() async {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final initialDate = _selectedDate;
//
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: initialDate.isBefore(today) ? today : initialDate,
//       // ✅ Only allow today or future dates
//       firstDate: today,
//       lastDate: now.add(const Duration(days: 365)), // Allow up to 1 year ahead
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: const ColorScheme.light(
//               primary: ColorsManager.primaryGreen,
//               onPrimary: Colors.white,
//               surface: ColorsManager.cardBackground,
//               onSurface: ColorsManager.primaryText,
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//       });
//     }
//   }
//
//   String _getDateLabel() {
//     final now = DateTime.now();
//     final today = DateTime(now.year, now.month, now.day);
//     final tomorrow = today.add(const Duration(days: 1));
//     final selectedDay = DateTime(
//       _selectedDate.year,
//       _selectedDate.month,
//       _selectedDate.day,
//     );
//
//     if (selectedDay == today) {
//       return S.of(context).today;
//     } else if (selectedDay == tomorrow) {
//       return S.of(context).tomorrow;
//     } else {
//       return DateFormat('EEEE, MMM d, yyyy').format(_selectedDate);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return FadeTransition(
//       opacity: _fadeAnimation,
//       child: Dialog(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         child: ScaleTransition(
//           scale: _scaleAnimation,
//           child: SlideTransition(
//             position: _slideAnimation,
//             child: Container(
//               padding: EdgeInsets.all(24.w),
//               decoration: BoxDecoration(
//                 color: ColorsManager.cardBackground,
//                 borderRadius: BorderRadius.circular(20.r),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.2),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Icon with animation
//                     TweenAnimationBuilder<double>(
//                       tween: Tween(begin: 0.0, end: 1.0),
//                       duration: const Duration(milliseconds: 600),
//                       curve: Curves.elasticOut,
//                       builder: (context, value, child) {
//                         return Transform.scale(
//                           scale: value,
//                           child: Container(
//                             width: 80.w,
//                             height: 80.w,
//                             decoration: BoxDecoration(
//                               color: ColorsManager.primaryGreen.withValues(
//                                 alpha: 0.1,
//                               ),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.fitness_center,
//                               size: 40.sp,
//                               color: ColorsManager.primaryGreen,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                     SizedBox(height: 20.h),
//
//                     // Title
//                     Text(
//                       s.create_new_workout,
//                       style: TextStyles.headline3,
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 12.h),
//
//                     // Description
//                     Text(
//                       s.select_workout_date,
//                       style: TextStyles.bodyMedium.copyWith(
//                         color: ColorsManager.lightText,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 24.h),
//
//                     // Date Selector
//                     _buildDateSelector(s),
//                     SizedBox(height: 16.h),
//
//                     // Advanced Options Toggle
//                     _buildAdvancedOptionsToggle(s),
//
//                     // Notes Field (Expandable)
//                     AnimatedSize(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       child: _showAdvancedOptions
//                           ? Column(
//                               children: [
//                                 SizedBox(height: 16.h),
//                                 _buildNotesField(s),
//                               ],
//                             )
//                           : const SizedBox.shrink(),
//                     ),
//
//                     SizedBox(height: 24.h),
//
//                     // Buttons
//                     Row(
//                       children: [
//                         Expanded(child: _buildCancelButton(s)),
//                         SizedBox(width: 12.w),
//                         Expanded(flex: 2, child: _buildConfirmButton(s)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDateSelector(S s) {
//     return InkWell(
//       onTap: _selectDate,
//       borderRadius: BorderRadius.circular(12.r),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: ColorsManager.primaryGreen.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(12.r),
//           border: Border.all(
//             color: ColorsManager.primaryGreen.withValues(alpha: 0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: EdgeInsets.all(8.w),
//               decoration: BoxDecoration(
//                 color: ColorsManager.primaryGreen,
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               child: Icon(
//                 Icons.calendar_today,
//                 color: Colors.white,
//                 size: 20.sp,
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     s.workout_date,
//                     style: TextStyles.bodySmall.copyWith(
//                       color: ColorsManager.lightText,
//                     ),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     _getDateLabel(),
//                     style: TextStyles.font16PrimaryTextSemiBold.copyWith(
//                       color: ColorsManager.primaryGreen,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Icon(
//               Icons.chevron_right,
//               color: ColorsManager.primaryGreen,
//               size: 24.sp,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAdvancedOptionsToggle(S s) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           _showAdvancedOptions = !_showAdvancedOptions;
//         });
//       },
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             s.add_notes,
//             style: TextStyles.bodySmall.copyWith(
//               color: ColorsManager.primaryGreen,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           SizedBox(width: 4.w),
//           AnimatedRotation(
//             turns: _showAdvancedOptions ? 0.5 : 0,
//             duration: const Duration(milliseconds: 300),
//             child: Icon(
//               Icons.keyboard_arrow_down,
//               color: ColorsManager.primaryGreen,
//               size: 20.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNotesField(S s) {
//     return TextField(
//       controller: _notesController,
//       maxLines: 3,
//       maxLength: 200,
//       decoration: InputDecoration(
//         hintText: s.add_workout_notes,
//         hintStyle: TextStyles.bodySmall.copyWith(
//           color: ColorsManager.lightText,
//         ),
//         filled: true,
//         fillColor: ColorsManager.scaffoldBackground,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: ColorsManager.lightBorder),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: ColorsManager.lightBorder),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           borderSide: BorderSide(color: ColorsManager.primaryGreen, width: 2),
//         ),
//         contentPadding: EdgeInsets.all(12.w),
//         counterStyle: TextStyles.caption.copyWith(
//           color: ColorsManager.lightText,
//         ),
//       ),
//       style: TextStyles.bodyMedium,
//     );
//   }
//
//   Widget _buildCancelButton(S s) {
//     return TextButton(
//       onPressed: _closeDialog,
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.symmetric(vertical: 14.h),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//           side: BorderSide(color: ColorsManager.lightBorder),
//         ),
//       ),
//       child: Text(
//         s.cancel,
//         style: TextStyles.bodyMedium.copyWith(
//           color: ColorsManager.primaryText,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildConfirmButton(S s) {
//     return ElevatedButton(
//       onPressed: _confirmAndClose,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: ColorsManager.primaryGreen,
//         padding: EdgeInsets.symmetric(vertical: 14.h),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         elevation: 0,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.add, color: Colors.white),
//           SizedBox(width: 8.w),
//           Text(s.create, style: TextStyles.buttonMedium),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import 'package:intl/intl.dart';

class CreateWorkoutDialog extends StatefulWidget {
  final Function(DateTime date, String? notes) onConfirm;

  const CreateWorkoutDialog({super.key, required this.onConfirm});

  @override
  State<CreateWorkoutDialog> createState() => _CreateWorkoutDialogState();
}

class _CreateWorkoutDialogState extends State<CreateWorkoutDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  late DateTime _selectedDate;
  final TextEditingController _notesController = TextEditingController();
  bool _showAdvancedOptions = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _setupAnimations();
    _controller.forward();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _closeDialog() async {
    await _controller.reverse();
    if (mounted) Navigator.pop(context);
  }

  void _confirmAndClose() async {
    final notes = _notesController.text.trim();
    await _controller.reverse();
    if (mounted) {
      Navigator.pop(context);
      widget.onConfirm(_selectedDate, notes.isEmpty ? null : notes);
    }
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

    if (selectedDay == today) return S.of(context).today;
    if (selectedDay == tomorrow) return S.of(context).tomorrow;
    return DateFormat('EEEE, MMM d, yyyy').format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Theme.of(context).cardTheme.color,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.5 : 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: ColorsManager.getPrimaryGreen(
                                context,
                              ).withValues(alpha: isDark ? 0.15 : 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.fitness_center,
                              size: 40.sp,
                              color: ColorsManager.getPrimaryGreen(context),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      s.create_new_workout,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.getPrimaryText(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      s.select_workout_date,
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.h),
                    _buildDateSelector(s, isDark),
                    SizedBox(height: 16.h),
                    _buildAdvancedOptionsToggle(s),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: _showAdvancedOptions
                          ? Column(
                              children: [
                                SizedBox(height: 16.h),
                                _buildNotesField(s, isDark),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        Expanded(child: _buildCancelButton(s, isDark)),
                        SizedBox(width: 12.w),
                        Expanded(
                          flex: 2,
                          child: _buildConfirmButton(s, isDark),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSelector(S s, bool isDark) {
    return InkWell(
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
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorsManager.getPrimaryGreen(context),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.calendar_today,
                color: isDark ? ColorsManager.darkScaffold : Colors.white,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.workout_date,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _getDateLabel(),
                    style: TextStyle(
                      fontSize: 16,
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
    );
  }

  Widget _buildAdvancedOptionsToggle(S s) {
    return InkWell(
      onTap: () => setState(() => _showAdvancedOptions = !_showAdvancedOptions),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            s.add_notes,
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.getPrimaryGreen(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 4.w),
          AnimatedRotation(
            turns: _showAdvancedOptions ? 0.5 : 0,
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: ColorsManager.getPrimaryGreen(context),
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesField(S s, bool isDark) {
    return TextField(
      controller: _notesController,
      maxLines: 3,
      maxLength: 200,
      decoration: InputDecoration(
        hintText: s.add_workout_notes,
        hintStyle: TextStyle(
          fontSize: 12,
          color: ColorsManager.getSecondaryText(context),
        ),
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
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
        contentPadding: EdgeInsets.all(12.w),
        counterStyle: TextStyle(
          fontSize: 10,
          color: ColorsManager.getSecondaryText(context),
        ),
      ),
      style: TextStyle(
        fontSize: 14,
        color: ColorsManager.getPrimaryText(context),
      ),
    );
  }

  Widget _buildCancelButton(S s, bool isDark) {
    return TextButton(
      onPressed: _closeDialog,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: isDark
                ? ColorsManager.darkBorder
                : ColorsManager.lightBorder,
          ),
        ),
      ),
      child: Text(
        s.cancel,
        style: TextStyle(
          fontSize: 14,
          color: ColorsManager.getPrimaryText(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildConfirmButton(S s, bool isDark) {
    return ElevatedButton(
      onPressed: _confirmAndClose,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.getPrimaryGreen(context),
        padding: EdgeInsets.symmetric(vertical: 14.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add,
            color: isDark ? ColorsManager.darkScaffold : Colors.white,
          ),
          SizedBox(width: 8.w),
          Text(
            s.create,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? ColorsManager.darkScaffold : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
