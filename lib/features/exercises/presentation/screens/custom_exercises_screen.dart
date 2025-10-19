import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/exercise_model.dart';
import '../widgets/custom_exercise_widgets/custom_exercise_card.dart';
import '../widgets/custom_exercise_widgets/empty_exercises_state.dart';
import '../widgets/exercise_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/custom_exercises_cubit.dart';
import '../cubit/custom_exercises_state.dart';

//
// class CustomExercisesScreen extends StatefulWidget {
//   const CustomExercisesScreen({super.key});
//
//   @override
//   State<CustomExercisesScreen> createState() => _CustomExercisesScreenState();
// }
//
// class _CustomExercisesScreenState extends State<CustomExercisesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _loadCustomExercises();
//   }
//
//   void _loadCustomExercises() {
//     context.read<CustomExercisesCubit>().loadCustomExercises();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       appBar: AppBar(
//         title: Text(s.my_custom_exercises, style: TextStyles.headline2),
//         backgroundColor: ColorsManager.scaffoldBackground,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios, color: ColorsManager.primaryText),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: BlocConsumer<CustomExercisesCubit, CustomExercisesState>(
//         listener: (context, state) {
//           if (state is CustomExercisesError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is CustomExercisesLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: ColorsManager.primaryGreen,
//               ),
//             );
//           }
//
//           if (state is CustomExercisesLoaded) {
//             if (state.exercises.isEmpty) {
//               return _buildEmptyState(context, s);
//             }
//
//             return RefreshIndicator(
//               onRefresh: () async {
//                 _loadCustomExercises();
//               },
//               color: ColorsManager.primaryGreen,
//               child: ListView.builder(
//                 padding: EdgeInsets.all(20.w),
//                 itemCount: state.exercises.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: EdgeInsets.only(bottom: 12.h),
//                     child: ExerciseCard(
//                       exercise: state.exercises[index],
//                       onTap: () {
//                         _showExerciseOptions(
//                           context,
//                           state.exercises[index],
//                           s,
//                         );
//                       },
//                     ),
//                   );
//                 },
//               ),
//             );
//           }
//
//           return _buildEmptyState(context, s);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           _showCreateExerciseDialog(context, s);
//         },
//         backgroundColor: ColorsManager.primaryGreen,
//         icon: const Icon(Icons.add),
//         label: Text(s.create_custom_exercise, style: TextStyles.buttonMedium),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(BuildContext context, S s) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(40.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.fitness_center_outlined,
//               size: 100.sp,
//               color: ColorsManager.lightText,
//             ),
//             SizedBox(height: 24.h),
//             Text(
//               s.no_custom_exercises_yet,
//               style: TextStyles.headline3,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 12.h),
//             Text(
//               s.create_your_own_exercises,
//               style: TextStyles.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 32.h),
//             ElevatedButton.icon(
//               onPressed: () {
//                 _showCreateExerciseDialog(context, s);
//               },
//               icon: const Icon(Icons.add),
//               label: Text(s.create_your_first_exercise),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: ColorsManager.primaryGreen,
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _showExerciseOptions(BuildContext context, exercise, S s) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: ColorsManager.cardBackground,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (bottomSheetContext) {
//         return Padding(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(exercise.name, style: TextStyles.headline3),
//               SizedBox(height: 20.h),
//               ListTile(
//                 leading: const Icon(
//                   Icons.visibility,
//                   color: ColorsManager.primaryGreen,
//                 ),
//                 title: Text(s.view_details),
//                 onTap: () {
//                   Navigator.pop(bottomSheetContext);
//                   Navigator.pushNamed(
//                     context,
//                     Routes.exerciseDetails,
//                     arguments: exercise,
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.add_circle,
//                   color: ColorsManager.info,
//                 ),
//                 title: Text(s.add_to_workout),
//                 onTap: () {
//                   Navigator.pop(bottomSheetContext);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(s.added_to_workout),
//                       backgroundColor: ColorsManager.success,
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.delete, color: ColorsManager.error),
//                 title: Text(s.delete_exercise),
//                 onTap: () {
//                   Navigator.pop(bottomSheetContext);
//                   _showDeleteConfirmation(context, exercise, s);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _showCreateExerciseDialog(BuildContext context, S s) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: ColorsManager.cardBackground,
//         title: Text(s.create_custom_exercise, style: TextStyles.headline3),
//         content: Text(
//           'Please select a section first to create a custom exercise',
//           style: TextStyles.bodyMedium,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(s.cancel),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               Navigator.pop(context); // Go back to home to select section
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ColorsManager.primaryGreen,
//             ),
//             child: Text('Select Section'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _showDeleteConfirmation(BuildContext context, exercise, S s) {
//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         backgroundColor: ColorsManager.cardBackground,
//         title: Text(
//           s.delete_exercise_confirmation,
//           style: TextStyles.headline3,
//         ),
//         content: Text(s.delete_exercise_message, style: TextStyles.bodyMedium),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(dialogContext),
//             child: Text(s.cancel),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(dialogContext);
//
//               // Show loading
//               await context.read<CustomExercisesCubit>().deleteCustomExercise(
//                 exercise.id,
//               );
//
//               // Check state after deletion
//               if (mounted &&
//                   context.read<CustomExercisesCubit>().state
//                       is CustomExercisesLoaded) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(s.exercise_deleted),
//                     backgroundColor: ColorsManager.success,
//                   ),
//                 );
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ColorsManager.error,
//             ),
//             child: Text(s.delete),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/l10n.dart';

