import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../workout/presentation/cubit/workouts_cubit.dart';
import '../widgets/exercise_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/exercises_cubit.dart';
import '../cubit/exercises_state.dart';
import '../../data/models/exercise_model.dart';
import '../widgets/section_exercise_widgets.dart';

// class SectionExercisesScreen extends StatefulWidget {
//   final String sectionId;
//   final String sectionName;
//
//   const SectionExercisesScreen({
//     required this.sectionId,
//     required this.sectionName,
//     super.key,
//   });
//
//   @override
//   State<SectionExercisesScreen> createState() => _SectionExercisesScreenState();
// }
//
// class _SectionExercisesScreenState extends State<SectionExercisesScreen>
//     with SingleTickerProviderStateMixin {
//   String _searchQuery = '';
//   String _filterDifficulty = 'all';
//   String _sortBy = 'none';
//
//   late AnimationController _fabController;
//   late Animation<double> _fabAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadExercises();
//     _setupFabAnimation();
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
//       floatingActionButton: _buildAnimatedFAB(s),
//     );
//   }
//
//   // ========== ANIMATED APP BAR ==========
//   Widget _buildAnimatedAppBar(S s) {
//     return SliverAppBar(
//       expandedHeight: 200.h,
//       pinned: true,
//       backgroundColor: ColorsManager.primaryGreen,
//       leading: IconButton(
//         onPressed: () => Navigator.pop(context),
//         icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//       ),
//       flexibleSpace: FlexibleSpaceBar(
//         title: Text(widget.sectionName, style: TextStyles.font20WhiteSemiBold),
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: ColorsManager.appBarBackgroundGradient,
//           ),
//           child: TweenAnimationBuilder<double>(
//             tween: Tween(begin: 0.0, end: 1.0),
//             duration: const Duration(milliseconds: 800),
//             builder: (context, value, child) {
//               return Transform.scale(
//                 scale: 0.8 + (value * 0.2),
//                 child: Opacity(
//                   opacity: value,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 40.h),
//                       Icon(
//                         Icons.fitness_center,
//                         size: 80.sp,
//                         color: Colors.white.withOpacity(0.9),
//                       ),
//                       SizedBox(height: 8.h),
//                       Text(
//                         _getSectionDescription(s, widget.sectionName),
//                         style: TextStyles.font14WhiteMedium,
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
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
//             IconButton(
//               icon: const Icon(Icons.sort, color: ColorsManager.primaryGreen),
//               onPressed: () => _showSortOptions(context, s),
//             ),
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
//                   onTap: () => Navigator.pushNamed(
//                     context,
//                     Routes.exerciseDetails,
//                     arguments: entry.value,
//                   ),
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
//                   onTap: () => Navigator.pushNamed(
//                     context,
//                     Routes.exerciseDetails,
//                     arguments: entry.value,
//                   ),
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
class SectionExercisesScreen extends StatefulWidget {
  final String sectionId;
  final String sectionName;
  final String? workoutId; // ✅ Add workout ID

  const SectionExercisesScreen({
    required this.sectionId,
    required this.sectionName,
    this.workoutId, // ✅ Optional workout ID
    super.key,
  });

  @override
  State<SectionExercisesScreen> createState() => _SectionExercisesScreenState();
}

