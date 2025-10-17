import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../exercises/presentation/cubit/exercises_cubit.dart';
import '../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../../exercises/presentation/cubit/sections_state.dart';
import '../../../exercises/presentation/screens/section_exercises_screen.dart';
import '../cubit/workouts_cubit.dart';

// class AddExerciseBottomSheet extends StatelessWidget {
//   final String workoutId;
//   final VoidCallback onExerciseAdded;
//
//   const AddExerciseBottomSheet({
//     super.key,
//     required this.workoutId,
//     required this.onExerciseAdded,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return DraggableScrollableSheet(
//       initialChildSize: 0.7,
//       minChildSize: 0.5,
//       maxChildSize: 0.95,
//       expand: false,
//       builder: (context, scrollController) {
//         return Column(
//           children: [
//             // Handle bar
//             Container(
//               margin: EdgeInsets.only(top: 12.h),
//               width: 40.w,
//               height: 4.h,
//               decoration: BoxDecoration(
//                 color: ColorsManager.lightText,
//                 borderRadius: BorderRadius.circular(2.r),
//               ),
//             ),
//             SizedBox(height: 20.h),
//
//             // Title
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(s.add_exercise, style: TextStyles.headline3),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16.h),
//
//             // Sections Grid
//             Expanded(
//               child: BlocBuilder<SectionsCubit, SectionsState>(
//                 builder: (context, state) {
//                   if (state is SectionsLoading) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: ColorsManager.primaryGreen,
//                       ),
//                     );
//                   }
//
//                   if (state is SectionsLoaded) {
//                     return GridView.builder(
//                       controller: scrollController,
//                       padding: EdgeInsets.all(20.w),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 12.w,
//                         mainAxisSpacing: 12.h,
//                         childAspectRatio: 1.1,
//                       ),
//                       itemCount: state.sections.length,
//                       itemBuilder: (context, index) {
//                         final section = state.sections[index];
//                         return _buildSectionCard(
//                           context,
//                           section,
//                           workoutId,
//                           onExerciseAdded,
//                         );
//                       },
//                     );
//                   }
//
//                   if (state is SectionsError) {
//                     return Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.error_outline,
//                             size: 48.sp,
//                             color: Colors.red,
//                           ),
//                           SizedBox(height: 12.h),
//                           Text(
//                             state.message,
//                             style: TextStyles.bodyMedium,
//                             textAlign: TextAlign.center,
//                           ),
//                           SizedBox(height: 16.h),
//                           ElevatedButton(
//                             onPressed: () {
//                               context.read<SectionsCubit>().loadSections();
//                             },
//                             child: Text(s.retry),
//                           ),
//                         ],
//                       ),
//                     );
//                   }
//
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildSectionCard(
//     BuildContext context,
//     dynamic section,
//     String workoutId,
//     VoidCallback onExerciseAdded,
//   ) {
//     return InkWell(
//       onTap: () {
//         // Close bottom sheet
//         Navigator.pop(context);
//
//         // ✅ Navigate with MaterialPageRoute providing all needed cubits
//         Navigator.of(context)
//             .push(
//               MaterialPageRoute(
//                 builder: (routeContext) => MultiBlocProvider(
//                   providers: [
//                     // ✅ Provide ExercisesCubit
//                     BlocProvider(create: (_) => di.get<ExercisesCubit>()),
//                     // ✅ Provide existing WorkoutsCubit from parent context
//                     BlocProvider.value(value: context.read<WorkoutsCubit>()),
//                   ],
//                   child: SectionExercisesScreen(
//                     sectionId: section.id,
//                     sectionName: section.name,
//                     workoutId: workoutId,
//                   ),
//                 ),
//               ),
//             )
//             .then((_) {
//               // ✅ Reload workout when returning
//               onExerciseAdded();
//             });
//       },
//       borderRadius: BorderRadius.circular(16.r),
//       child: Container(
//         decoration: BoxDecoration(
//           color: ColorsManager.cardBackground,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: ColorsManager.cardShadow,
//           border: Border.all(
//             color: ColorsManager.primaryGreen.withValues(alpha: 0.2),
//             width: 1,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.all(16.w),
//               decoration: BoxDecoration(
//                 color: ColorsManager.primaryGreen.withOpacity(0.1),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 _getSectionIcon(section.name),
//                 size: 32.sp,
//                 color: ColorsManager.primaryGreen,
//               ),
//             ),
//             SizedBox(height: 12.h),
//             Text(
//               section.name,
//               style: TextStyles.font16PrimaryTextSemiBold,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   IconData _getSectionIcon(String name) {
//     switch (name.toLowerCase()) {
//       case 'chest':
//         return Icons.accessibility_new;
//       case 'back':
//         return Icons.accessibility;
//       case 'legs':
//         return Icons.directions_run;
//       case 'shoulders':
//         return Icons.fitness_center;
//       case 'arms':
//         return Icons.sports_martial_arts;
//       case 'core':
//         return Icons.album;
//       default:
//         return Icons.fitness_center;
//     }
//   }
// }

class AddExerciseBottomSheet extends StatelessWidget {
  final String workoutId;
  final VoidCallback onExerciseAdded;

  const AddExerciseBottomSheet({
    super.key,
    required this.workoutId,
    required this.onExerciseAdded,
  });

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: ColorsManager.lightText,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(s.add_exercise, style: TextStyles.headline3),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Sections Grid
            Expanded(
              child: BlocBuilder<SectionsCubit, SectionsState>(
                builder: (context, state) {
                  if (state is SectionsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.primaryGreen,
                      ),
                    );
                  }

                  if (state is SectionsLoaded) {
                    return GridView.builder(
                      controller: scrollController,
                      padding: EdgeInsets.all(20.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: state.sections.length,
                      itemBuilder: (context, index) {
                        final section = state.sections[index];
                        return _buildSectionCard(
                          context,
                          section,
                          workoutId,
                          onExerciseAdded,
                        );
                      },
                    );
                  }

                  if (state is SectionsError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.sp,
                            color: Colors.red,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            state.message,
                            style: TextStyles.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<SectionsCubit>().loadSections();
                            },
                            child: Text(s.retry),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    dynamic section,
    String workoutId,
    VoidCallback onExerciseAdded,
  ) {
    final s = S.of(context);

    return InkWell(
      onTap: () {
        Navigator.pop(context);

        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (routeContext) => MultiBlocProvider(
                  providers: [
                    BlocProvider(create: (_) => di.get<ExercisesCubit>()),
                    BlocProvider.value(value: context.read<WorkoutsCubit>()),
                  ],
                  child: SectionExercisesScreen(
                    sectionId: section.id,
                    sectionName: section.name,
                    workoutId: workoutId,
                  ),
                ),
              ),
            )
            .then((_) {
              onExerciseAdded();
            });
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
          border: Border.all(
            color: ColorsManager.primaryGreen.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ColorsManager.primaryGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getSectionIcon(section.name),
                size: 32.sp,
                color: ColorsManager.primaryGreen,
              ),
            ),
            SizedBox(height: 12.h),
            // ✅ Use localized section name
            Text(
              _getLocalizedSectionName(s, section.name),
              style: TextStyles.font16PrimaryTextSemiBold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Get localized section name
  String _getLocalizedSectionName(S s, String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'chest':
        return s.chest;
      case 'back':
        return s.back;
      case 'legs':
        return s.legs;
      case 'shoulders':
        return s.shoulders;
      case 'arms':
        return s.arms;
      case 'core':
        return s.core;
      default:
        return sectionName; // Fallback to API name
    }
  }

  IconData _getSectionIcon(String name) {
    switch (name.toLowerCase()) {
      case 'chest':
        return Icons.accessibility_new;
      case 'back':
        return Icons.accessibility;
      case 'legs':
        return Icons.directions_run;
      case 'shoulders':
        return Icons.fitness_center;
      case 'arms':
        return Icons.sports_martial_arts;
      case 'core':
        return Icons.album;
      default:
        return Icons.fitness_center;
    }
  }
}