// class CustomExercisesScreen extends StatefulWidget {
//   const CustomExercisesScreen({super.key});
//
//   @override
//   State<CustomExercisesScreen> createState() => _CustomExercisesScreenState();
// }
//
// class _CustomExercisesScreenState extends State<CustomExercisesScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _loadCustomExercises();
//   }
//
//   void _loadCustomExercises() {
//     context.read<CustomExercisesCubit>().loadCustomExercises();
//   }
//
//   void _handleDelete(String exerciseId) {
//     context.read<CustomExercisesCubit>().deleteCustomExercise(exerciseId);
//   }
//
//   void _navigateToExerciseDetails(dynamic exercise) {
//     Navigator.pushNamed(context, Routes.exerciseDetails, arguments: exercise);
//   }
//
//   void _navigateToSelectSection() {
//     Navigator.pop(context);
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
//         builder: (context, state) => _buildBody(context, state, s),
//       ),
//       floatingActionButton: _buildFAB(s),
//     );
//   }
//
//   AppBar _buildAppBar(S s) {
//     return AppBar(
//       title: Text(s.my_custom_exercises, style: TextStyles.headline2),
//       backgroundColor: ColorsManager.scaffoldBackground,
//       elevation: 0,
//       leading: IconButton(
//         icon: Icon(Icons.arrow_back_ios, color: ColorsManager.primaryText),
//         onPressed: () => Navigator.pop(context),
//       ),
//     );
//   }
//
//   void _handleStateChanges(BuildContext context, CustomExercisesState state) {
//     if (state is CustomExercisesError) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(state.message),
//           backgroundColor: ColorsManager.error,
//         ),
//       );
//     }
//   }
//
//   Widget _buildBody(BuildContext context, CustomExercisesState state, S s) {
//     if (state is CustomExercisesLoading) {
//       return Center(
//         child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
//       );
//     }
//
//     if (state is CustomExercisesLoaded) {
//       if (state.exercises.isEmpty) {
//         return EmptyExercisesState(
//           onCreateTap: () => _navigateToSelectSection(),
//         );
//       }
//
//       return RefreshIndicator(
//         onRefresh: () async => _loadCustomExercises(),
//         color: ColorsManager.primaryGreen,
//         child: ListView.builder(
//           padding: EdgeInsets.all(20.w),
//           itemCount: state.exercises.length,
//           itemBuilder: (context, index) {
//             final exercise = state.exercises[index];
//             return Padding(
//               padding: EdgeInsets.only(bottom: 12.h),
//               child: CustomExerciseCard(
//                 exercise: exercise,
//                 onTap: () => _navigateToExerciseDetails(exercise),
//                 onDelete: () => _handleDelete(exercise.id),
//               ),
//             );
//           },
//         ),
//       );
//     }
//
//     return EmptyExercisesState(onCreateTap: () => _navigateToSelectSection());
//   }
//
//   Widget _buildFAB(S s) {
//     return FloatingActionButton.extended(
//       onPressed: _navigateToSelectSection,
//       backgroundColor: ColorsManager.primaryGreen,
//       icon: const Icon(Icons.add),
//       label: Text(s.create_custom_exercise, style: TextStyles.buttonMedium),
//     );
//   }
// }
// custom_exercises_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExercisesScreen extends StatefulWidget {
  const CustomExercisesScreen({super.key});

  @override
  State<CustomExercisesScreen> createState() => _CustomExercisesScreenState();
}

