import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../workout/presentation/cubit/workouts_cubit.dart';
import '../../../workout/presentation/cubit/workouts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/exercises_cubit.dart';
import '../widgets/exercises_list_section.dart';
import '../widgets/search_and_filters_section.dart';

//
// class SectionExercisesScreen extends StatefulWidget {
//   final String sectionId;
//   final String sectionName;
//   final String? workoutId;
//
//   const SectionExercisesScreen({
//     required this.sectionId,
//     required this.sectionName,
//     this.workoutId,
//     super.key,
//   });
//
//   @override
//   State<SectionExercisesScreen> createState() => _SectionExercisesScreenState();
// }
//
// class _SectionExercisesScreenState extends State<SectionExercisesScreen>
//     with TickerProviderStateMixin {
//   String _searchQuery = '';
//   String _filterDifficulty = 'all';
//   String _sortBy = 'none';
//
//   late AnimationController _fabController;
//   late Animation<double> _fabAnimation;
//   late AnimationController _rotationController;
//
//   bool get isAddingToWorkout => widget.workoutId != null;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadExercises();
//     _setupFabAnimation();
//     _setupRotationAnimation();
//   }
//
//   void _setupRotationAnimation() {
//     _rotationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//
//     if (isAddingToWorkout) {
//       _rotationController.repeat();
//     }
//   }
//
//   void _setupFabAnimation() {
//     _fabController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//
//     _fabAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeOut));
//
//     Future.delayed(const Duration(milliseconds: 800), () {
//       if (mounted) _fabController.forward();
//     });
//   }
//
//   @override
//   void dispose() {
//     _fabController.dispose();
//     _rotationController.dispose();
//     super.dispose();
//   }
//
//   void _loadExercises() {
//     context.read<ExercisesCubit>().loadExercisesBySection(
//       sectionId: widget.sectionId,
//       searchTerm: _searchQuery.isEmpty ? null : _searchQuery,
//       difficulty: _filterDifficulty == 'all' ? null : _filterDifficulty,
//     );
//   }
//
//   // ✅ Handle exercise tap based on context
//   void _handleExerciseTap(ExerciseModel exercise) {
//     if (isAddingToWorkout) {
//       // Add to workout
//       _addExerciseToWorkout(exercise);
//     } else {
//       // Navigate to details
//       Navigator.pushNamed(context, Routes.exerciseDetails, arguments: exercise);
//     }
//   }
//
//   // ✅ Add exercise to workout
//   // void _addExerciseToWorkout(ExerciseModel exercise) async {
//   //   final s = S.of(context);
//   //
//   //   try {
//   //     await context.read<WorkoutsCubit>().addExerciseToWorkout(
//   //       sessionId: widget.workoutId!,
//   //       exerciseId: exercise.isCustomExercise ? null : exercise.id,
//   //       customExerciseId: exercise.isCustomExercise ? exercise.id : null,
//   //     );
//   //
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Row(
//   //             children: [
//   //               const Icon(Icons.check_circle, color: Colors.white),
//   //               SizedBox(width: 12.w),
//   //               Expanded(child: Text('${exercise.name} ${s.added_to_workout}')),
//   //             ],
//   //           ),
//   //           backgroundColor: ColorsManager.success,
//   //           behavior: SnackBarBehavior.floating,
//   //           shape: RoundedRectangleBorder(
//   //             borderRadius: BorderRadius.circular(12.r),
//   //           ),
//   //           duration: const Duration(seconds: 2),
//   //           action: SnackBarAction(
//   //             label: s.undo,
//   //             textColor: Colors.white,
//   //             onPressed: () {
//   //               // Could implement undo functionality
//   //             },
//   //           ),
//   //         ),
//   //       );
//   //     }
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(
//   //           content: Text(s.failed_to_add_exercise),
//   //           backgroundColor: Colors.red,
//   //         ),
//   //       );
//   //     }
//   //   }
//   // }
//   // In _addExerciseToWorkout method
//   void _addExerciseToWorkout(ExerciseModel exercise) async {
//     final s = S.of(context);
//     final cubit = context.read<WorkoutsCubit>();
//
//     // Listen to state changes
//     cubit.stream.listen((state) {
//       if (!mounted) return;
//
//       if (state is ExerciseAddedToWorkout) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Row(
//               children: [
//                 const Icon(Icons.check_circle, color: Colors.white),
//                 SizedBox(width: 12.w),
//                 Expanded(child: Text('${exercise.name} ${s.added_to_workout}')),
//               ],
//             ),
//             backgroundColor: ColorsManager.success,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//             duration: const Duration(seconds: 2),
//           ),
//         );
//       } else if (state is WorkoutsError) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(state.message),
//             backgroundColor: ColorsManager.error,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.r),
//             ),
//           ),
//         );
//       }
//     });
//
//     // Trigger the action
//     await cubit.addExerciseToWorkout(
//       sessionId: widget.workoutId!,
//       exerciseId: exercise.isCustomExercise ? null : exercise.id,
//       customExerciseId: exercise.isCustomExercise ? exercise.id : null,
//     );
//   }
//
//   Map<String, List<ExerciseModel>> _separateExercises(
//     List<ExerciseModel> exercises,
//   ) {
//     final customExercises = <ExerciseModel>[];
//     final publicExercises = <ExerciseModel>[];
//
//     for (var exercise in exercises) {
//       if (exercise.isCustomExercise) {
//         customExercises.add(exercise);
//       } else {
//         publicExercises.add(exercise);
//       }
//     }
//
//     return {
//       'custom': _sortExercisesList(customExercises),
//       'public': _sortExercisesList(publicExercises),
//     };
//   }
//
//   List<ExerciseModel> _sortExercisesList(List<ExerciseModel> exercises) {
//     final sortedList = List<ExerciseModel>.from(exercises);
//
//     switch (_sortBy) {
//       case 'name':
//         sortedList.sort((a, b) => a.name.compareTo(b.name));
//         break;
//       case 'difficulty':
//         sortedList.sort((a, b) {
//           final difficultyOrder = {
//             'Beginner': 1,
//             'Intermediate': 2,
//             'Advanced': 3,
//           };
//           return (difficultyOrder[a.difficultyLevel] ?? 0).compareTo(
//             difficultyOrder[b.difficultyLevel] ?? 0,
//           );
//         });
//         break;
//     }
//
//     return sortedList;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       body: CustomScrollView(
//         slivers: [
//           _buildAnimatedAppBar(s),
//           SliverToBoxAdapter(child: _buildSearchAndFilters(s)),
//           _buildExercisesList(s),
//         ],
//       ),
//       floatingActionButton: !isAddingToWorkout ? _buildAnimatedFAB(s) : null,
//     );
//   }
//
//   // ========== ANIMATED APP BAR ==========
//   // Widget _buildAnimatedAppBar(S s) {
//   //   return SliverAppBar(
//   //     expandedHeight: 200.h,
//   //     pinned: true,
//   //     backgroundColor: ColorsManager.primaryGreen,
//   //     leading: IconButton(
//   //       onPressed: () => Navigator.pop(context),
//   //       icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//   //     ),
//   //     flexibleSpace: FlexibleSpaceBar(
//   //       title: Text(
//   //         isAddingToWorkout
//   //             ? '${s.add_exercise} - ${widget.sectionName}'
//   //             : widget.sectionName,
//   //         style: TextStyles.font16WhiteRegular,
//   //         textAlign: TextAlign.center,
//   //       ),
//   //       background: Container(
//   //         decoration: const BoxDecoration(
//   //           gradient: ColorsManager.appBarBackgroundGradient,
//   //         ),
//   //         child: TweenAnimationBuilder<double>(
//   //           tween: Tween(begin: 0.0, end: 1.0),
//   //           duration: const Duration(milliseconds: 800),
//   //           builder: (context, value, child) {
//   //             return Transform.scale(
//   //               scale: 0.8 + (value * 0.2),
//   //               child: Opacity(
//   //                 opacity: value,
//   //                 child: Column(
//   //                   mainAxisAlignment: MainAxisAlignment.center,
//   //                   children: [
//   //                     SizedBox(height: 40.h),
//   //                     Icon(
//   //                       isAddingToWorkout
//   //                           ? Icons.add_circle_outline
//   //                           : Icons.fitness_center,
//   //                       size: 80.sp,
//   //                       color: Colors.white.withValues(alpha: 0.9),
//   //                     ),
//   //                     SizedBox(height: 8.h),
//   //                     if (isAddingToWorkout)
//   //                       Text(
//   //                         s.tap_to_add_exercise,
//   //                         style: TextStyles.font14WhiteMedium,
//   //                         textAlign: TextAlign.center,
//   //                       )
//   //                     else
//   //                       Text(
//   //                         _getSectionDescription(s, widget.sectionName),
//   //                         style: TextStyles.font14WhiteMedium,
//   //                         textAlign: TextAlign.center,
//   //                       ),
//   //                   ],
//   //                 ),
//   //               ),
//   //             );
//   //           },
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//   Widget _buildAnimatedAppBar(S s) {
//     return SliverAppBar(
//       expandedHeight: 220.h,
//       pinned: true,
//       backgroundColor: ColorsManager.primaryGreen,
//       leading: IconButton(
//         onPressed: () => Navigator.pop(context),
//         icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         title: TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(milliseconds: 600),
//           curve: Curves.easeOut,
//           builder: (context, value, child) {
//             return Opacity(
//               opacity: value,
//               child: Transform.translate(
//                 offset: Offset(0, 10 * (1 - value)),
//                 child: child,
//               ),
//             );
//           },
//           child: Text(
//             isAddingToWorkout
//                 ? '${s.add_exercise} - ${widget.sectionName}'
//                 : widget.sectionName,
//             style: TextStyles.font16WhiteRegular,
//             textAlign: TextAlign.center,
//           ),
//         ),
//         background: _buildAnimatedBackground(s),
//       ),
//     );
//   }
//
//   Widget _buildAnimatedBackground(S s) {
//     return Stack(
//       children: [
//         // Gradient background
//         Container(
//           decoration: const BoxDecoration(
//             gradient: ColorsManager.appBarBackgroundGradient,
//           ),
//         ),
//         // Animated pattern overlay
//         Positioned.fill(
//           child: CustomPaint(painter: SectionAppBarPatternPainter()),
//         ),
//         // Animated circles in background
//         _buildFloatingCircles(),
//         // Main content
//         _buildMainContent(s),
//       ],
//     );
//   }
//
//   Widget _buildFloatingCircles() {
//     return Stack(
//       children: [
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(milliseconds: 1200),
//           curve: Curves.easeOutCubic,
//           builder: (context, value, child) {
//             return Positioned(
//               top: 40.h - (20 * value),
//               right: 30.w + (20 * value),
//               child: Opacity(
//                 opacity: 0.1 * value,
//                 child: Container(
//                   width: 100.w,
//                   height: 100.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withValues(alpha: 0.2),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(milliseconds: 1500),
//           curve: Curves.easeOutCubic,
//           builder: (context, value, child) {
//             return Positioned(
//               bottom: 30.h + (30 * value),
//               left: 20.w - (10 * value),
//               child: Opacity(
//                 opacity: 0.08 * value,
//                 child: Container(
//                   width: 120.w,
//                   height: 120.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withValues(alpha: 0.15),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(milliseconds: 1800),
//           curve: Curves.easeOutCubic,
//           builder: (context, value, child) {
//             return Positioned(
//               top: 100.h + (15 * value),
//               left: 50.w - (15 * value),
//               child: Opacity(
//                 opacity: 0.06 * value,
//                 child: Container(
//                   width: 80.w,
//                   height: 80.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Colors.white.withValues(alpha: 0.1),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMainContent(S s) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 1000),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, child) {
//         return Transform.scale(
//           scale: 0.85 + (value * 0.15),
//           child: Opacity(opacity: value.clamp(0.0, 1.0), child: child),
//         );
//       },
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 50.h),
//             _buildAnimatedIcon(),
//             SizedBox(height: 16.h),
//             _buildSubtitle(s),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAnimatedIcon() {
//     return AnimatedBuilder(
//       animation: _rotationController,
//       builder: (context, child) {
//         return Transform.rotate(
//           angle: isAddingToWorkout
//               ? _rotationController.value * 2 * 3.14159265359
//               : 0.0,
//           child: Container(
//             padding: EdgeInsets.all(20.w),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withValues(alpha: 0.15),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.1),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: TweenAnimationBuilder<double>(
//               key: ValueKey(isAddingToWorkout), // Important: add key
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 800),
//               curve: Curves.easeOutBack,
//               builder: (context, value, scaleChild) {
//                 return Transform.scale(
//                   scale: 0.5 + (value * 0.5),
//                   child: Opacity(
//                     opacity: value.clamp(0.0, 1.0),
//                     child: Icon(
//                       isAddingToWorkout
//                           ? Icons.add_circle_outline
//                           : Icons.fitness_center,
//                       size: 56.sp,
//                       color: Colors.white,
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSubtitle(S s) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 900),
//       curve: Curves.easeOut,
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value.clamp(0.0, 1.0),
//           child: Transform.translate(
//             offset: Offset(0, 20 * (1 - value)),
//             child: child,
//           ),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: 0.1),
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         child: Text(
//           isAddingToWorkout
//               ? s.tap_to_add_exercise
//               : _getSectionDescription(s, widget.sectionName),
//           style: TextStyles.font14WhiteMedium,
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
//
//   // ========== SEARCH AND FILTERS ==========
//   Widget _buildSearchAndFilters(S s) {
//     return Padding(
//       padding: EdgeInsets.all(20.w),
//       child: Column(
//         children: [
//           AnimatedSearchBar(
//             hintText: s.search_exercises,
//             onChanged: (value) {
//               setState(() => _searchQuery = value);
//               _loadExercises();
//             },
//           ),
//           SizedBox(height: 16.h),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 AnimatedFilterChip(
//                   label: s.all,
//                   isSelected: _filterDifficulty == 'all',
//                   onTap: () {
//                     setState(() => _filterDifficulty = 'all');
//                     _loadExercises();
//                   },
//                   index: 0,
//                 ),
//                 SizedBox(width: 8.w),
//                 AnimatedFilterChip(
//                   label: s.beginner,
//                   isSelected: _filterDifficulty == 'Beginner',
//                   onTap: () {
//                     setState(() => _filterDifficulty = 'Beginner');
//                     _loadExercises();
//                   },
//                   index: 1,
//                 ),
//                 SizedBox(width: 8.w),
//                 AnimatedFilterChip(
//                   label: s.intermediate,
//                   isSelected: _filterDifficulty == 'Intermediate',
//                   onTap: () {
//                     setState(() => _filterDifficulty = 'Intermediate');
//                     _loadExercises();
//                   },
//                   index: 2,
//                 ),
//                 SizedBox(width: 8.w),
//                 AnimatedFilterChip(
//                   label: s.advanced,
//                   isSelected: _filterDifficulty == 'Advanced',
//                   onTap: () {
//                     setState(() => _filterDifficulty = 'Advanced');
//                     _loadExercises();
//                   },
//                   index: 3,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 16.h),
//           _buildCountAndSort(s),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCountAndSort(S s) {
//     return BlocBuilder<ExercisesCubit, ExercisesState>(
//       builder: (context, state) {
//         final count = state is ExercisesLoaded ? state.exercises.length : 0;
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             TweenAnimationBuilder<int>(
//               tween: IntTween(begin: 0, end: count),
//               duration: const Duration(milliseconds: 600),
//               builder: (context, value, child) {
//                 return Text(
//                   '$value ${s.exercises}',
//                   style: TextStyles.subtitle1,
//                 );
//               },
//             ),
//             if (!isAddingToWorkout)
//               IconButton(
//                 icon: const Icon(Icons.sort, color: ColorsManager.primaryGreen),
//                 onPressed: () => _showSortOptions(context, s),
//               ),
//           ],
//         );
//       },
//     );
//   }
//
//   // ========== EXERCISES LIST ==========
//   Widget _buildExercisesList(S s) {
//     return BlocConsumer<ExercisesCubit, ExercisesState>(
//       listener: (context, state) {
//         if (state is ExercisesError) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.message), backgroundColor: Colors.red),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is ExercisesLoading) {
//           return SliverToBoxAdapter(
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.all(40.w),
//                 child: const CircularProgressIndicator(
//                   color: ColorsManager.primaryGreen,
//                 ),
//               ),
//             ),
//           );
//         }
//
//         if (state is ExercisesLoaded) {
//           if (state.exercises.isEmpty) {
//             return SliverToBoxAdapter(
//               child: AnimatedEmptyState(
//                 message: s.no_exercises_found,
//                 subMessage: s.try_adjusting_search,
//               ),
//             );
//           }
//
//           final separated = _separateExercises(state.exercises);
//           return _buildExerciseSections(s, separated);
//         }
//
//         return SliverToBoxAdapter(
//           child: AnimatedEmptyState(
//             message: s.no_exercises_found,
//             subMessage: s.try_adjusting_search,
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildExerciseSections(
//     S s,
//     Map<String, List<ExerciseModel>> separated,
//   ) {
//     final customExercises = separated['custom']!;
//     final publicExercises = separated['public']!;
//
//     return SliverList(
//       delegate: SliverChildListDelegate([
//         if (customExercises.isNotEmpty) ...[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: AnimatedSectionHeader(
//               icon: Icons.stars,
//               title: s.my_custom_exercises,
//               count: customExercises.length,
//               color: ColorsManager.primaryGreen,
//               index: 0,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           ...customExercises.asMap().entries.map((entry) {
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
//               child: AnimatedExerciseCardWrapper(
//                 index: entry.key,
//                 child: ExerciseCard(
//                   exercise: entry.value,
//                   onTap: () => _handleExerciseTap(entry.value), // ✅ Updated
//                   // ✅ Show add icon if adding to workout
//                   trailing: isAddingToWorkout
//                       ? Icon(
//                           Icons.add_circle,
//                           color: ColorsManager.primaryGreen,
//                           size: 28.sp,
//                         )
//                       : null,
//                 ),
//               ),
//             );
//           }).toList(),
//           SizedBox(height: 24.h),
//         ],
//         if (publicExercises.isNotEmpty) ...[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: AnimatedSectionHeader(
//               icon: Icons.public,
//               title: s.public_exercises,
//               count: publicExercises.length,
//               color: ColorsManager.info,
//               index: 1,
//             ),
//           ),
//           SizedBox(height: 12.h),
//           ...publicExercises.asMap().entries.map((entry) {
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
//               child: AnimatedExerciseCardWrapper(
//                 index: entry.key,
//                 child: ExerciseCard(
//                   exercise: entry.value,
//                   onTap: () => _handleExerciseTap(entry.value),
//                   // ✅ Show add icon if adding to workout
//                   trailing: isAddingToWorkout
//                       ? Icon(
//                           Icons.add_circle,
//                           color: ColorsManager.primaryGreen,
//                           size: 28.sp,
//                         )
//                       : null,
//                 ),
//               ),
//             );
//           }).toList(),
//         ],
//         SizedBox(height: 80.h),
//       ]),
//     );
//   }
//
//   // ========== ANIMATED FAB ==========
//   Widget _buildAnimatedFAB(S s) {
//     return ScaleTransition(
//       scale: _fabAnimation,
//       child: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.pushNamed(
//             context,
//             Routes.createCustomExercise,
//             arguments: widget.sectionId,
//           ).then((_) => _loadExercises());
//         },
//         backgroundColor: ColorsManager.primaryGreen,
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: Text(s.create_custom, style: TextStyles.buttonMedium),
//       ),
//     );
//   }
//
//   // ========== HELPER METHODS ==========
//   String _getSectionDescription(S s, String sectionName) {
//     switch (sectionName.toLowerCase()) {
//       case 'chest':
//         return s.chest_description;
//       case 'back':
//         return s.back_description;
//       case 'legs':
//         return s.legs_description;
//       case 'shoulders':
//         return s.shoulders_description;
//       case 'arms':
//         return s.arms_description;
//       case 'core':
//         return s.core_description;
//       default:
//         return '';
//     }
//   }
//
//   void _showSortOptions(BuildContext context, S s) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: ColorsManager.cardBackground,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (ctx) => Padding(
//         padding: EdgeInsets.all(20.w),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(s.sort_by, style: TextStyles.headline3),
//             SizedBox(height: 20.h),
//             _buildSortOption(ctx, Icons.sort_by_alpha, s.name_a_z, 'name', s),
//             _buildSortOption(
//               ctx,
//               Icons.trending_up,
//               s.difficulty,
//               'difficulty',
//               s,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSortOption(
//     BuildContext ctx,
//     IconData icon,
//     String title,
//     String value,
//     S s,
//   ) {
//     final isSelected = _sortBy == value;
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: isSelected
//             ? ColorsManager.primaryGreen
//             : ColorsManager.lightText,
//       ),
//       title: Text(
//         title,
//         style: TextStyle(
//           fontFamily: GoogleFonts.openSans().fontFamily,
//           color: isSelected
//               ? ColorsManager.primaryGreen
//               : ColorsManager.primaryText,
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//         ),
//       ),
//       trailing: isSelected
//           ? const Icon(Icons.check, color: ColorsManager.primaryGreen)
//           : null,
//       onTap: () {
//         setState(() => _sortBy = value);
//         Navigator.pop(ctx);
//       },
//     );
//   }
// }
//
import '../widgets/section_app_bar.dart';

class SectionExercisesScreen extends StatefulWidget {
  final String sectionId;
  final String sectionName;
  final String? workoutId;

  const SectionExercisesScreen({
    required this.sectionId,
    required this.sectionName,
    this.workoutId,
    super.key,
  });

  @override
  State<SectionExercisesScreen> createState() => _SectionExercisesScreenState();
}

class _SectionExercisesScreenState extends State<SectionExercisesScreen>
    with TickerProviderStateMixin {
  String _searchQuery = '';
  String _filterDifficulty = 'all';
  String _sortBy = 'none';

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  // ✅ Track last notification to prevent duplicates
  String? _lastNotificationId;

  bool get isAddingToWorkout => widget.workoutId != null;

  @override
  void initState() {
    super.initState();
    _loadExercises();
    _setupFabAnimation();
  }

  void _setupFabAnimation() {
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _fabController.forward();
    });
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  void _loadExercises() {
    context.read<ExercisesCubit>().loadExercisesBySection(
      sectionId: widget.sectionId,
      searchTerm: _searchQuery.isEmpty ? null : _searchQuery,
      difficulty: _filterDifficulty == 'all' ? null : _filterDifficulty,
    );
  }

  void _onSearchChanged(String query) {
    setState(() => _searchQuery = query);
    _loadExercises();
  }

  void _onFilterChanged(String difficulty) {
    setState(() => _filterDifficulty = difficulty);
    _loadExercises();
  }

  void _onSortChanged(String sortBy) {
    setState(() => _sortBy = sortBy);
  }

  // void _showSnackBar({
  //   required String message,
  //   required Color backgroundColor,
  //   IconData icon = Icons.info,
  // }) {
  //   // ✅ Create unique ID for this notification
  //   final notificationId = '$message-${DateTime.now().millisecondsSinceEpoch}';
  //
  //   // ✅ Prevent showing same message within 1 second
  //   if (_lastNotificationId == message) return;
  //   _lastNotificationId = message;
  //
  //   // ✅ Clear any existing snackbars first
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //
  //   // ✅ Show new snackbar
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Row(
  //         children: [
  //           Icon(icon, color: Colors.white),
  //           SizedBox(width: 12.w),
  //           Expanded(
  //             child: Text(message, style: const TextStyle(color: Colors.white)),
  //           ),
  //         ],
  //       ),
  //       backgroundColor: backgroundColor,
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(12.r),
  //       ),
  //       duration: const Duration(seconds: 2),
  //       // ✅ Reset tracking after snackbar is dismissed
  //       onVisible: () {
  //         Future.delayed(const Duration(seconds: 2), () {
  //           _lastNotificationId = null;
  //         });
  //       },
  //     ),
  //   );
  // }
  void _showSnackBar({
    required String message,
    required Color backgroundColor,
    IconData icon = Icons.info,
  }) {
    // ✅ Prevent showing same message within 1 second
    if (_lastNotificationId == message) return;
    _lastNotificationId = message;

    // ✅ Clear any existing snackbars first
    ScaffoldMessenger.of(context).clearSnackBars();

    // ✅ Show new snackbar with dismiss action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(message, style: const TextStyle(color: Colors.white)),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        duration: const Duration(seconds: 4), // ✅ Longer duration
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _lastNotificationId = null; // ✅ Reset tracking
          },
        ),
        // ✅ Reset tracking after snackbar is dismissed
        onVisible: () {
          Future.delayed(const Duration(seconds: 4), () {
            if (mounted) {
              _lastNotificationId = null;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocListener<WorkoutsCubit, WorkoutsState>(
      // ✅ More strict listenWhen
      listenWhen: (previous, current) {
        // Only trigger for state transitions, not same state
        if (previous.runtimeType == current.runtimeType) return false;

        return current is ExerciseAddedToWorkout || current is WorkoutsError;
      },
      listener: (context, state) {
        if (state is ExerciseAddedToWorkout) {
          _showSnackBar(
            message: s.exercise_added_successfully,
            backgroundColor: ColorsManager.success,
            icon: Icons.check_circle,
          );
        } else if (state is WorkoutsError) {
          _showSnackBar(
            message: state.message,
            backgroundColor: ColorsManager.error,
            icon: Icons.error,
          );
        }
      },
      child: Scaffold(
        backgroundColor: ColorsManager.scaffoldBackground,
        body: CustomScrollView(
          slivers: [
            SectionAppBar(
              sectionName: widget.sectionName,
              isAddingToWorkout: isAddingToWorkout,
              vsync: this,
            ),
            SliverToBoxAdapter(
              child: SearchAndFiltersSection(
                onSearchChanged: _onSearchChanged,
                onFilterChanged: _onFilterChanged,
                currentFilter: _filterDifficulty,
                currentSort: _sortBy,
                onSortChanged: _onSortChanged,
                isAddingToWorkout: isAddingToWorkout,
              ),
            ),
            ExercisesListSection(
              sortBy: _sortBy,
              isAddingToWorkout: isAddingToWorkout,
              workoutId: widget.workoutId,
            ),
          ],
        ),
        floatingActionButton: !isAddingToWorkout ? _buildFAB(s) : null,
      ),
    );
  }

  Widget _buildFAB(S s) {
    return ScaleTransition(
      scale: _fabAnimation,
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.createCustomExercise,
            arguments: widget.sectionId,
          ).then((_) => _loadExercises());
        },
        backgroundColor: ColorsManager.primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(s.create_custom, style: TextStyles.buttonMedium),
      ),
    );
  }
}
