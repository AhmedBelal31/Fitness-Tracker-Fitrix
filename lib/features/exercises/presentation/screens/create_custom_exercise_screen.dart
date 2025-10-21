import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/common_ui/widgets/custom_text_field.dart';
import '../../../../core/common_ui/widgets/form_fields/animated_form_field.dart';
import '../../../../core/common_ui/widgets/form_fields/app_dropdown_field.dart';
import '../../../../core/common_ui/widgets/form_fields/app_image_picker.dart';
import '../../../../core/common_ui/widgets/form_fields/app_text_field.dart';
import '../../../../core/enums/difficulty_level.dart';
import '../../../../core/helpers/equipment_constants.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../data/models/custom_exercise_request.dart';
import '../cubit/custom_exercises_cubit.dart';
import '../cubit/custom_exercises_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../generated/l10n.dart';

//
// class CreateCustomExerciseScreen extends StatefulWidget {
//   final String sectionId;
//
//   const CreateCustomExerciseScreen({super.key, required this.sectionId});
//
//   @override
//   State<CreateCustomExerciseScreen> createState() =>
//       _CreateCustomExerciseScreenState();
// }
//
// class _CreateCustomExerciseScreenState extends State<CreateCustomExerciseScreen>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _instructionsController = TextEditingController();
//   final _customEquipmentController = TextEditingController();
//
//   DifficultyLevel? _selectedDifficulty;
//   String? _selectedEquipment;
//   File? _selectedImage;
//   bool _isCustomEquipment = false;
//
//   late AnimationController _buttonController;
//   late Animation<double> _buttonAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupButtonAnimation();
//   }
//
//   void _setupButtonAnimation() {
//     _buttonController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//
//     _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
//     );
//
//     Future.delayed(const Duration(milliseconds: 600), () {
//       if (mounted) _buttonController.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _instructionsController.dispose();
//     _customEquipmentController.dispose();
//     _buttonController.dispose();
//     super.dispose();
//   }
//
//   String? get finalEquipment {
//     if (_isCustomEquipment) {
//       return _customEquipmentController.text.trim().isNotEmpty
//           ? _customEquipmentController.text.trim()
//           : null;
//     }
//     return _selectedEquipment;
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       final request = CreateCustomExerciseRequest(
//         sectionId: widget.sectionId,
//         name: _nameController.text.trim(),
//         description: _descriptionController.text.trim().isNotEmpty
//             ? _descriptionController.text.trim()
//             : null,
//         instructions: _instructionsController.text.trim().isNotEmpty
//             ? _instructionsController.text.trim()
//             : null,
//         equipment: finalEquipment,
//         difficultyLevel: _selectedDifficulty?.displayName,
//         imageFile: _selectedImage,
//       );
//
//       context.read<CustomExercisesCubit>().createCustomExercise(request);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       appBar: _buildAppBar(s),
//       body: BlocConsumer<CustomExercisesCubit, CustomExercisesState>(
//         listener: _handleStateChanges,
//         builder: (context, state) {
//           final isLoading = state is CustomExercisesCreating;
//           return _buildForm(s, isLoading);
//         },
//       ),
//     );
//   }
//
//   // ========== APP BAR ==========
//   AppBar _buildAppBar(S s) {
//     return AppBar(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back_ios, color: ColorsManager.primaryText),
//         onPressed: () => Navigator.pop(context),
//       ),
//       title: Text(s.create_custom_exercise, style: TextStyles.subtitle1),
//     );
//   }
//
//   void _handleStateChanges(BuildContext context, CustomExercisesState state) {
//     if (state is CustomExerciseCreated) {
//       // ✅ Pop with success result
//       Navigator.pop(context, true);
//     }
//
//     if (state is CustomExercisesError) {
//       if (!mounted) return;
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(state.message),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           duration: const Duration(seconds: 3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//         ),
//       );
//     }
//   }
//
//   // ========== FORM ==========
//   Widget _buildForm(S s, bool isLoading) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.all(20.w),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               AnimatedFormField(
//                 index: 0,
//                 child: AppImagePicker(
//                   selectedImage: _selectedImage,
//                   enabled: !isLoading,
//                   onImagePicked: (image) =>
//                       setState(() => _selectedImage = image),
//                 ),
//               ),
//               SizedBox(height: 24.h),
//
//               AnimatedFormField(
//                 index: 1,
//                 child: AppTextField(
//                   controller: _nameController,
//                   label: s.exercise_name,
//                   hintText: s.eg_chest_press,
//                   isRequired: true,
//                   enabled: !isLoading,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return s.please_enter_exercise_name;
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               AnimatedFormField(
//                 index: 2,
//                 child: AppTextField(
//                   controller: _descriptionController,
//                   label: s.description,
//                   hintText: s.brief_description_of_the_exercise,
//                   enabled: !isLoading,
//                   maxLines: 3,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               AnimatedFormField(
//                 index: 3,
//                 child: AppTextField(
//                   controller: _instructionsController,
//                   label: s.instructions,
//                   hintText: s.step_by_step_instructions,
//                   enabled: !isLoading,
//                   maxLines: 4,
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               AnimatedFormField(
//                 index: 4,
//                 child: AppDropdownField(
//                   label: s.equipment,
//                   hintText: s.select_equipment,
//                   value: _selectedEquipment,
//                   items: EquipmentConstants.getLocalizedEquipment(s),
//                   enabled: !isLoading,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedEquipment = value;
//                       _isCustomEquipment = value == s.other_custom;
//                       if (!_isCustomEquipment) {
//                         _customEquipmentController.clear();
//                       }
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 20.h),
//
//               if (_isCustomEquipment) ...[
//                 AnimatedFormField(
//                   index: 5,
//                   child: AppTextField(
//                     controller: _customEquipmentController,
//                     label: s.custom_equipment,
//                     hintText: s.enter_your_equipment_name,
//                     isRequired: true,
//                     enabled: !isLoading,
//                     validator: (value) {
//                       if (_isCustomEquipment &&
//                           (value == null || value.trim().isEmpty)) {
//                         return s.please_enter_custom_equipment_name;
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//               ],
//
//               AnimatedFormField(
//                 index: 6,
//                 child: AppDropdownField(
//                   label: s.difficulty,
//                   hintText: s.select_difficulty,
//                   value: _selectedDifficulty?.displayName,
//                   items: DifficultyLevel.values
//                       .map((e) => e.displayName)
//                       .toList(),
//                   enabled: !isLoading,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedDifficulty = DifficultyLevel.fromString(value);
//                     });
//                   },
//                 ),
//               ),
//               SizedBox(height: 32.h),
//
//               _buildSubmitButton(s, isLoading),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ========== SUBMIT BUTTON ==========
//   Widget _buildSubmitButton(S s, bool isLoading) {
//     return ScaleTransition(
//       scale: _buttonAnimation,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : _submitForm,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: ColorsManager.primaryGreen,
//           padding: EdgeInsets.symmetric(vertical: 16.h),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           disabledBackgroundColor: Colors.grey,
//           elevation: isLoading ? 0 : 4,
//         ),
//         child: isLoading
//             ? SizedBox(
//                 height: 20.h,
//                 width: 20.w,
//                 child: const CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Colors.white,
//                 ),
//               )
//             : Text(s.create_custom_exercise, style: TextStyles.buttonLarge),
//       ),
//     );
//   }
// }
class CreateCustomExerciseScreen extends StatefulWidget {
  final String sectionId;

  const CreateCustomExerciseScreen({super.key, required this.sectionId});

  @override
  State<CreateCustomExerciseScreen> createState() =>
      _CreateCustomExerciseScreenState();
}

class _CreateCustomExerciseScreenState extends State<CreateCustomExerciseScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _customEquipmentController = TextEditingController();

  DifficultyLevel? _selectedDifficulty;
  String? _selectedEquipment;
  File? _selectedImage;
  bool _isCustomEquipment = false;

  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  late AnimationController _headerController;

  @override
  void initState() {
    super.initState();
    _setupButtonAnimation();
    _setupHeaderAnimation();
  }

  void _setupButtonAnimation() {
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _buttonAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _buttonController.forward();
    });
  }

  void _setupHeaderAnimation() {
    _headerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _instructionsController.dispose();
    _customEquipmentController.dispose();
    _buttonController.dispose();
    _headerController.dispose();
    super.dispose();
  }

  String? get finalEquipment {
    if (_isCustomEquipment) {
      return _customEquipmentController.text.trim().isNotEmpty
          ? _customEquipmentController.text.trim()
          : null;
    }
    return _selectedEquipment;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final request = CreateCustomExerciseRequest(
        sectionId: widget.sectionId,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        instructions: _instructionsController.text.trim().isNotEmpty
            ? _instructionsController.text.trim()
            : null,
        equipment: finalEquipment,
        difficultyLevel: _selectedDifficulty?.displayName,
        imageFile: _selectedImage,
      );

      context.read<CustomExercisesCubit>().createCustomExercise(request);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<CustomExercisesCubit, CustomExercisesState>(
        listener: _handleStateChanges,
        builder: (context, state) {
          final isLoading = state is CustomExercisesCreating;
          return Column(
            children: [
              _buildAnimatedHeader(s),
              Expanded(child: _buildForm(s, isLoading)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAnimatedHeader(S s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 170.h, // ✅ Increased from 160.h to 220.h
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorsManager.darkPrimaryGreen,
                  ColorsManager.darkSecondaryGreen,
                ],
              )
            : ColorsManager.primaryGradient,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _headerController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _FormHeaderPainter(
                    animation: _headerController.value,
                    isDark: isDark,
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Header with back button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: isDark
                              ? ColorsManager.darkScaffold
                              : Colors.white,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          s.create_custom_exercise,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? ColorsManager.darkScaffold
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 48.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleStateChanges(BuildContext context, CustomExercisesState state) {
    if (state is CustomExerciseCreated) {
      Navigator.pop(context, true);
    }

    if (state is CustomExercisesError) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      );
    }
  }

  Widget _buildForm(S s, bool isLoading) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedFormField(
                index: 0,
                child: AppImagePicker(
                  selectedImage: _selectedImage,
                  enabled: !isLoading,
                  onImagePicked: (image) =>
                      setState(() => _selectedImage = image),
                ),
              ),
              SizedBox(height: 24.h),
              AnimatedFormField(
                index: 1,
                child: CustomTextField(
                  controller: _nameController,
                  label: s.exercise_name,
                  hint: s.eg_chest_press,
                  isRequired: true,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return s.please_enter_exercise_name;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.h),
              AnimatedFormField(
                index: 2,
                child: CustomTextField(
                  controller: _descriptionController,
                  label: s.description,
                  hint: s.brief_description_of_the_exercise,
                  enabled: !isLoading,
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 20.h),
              AnimatedFormField(
                index: 3,
                child: CustomTextField(
                  controller: _instructionsController,
                  label: s.instructions,
                  hint: s.step_by_step_instructions,
                  enabled: !isLoading,
                  maxLines: 4,
                ),
              ),
              SizedBox(height: 20.h),
              AnimatedFormField(
                index: 4,
                child: AppDropdownField(
                  label: s.equipment,
                  hintText: s.select_equipment,
                  value: _selectedEquipment,
                  items: EquipmentConstants.getLocalizedEquipment(s),
                  enabled: !isLoading,
                  onChanged: (value) {
                    setState(() {
                      _selectedEquipment = value;
                      _isCustomEquipment = value == s.other_custom;
                      if (!_isCustomEquipment) {
                        _customEquipmentController.clear();
                      }
                    });
                  },
                ),
              ),
              SizedBox(height: 20.h),
              if (_isCustomEquipment) ...[
                AnimatedFormField(
                  index: 5,
                  child: CustomTextField(
                    controller: _customEquipmentController,
                    label: s.custom_equipment,
                    hint: s.enter_your_equipment_name,
                    isRequired: true,
                    enabled: !isLoading,
                    validator: (value) {
                      if (_isCustomEquipment &&
                          (value == null || value.trim().isEmpty)) {
                        return s.please_enter_custom_equipment_name;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20.h),
              ],
              AnimatedFormField(
                index: 6,
                child: AppDropdownField(
                  label: s.difficulty,
                  hintText: s.select_difficulty,
                  value: _selectedDifficulty?.displayName,
                  items: DifficultyLevel.values
                      .map((e) => e.displayName)
                      .toList(),
                  enabled: !isLoading,
                  onChanged: (value) {
                    setState(() {
                      _selectedDifficulty = DifficultyLevel.fromString(value);
                    });
                  },
                ),
              ),
              SizedBox(height: 32.h),
              _buildSubmitButton(s, isLoading),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(S s, bool isLoading) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ScaleTransition(
      scale: _buttonAnimation,
      child: ElevatedButton(
        onPressed: isLoading ? null : _submitForm,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.getPrimaryGreen(context),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: Colors.grey,
          elevation: isLoading ? 0 : 4,
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: isDark ? ColorsManager.darkScaffold : Colors.white,
                ),
              )
            : Text(
                s.create_custom_exercise,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ColorsManager.darkScaffold : Colors.white,
                ),
              ),
      ),
    );
  }
}

// Custom Painter for Animated Header
class _FormHeaderPainter extends CustomPainter {
  final double animation;
  final bool isDark;

  const _FormHeaderPainter({required this.animation, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final color = isDark ? ColorsManager.darkScaffold : Colors.white;

    // Animated waves
    final wavePaint = Paint()
      ..color = color.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (int i = 0; i < 2; i++) {
      final path = Path();
      final offset = animation * size.width;

      for (double x = -size.width; x < size.width * 2; x += 10) {
        final y =
            size.height * 0.5 + math.sin((x + offset) / 40 + (i * 0.5)) * 15;
        if (x == -size.width) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, wavePaint);
    }

    // Dots pattern
    final dotPaint = Paint()
      ..color = color.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    for (double x = 20; x < size.width; x += 50) {
      for (double y = 20; y < size.height; y += 50) {
        canvas.drawCircle(Offset(x, y), 2, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _FormHeaderPainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
