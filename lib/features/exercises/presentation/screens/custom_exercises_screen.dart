import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/presentation/widgets/custom_exercise_widgets/custom_exercises_filter_chips.dart';
import '../../../home/presentation/widgets/custom_exercise_widgets/custom_exercises_header.dart';
import '../../../home/presentation/widgets/custom_exercise_widgets/custom_exercises_list.dart';
import '../../../home/presentation/widgets/custom_exercise_widgets/custom_exercises_search_bar.dart';
import '../../../home/presentation/widgets/custom_exercise_widgets/deleting_overlay.dart';
import '../../data/models/exercise_model.dart';
import '../widgets/custom_exercise_widgets/empty_exercises_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/custom_exercises_cubit.dart';
import '../cubit/custom_exercises_state.dart';

class CustomExercisesScreen extends StatefulWidget {
  const CustomExercisesScreen({super.key});

  @override
  State<CustomExercisesScreen> createState() => _CustomExercisesScreenState();
}

class _CustomExercisesScreenState extends State<CustomExercisesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
    _loadCustomExercises();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadCustomExercises() {
    context.read<CustomExercisesCubit>().loadCustomExercises(
      difficulty: _selectedDifficulty,
    );
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  void _handleFilterChange(String? difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
    _loadCustomExercises();
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _selectedDifficulty = null;
      _searchController.clear();
    });
    _loadCustomExercises();
  }

  void _handleDelete(String exerciseId) {
    context.read<CustomExercisesCubit>().deleteCustomExercise(exerciseId);
  }

  void _navigateToExerciseDetails(ExerciseModel exercise) {
    Navigator.pushNamed(context, Routes.exerciseDetails, arguments: exercise);
  }

  Future<void> _navigateToSelectSection() async {
    final result = await Navigator.pushNamed(context, Routes.selectSection);
    if (result == true && mounted) {
      _loadCustomExercises();
    }
  }

  List<ExerciseModel> _filterExercises(List<ExerciseModel> exercises) {
    if (_searchQuery.isEmpty) return exercises;

    return exercises.where((exercise) {
      final nameMatch = exercise.name.toLowerCase().contains(_searchQuery);
      final sectionMatch = exercise.sectionName.toLowerCase().contains(
        _searchQuery,
      );
      return nameMatch || sectionMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark =
        Theme.of(context).brightness == Brightness.dark; // ✅ Theme detection

    return Scaffold(
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor, // ✅ Theme-aware
      body: SafeArea(
        child: BlocConsumer<CustomExercisesCubit, CustomExercisesState>(
          listener: _handleStateChanges,
          builder: (context, state) => _buildBody(context, state, s),
        ),
      ),
      floatingActionButton: _buildFAB(s, isDark), // ✅ Pass theme
    );
  }

  void _handleStateChanges(BuildContext context, CustomExercisesState state) {
    if (state is CustomExercisesError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: ColorsManager.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Widget _buildBody(BuildContext context, CustomExercisesState state, S s) {
    List<ExerciseModel>? exercises;
    bool isDeleting = false;
    bool isLoading = false;

    if (state is CustomExercisesLoading) {
      isLoading = true;
    } else if (state is CustomExercisesLoaded) {
      exercises = state.exercises;
    } else if (state is CustomExercisesDeleting) {
      exercises = state.exercises;
      isDeleting = true;
    } else if (state is CustomExercisesError) {
      exercises = state.exercises;
    }

    final filteredExercises = exercises != null
        ? _filterExercises(exercises)
        : null;

    return Stack(
      children: [
        Column(
          children: [
            CustomExercisesHeader(onBackPressed: () => Navigator.pop(context)),
            CustomExercisesSearchBar(
              controller: _searchController,
              onSearch: _handleSearch,
            ),
            CustomExercisesFilterChips(
              selectedDifficulty: _selectedDifficulty,
              onFilterChanged: _handleFilterChange,
            ),
            Expanded(child: _buildContent(filteredExercises, isLoading, s)),
          ],
        ),
        if (isDeleting) const DeletingOverlay(),
      ],
    );
  }

  Widget _buildContent(List<ExerciseModel>? exercises, bool isLoading, S s) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: ColorsManager.getPrimaryGreen(context), // ✅ Theme-aware
        ),
      );
    }

    if (exercises == null || exercises.isEmpty) {
      final hasFilters = _searchQuery.isNotEmpty || _selectedDifficulty != null;
      return EmptyExercisesState(
        onCreateTap: _navigateToSelectSection,
        hasFilters: hasFilters,
        onClearFilters: _clearFilters,
      );
    }

    return CustomExercisesList(
      exercises: exercises,
      onExerciseTap: _navigateToExerciseDetails,
      onExerciseDelete: _handleDelete,
      onRefresh: _loadCustomExercises,
      animationController: _animationController,
    );
  }

  Widget _buildFAB(S s, bool isDark) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
      child: FloatingActionButton.extended(
        onPressed: _navigateToSelectSection,
        backgroundColor: ColorsManager.getPrimaryGreen(
          context,
        ), // ✅ Theme-aware
        foregroundColor: isDark
            ? ColorsManager.darkScaffold
            : Colors.white, // ✅ Theme-aware text
        elevation: 4,
        icon: Icon(
          Icons.add,
          color: isDark
              ? ColorsManager.darkScaffold
              : Colors.white, // ✅ Theme-aware icon
        ),
        label: Text(
          s.create_custom_exercise,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark
                ? ColorsManager.darkScaffold
                : Colors.white, // ✅ Theme-aware
          ),
        ),
      ),
    );
  }
}