class _CustomExercisesScreenState extends State<CustomExercisesScreen> {
  @override
  void initState() {
    super.initState();
    _loadCustomExercises();
  }

  void _loadCustomExercises() {
    context.read<CustomExercisesCubit>().loadCustomExercises();
  }

  void _handleDelete(String exerciseId) {
    context.read<CustomExercisesCubit>().deleteCustomExercise(exerciseId);
  }

  void _navigateToExerciseDetails(dynamic exercise) {
    Navigator.pushNamed(context, Routes.exerciseDetails, arguments: exercise);
  }

  void _navigateToSelectSection() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: _buildAppBar(s),
      body: BlocConsumer<CustomExercisesCubit, CustomExercisesState>(
        listener: _handleStateChanges,
        builder: (context, state) => _buildBody(context, state, s),
      ),
      // floatingActionButton: _buildFAB(s),
    );
  }

  AppBar _buildAppBar(S s) {
    return AppBar(
      title: Text(s.my_custom_exercises, style: TextStyles.headline3),
      backgroundColor: ColorsManager.scaffoldBackground,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: ColorsManager.primaryText),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  void _handleStateChanges(BuildContext context, CustomExercisesState state) {
    if (state is CustomExercisesError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: ColorsManager.error,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, CustomExercisesState state, S s) {
    // Handle loading state
    if (state is CustomExercisesLoading) {
      return Center(
        child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
      );
    }

    // Extract exercises from different states
    List<ExerciseModel>? exercises;
    bool isDeleting = false;

    if (state is CustomExercisesLoaded) {
      exercises = state.exercises;
    } else if (state is CustomExercisesDeleting) {
      exercises = state.exercises;
      isDeleting = true;
    } else if (state is CustomExercisesError) {
      exercises = state.exercises;
    }

    // Show empty state if no exercises
    if (exercises == null || exercises.isEmpty) {
      return EmptyExercisesState(onCreateTap: () => _navigateToSelectSection());
    }

    // Build list with exercises
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () async => _loadCustomExercises(),
          color: ColorsManager.primaryGreen,
          child: ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises![index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: CustomExerciseCard(
                  exercise: exercise,
                  onTap: () => _navigateToExerciseDetails(exercise),
                  onDelete: () => _handleDelete(exercise.id),
                ),
              );
            },
          ),
        ),
        // Show loading overlay when deleting
        if (isDeleting)
          Container(
            color: Colors.black12,
            child: Center(
              child: Card(
                color: ColorsManager.cardBackground,
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        color: ColorsManager.primaryGreen,
                      ),
                      SizedBox(height: 16.h),
                      Text(s.deleting, style: TextStyles.bodyMedium),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFAB(S s) {
    return FloatingActionButton.extended(
      onPressed: _navigateToSelectSection,
      backgroundColor: ColorsManager.primaryGreen,
      icon: const Icon(Icons.add),
      label: Text(s.create_custom_exercise, style: TextStyles.buttonMedium),
    );
  }
}