class _SectionExercisesScreenState extends State<SectionExercisesScreen>
    with SingleTickerProviderStateMixin {
  String _searchQuery = '';
  String _filterDifficulty = 'all';
  String _sortBy = 'none';

  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

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

  // ✅ Handle exercise tap based on context
  void _handleExerciseTap(ExerciseModel exercise) {
    if (isAddingToWorkout) {
      // Add to workout
      _addExerciseToWorkout(exercise);
    } else {
      // Navigate to details
      Navigator.pushNamed(context, Routes.exerciseDetails, arguments: exercise);
    }
  }

  // ✅ Add exercise to workout
  void _addExerciseToWorkout(ExerciseModel exercise) async {
    final s = S.of(context);

    try {
      await context.read<WorkoutsCubit>().addExerciseToWorkout(
        sessionId: widget.workoutId!,
        exerciseId: exercise.isCustomExercise ? null : exercise.id,
        customExerciseId: exercise.isCustomExercise ? exercise.id : null,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12.w),
                Expanded(child: Text('${exercise.name} ${s.added_to_workout}')),
              ],
            ),
            backgroundColor: ColorsManager.success,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: s.undo,
              textColor: Colors.white,
              onPressed: () {
                // Could implement undo functionality
              },
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(s.failed_to_add_exercise),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Map<String, List<ExerciseModel>> _separateExercises(
    List<ExerciseModel> exercises,
  ) {
    final customExercises = <ExerciseModel>[];
    final publicExercises = <ExerciseModel>[];

    for (var exercise in exercises) {
      if (exercise.isCustomExercise) {
        customExercises.add(exercise);
      } else {
        publicExercises.add(exercise);
      }
    }

    return {
      'custom': _sortExercisesList(customExercises),
      'public': _sortExercisesList(publicExercises),
    };
  }

  List<ExerciseModel> _sortExercisesList(List<ExerciseModel> exercises) {
    final sortedList = List<ExerciseModel>.from(exercises);

    switch (_sortBy) {
      case 'name':
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'difficulty':
        sortedList.sort((a, b) {
          final difficultyOrder = {
            'Beginner': 1,
            'Intermediate': 2,
            'Advanced': 3,
          };
          return (difficultyOrder[a.difficultyLevel] ?? 0).compareTo(
            difficultyOrder[b.difficultyLevel] ?? 0,
          );
        });
        break;
    }

    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          _buildAnimatedAppBar(s),
          SliverToBoxAdapter(child: _buildSearchAndFilters(s)),
          _buildExercisesList(s),
        ],
      ),
      floatingActionButton: !isAddingToWorkout ? _buildAnimatedFAB(s) : null,
    );
  }

  // ========== ANIMATED APP BAR ==========
  Widget _buildAnimatedAppBar(S s) {
    return SliverAppBar(
      expandedHeight: 200.h,
      pinned: true,
      backgroundColor: ColorsManager.primaryGreen,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          isAddingToWorkout
              ? '${s.add_exercise} - ${widget.sectionName}'
              : widget.sectionName,
          style: TextStyles.font16WhiteRegular,
          textAlign: TextAlign.center,
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: ColorsManager.appBarBackgroundGradient,
          ),
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, child) {
              return Transform.scale(
                scale: 0.8 + (value * 0.2),
                child: Opacity(
                  opacity: value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      Icon(
                        isAddingToWorkout
                            ? Icons.add_circle_outline
                            : Icons.fitness_center,
                        size: 80.sp,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      SizedBox(height: 8.h),
                      if (isAddingToWorkout)
                        Text(
                          s.tap_to_add_exercise,
                          style: TextStyles.font14WhiteMedium,
                          textAlign: TextAlign.center,
                        )
                      else
                        Text(
                          _getSectionDescription(s, widget.sectionName),
                          style: TextStyles.font14WhiteMedium,
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ========== SEARCH AND FILTERS ==========
  Widget _buildSearchAndFilters(S s) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          AnimatedSearchBar(
            hintText: s.search_exercises,
            onChanged: (value) {
              setState(() => _searchQuery = value);
              _loadExercises();
            },
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                AnimatedFilterChip(
                  label: s.all,
                  isSelected: _filterDifficulty == 'all',
                  onTap: () {
                    setState(() => _filterDifficulty = 'all');
                    _loadExercises();
                  },
                  index: 0,
                ),
                SizedBox(width: 8.w),
                AnimatedFilterChip(
                  label: s.beginner,
                  isSelected: _filterDifficulty == 'Beginner',
                  onTap: () {
                    setState(() => _filterDifficulty = 'Beginner');
                    _loadExercises();
                  },
                  index: 1,
                ),
                SizedBox(width: 8.w),
                AnimatedFilterChip(
                  label: s.intermediate,
                  isSelected: _filterDifficulty == 'Intermediate',
                  onTap: () {
                    setState(() => _filterDifficulty = 'Intermediate');
                    _loadExercises();
                  },
                  index: 2,
                ),
                SizedBox(width: 8.w),
                AnimatedFilterChip(
                  label: s.advanced,
                  isSelected: _filterDifficulty == 'Advanced',
                  onTap: () {
                    setState(() => _filterDifficulty = 'Advanced');
                    _loadExercises();
                  },
                  index: 3,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          _buildCountAndSort(s),
        ],
      ),
    );
  }

  Widget _buildCountAndSort(S s) {
    return BlocBuilder<ExercisesCubit, ExercisesState>(
      builder: (context, state) {
        final count = state is ExercisesLoaded ? state.exercises.length : 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TweenAnimationBuilder<int>(
              tween: IntTween(begin: 0, end: count),
              duration: const Duration(milliseconds: 600),
              builder: (context, value, child) {
                return Text(
                  '$value ${s.exercises}',
                  style: TextStyles.subtitle1,
                );
              },
            ),
            if (!isAddingToWorkout)
              IconButton(
                icon: const Icon(Icons.sort, color: ColorsManager.primaryGreen),
                onPressed: () => _showSortOptions(context, s),
              ),
          ],
        );
      },
    );
  }

  // ========== EXERCISES LIST ==========
  Widget _buildExercisesList(S s) {
    return BlocConsumer<ExercisesCubit, ExercisesState>(
      listener: (context, state) {
        if (state is ExercisesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is ExercisesLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(40.w),
                child: const CircularProgressIndicator(
                  color: ColorsManager.primaryGreen,
                ),
              ),
            ),
          );
        }

        if (state is ExercisesLoaded) {
          if (state.exercises.isEmpty) {
            return SliverToBoxAdapter(
              child: AnimatedEmptyState(
                message: s.no_exercises_found,
                subMessage: s.try_adjusting_search,
              ),
            );
          }

          final separated = _separateExercises(state.exercises);
          return _buildExerciseSections(s, separated);
        }

        return SliverToBoxAdapter(
          child: AnimatedEmptyState(
            message: s.no_exercises_found,
            subMessage: s.try_adjusting_search,
          ),
        );
      },
    );
  }

  Widget _buildExerciseSections(
    S s,
    Map<String, List<ExerciseModel>> separated,
  ) {
    final customExercises = separated['custom']!;
    final publicExercises = separated['public']!;

    return SliverList(
      delegate: SliverChildListDelegate([
        if (customExercises.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AnimatedSectionHeader(
              icon: Icons.stars,
              title: s.my_custom_exercises,
              count: customExercises.length,
              color: ColorsManager.primaryGreen,
              index: 0,
            ),
          ),
          SizedBox(height: 12.h),
          ...customExercises.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              child: AnimatedExerciseCardWrapper(
                index: entry.key,
                child: ExerciseCard(
                  exercise: entry.value,
                  onTap: () => _handleExerciseTap(entry.value), // ✅ Updated
                  // ✅ Show add icon if adding to workout
                  trailing: isAddingToWorkout
                      ? Icon(
                          Icons.add_circle,
                          color: ColorsManager.primaryGreen,
                          size: 28.sp,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
          SizedBox(height: 24.h),
        ],
        if (publicExercises.isNotEmpty) ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: AnimatedSectionHeader(
              icon: Icons.public,
              title: s.public_exercises,
              count: publicExercises.length,
              color: ColorsManager.info,
              index: 1,
            ),
          ),
          SizedBox(height: 12.h),
          ...publicExercises.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
              child: AnimatedExerciseCardWrapper(
                index: entry.key,
                child: ExerciseCard(
                  exercise: entry.value,
                  onTap: () => _handleExerciseTap(entry.value), // ✅ Updated
                  // ✅ Show add icon if adding to workout
                  trailing: isAddingToWorkout
                      ? Icon(
                          Icons.add_circle,
                          color: ColorsManager.primaryGreen,
                          size: 28.sp,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        ],
        SizedBox(height: 80.h),
      ]),
    );
  }

  // ========== ANIMATED FAB ==========
  Widget _buildAnimatedFAB(S s) {
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

  // ========== HELPER METHODS ==========
  String _getSectionDescription(S s, String sectionName) {
    switch (sectionName.toLowerCase()) {
      case 'chest':
        return s.chest_description;
      case 'back':
        return s.back_description;
      case 'legs':
        return s.legs_description;
      case 'shoulders':
        return s.shoulders_description;
      case 'arms':
        return s.arms_description;
      case 'core':
        return s.core_description;
      default:
        return '';
    }
  }

  void _showSortOptions(BuildContext context, S s) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(s.sort_by, style: TextStyles.headline3),
            SizedBox(height: 20.h),
            _buildSortOption(ctx, Icons.sort_by_alpha, s.name_a_z, 'name', s),
            _buildSortOption(
              ctx,
              Icons.trending_up,
              s.difficulty,
              'difficulty',
              s,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(
    BuildContext ctx,
    IconData icon,
    String title,
    String value,
    S s,
  ) {
    final isSelected = _sortBy == value;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? ColorsManager.primaryGreen
            : ColorsManager.lightText,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: GoogleFonts.openSans().fontFamily,
          color: isSelected
              ? ColorsManager.primaryGreen
              : ColorsManager.primaryText,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: ColorsManager.primaryGreen)
          : null,
      onTap: () {
        setState(() => _sortBy = value);
        Navigator.pop(ctx);
      },
    );
  }
}
