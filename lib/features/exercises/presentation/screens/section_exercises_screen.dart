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

import '../widgets/section_app_bar.dart';

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
//   late Animation<double> _fabScaleAnimation; // ✅ Renamed for clarity
//   late Animation<double> _fabRotationAnimation; // ✅ Added rotation
//
//   String? _lastNotificationId;
//
//   bool get isAddingToWorkout => widget.workoutId != null;
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
//       duration: const Duration(milliseconds: 600), // ✅ Increased duration
//       vsync: this,
//     );
//
//     // ✅ Elastic scale animation
//     _fabScaleAnimation = CurvedAnimation(
//       parent: _fabController,
//       curve: Curves.elasticOut, // ✅ Changed to elasticOut
//     );
//
//     // ✅ Rotation animation
//     _fabRotationAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));
//
//     // ✅ Start animation after delay
//     Future.delayed(const Duration(milliseconds: 1000), () {
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
//   void _onSearchChanged(String query) {
//     setState(() => _searchQuery = query);
//     _loadExercises();
//   }
//
//   void _onFilterChanged(String difficulty) {
//     setState(() => _filterDifficulty = difficulty);
//     _loadExercises();
//   }
//
//   void _onSortChanged(String sortBy) {
//     setState(() => _sortBy = sortBy);
//   }
//
//   void _showSnackBar({
//     required String message,
//     required Color backgroundColor,
//     IconData icon = Icons.info,
//   }) {
//     if (_lastNotificationId == message) return;
//     _lastNotificationId = message;
//
//     ScaffoldMessenger.of(context).clearSnackBars();
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(icon, color: Colors.white),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Text(message, style: const TextStyle(color: Colors.white)),
//             ),
//           ],
//         ),
//         backgroundColor: backgroundColor,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         duration: const Duration(seconds: 4),
//         action: SnackBarAction(
//           label: 'Dismiss',
//           textColor: Colors.white,
//           onPressed: () {
//             ScaffoldMessenger.of(context).hideCurrentSnackBar();
//             _lastNotificationId = null;
//           },
//         ),
//         onVisible: () {
//           Future.delayed(const Duration(seconds: 4), () {
//             if (mounted) {
//               _lastNotificationId = null;
//             }
//           });
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return BlocListener<WorkoutsCubit, WorkoutsState>(
//       listenWhen: (previous, current) {
//         if (previous.runtimeType == current.runtimeType) return false;
//         return current is ExerciseAddedToWorkout || current is WorkoutsError;
//       },
//       listener: (context, state) {
//         if (state is ExerciseAddedToWorkout) {
//           _showSnackBar(
//             message: s.exercise_added_successfully,
//             backgroundColor: ColorsManager.success,
//             icon: Icons.check_circle,
//           );
//         } else if (state is WorkoutsError) {
//           _showSnackBar(
//             message: state.message,
//             backgroundColor: ColorsManager.error,
//             icon: Icons.error,
//           );
//         }
//       },
//       child: Scaffold(
//         backgroundColor: ColorsManager.scaffoldBackground,
//         body: CustomScrollView(
//           slivers: [
//             SectionAppBar(
//               sectionName: widget.sectionName,
//               isAddingToWorkout: isAddingToWorkout,
//               vsync: this,
//             ),
//             SliverToBoxAdapter(
//               child: SearchAndFiltersSection(
//                 onSearchChanged: _onSearchChanged,
//                 onFilterChanged: _onFilterChanged,
//                 currentFilter: _filterDifficulty,
//                 currentSort: _sortBy,
//                 onSortChanged: _onSortChanged,
//                 isAddingToWorkout: isAddingToWorkout,
//               ),
//             ),
//             ExercisesListSection(
//               sortBy: _sortBy,
//               isAddingToWorkout: isAddingToWorkout,
//               workoutId: widget.workoutId,
//             ),
//           ],
//         ),
//         floatingActionButton: !isAddingToWorkout ? _buildFAB(s) : null,
//       ),
//     );
//   }
//
//   // ✅ Updated FAB with elastic bounce and rotation
//   Widget _buildFAB(S s) {
//     return ScaleTransition(
//       scale: _fabScaleAnimation,
//       child: RotationTransition(
//         turns: _fabRotationAnimation,
//         child: FloatingActionButton.extended(
//           onPressed: () {
//             Navigator.pushNamed(
//               context,
//               Routes.createCustomExercise,
//               arguments: widget.sectionId,
//             ).then((_) => _loadExercises());
//           },
//           backgroundColor: ColorsManager.primaryGreen,
//           icon: const Icon(Icons.add, color: Colors.white),
//           label: Text(s.create_custom, style: TextStyles.buttonMedium),
//           heroTag: 'create_custom_fab_${widget.sectionId}', // ✅ Added hero tag
//         ),
//       ),
//     );
//   }
// }
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
  late Animation<double> _fabScaleAnimation;
  late Animation<double> _fabRotationAnimation;

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
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fabScaleAnimation = CurvedAnimation(
      parent: _fabController,
      curve: Curves.elasticOut,
    );

    _fabRotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 1000), () {
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

  void _showSnackBar({
    required String message,
    required Color backgroundColor,
    IconData icon = Icons.info,
  }) {
    if (_lastNotificationId == message) return;
    _lastNotificationId = message;

    ScaffoldMessenger.of(context).clearSnackBars();

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
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            _lastNotificationId = null;
          },
        ),
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
      listenWhen: (previous, current) {
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ScaleTransition(
      scale: _fabScaleAnimation,
      child: RotationTransition(
        turns: _fabRotationAnimation,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.createCustomExercise,
              arguments: widget.sectionId,
            ).then((_) => _loadExercises());
          },
          backgroundColor: ColorsManager.getPrimaryGreen(context),
          foregroundColor: isDark ? ColorsManager.darkScaffold : Colors.white,
          icon: Icon(
            Icons.add,
            color: isDark ? ColorsManager.darkScaffold : Colors.white,
          ),
          label: Text(
            s.create_custom,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? ColorsManager.darkScaffold : Colors.white,
            ),
          ),
          heroTag: 'create_custom_fab_${widget.sectionId}',
        ),
      ),
    );
  }
}
