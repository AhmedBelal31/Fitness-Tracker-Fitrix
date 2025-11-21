import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/routing/routes.dart';
import '../../data/workout_session_model.dart';
import '../cubit/workouts_cubit.dart';
import '../cubit/workouts_state.dart';
import '../widgets/create_workout_dialog.dart';
import '../widgets/workout_stats_row.dart';

// class UserWorkoutsScreen extends StatefulWidget {
//   const UserWorkoutsScreen({super.key});
//
//   @override
//   State<UserWorkoutsScreen> createState() => _UserWorkoutsScreenState();
// }
//
// class _UserWorkoutsScreenState extends State<UserWorkoutsScreen>
//     with SingleTickerProviderStateMixin {
//   String _selectedFilter = 'all';
//   late AnimationController _fabController;
//   late Animation<double> _fabAnimation;
//
//   String? _pendingNavigationSessionId;
//
//   // ✅ Search functionality
//   DateTime? _searchDate;
//   bool _isSearching = false;
//   final TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _loadWorkouts();
//   }
//
//   void _setupAnimations() {
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
//     Future.delayed(const Duration(milliseconds: 600), () {
//       if (mounted) _fabController.forward();
//     });
//   }
//
//   void _loadWorkouts() {
//     context.read<WorkoutsCubit>().loadWorkoutHistory();
//   }
//
//   @override
//   void dispose() {
//     _fabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   // ✅ Toggle search mode
//   void _toggleSearch() {
//     setState(() {
//       _isSearching = !_isSearching;
//       if (!_isSearching) {
//         _searchDate = null;
//         _searchController.clear();
//       }
//     });
//   }
//
//   // ✅ Show date picker for search
//   Future<void> _selectSearchDate() async {
//     final now = DateTime.now();
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     final pickedDate = await showDatePicker(
//       context: context,
//       initialDate: _searchDate ?? now,
//       firstDate: now.subtract(const Duration(days: 365)),
//       lastDate: now.add(const Duration(days: 365)),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: isDark
//                 ? ColorScheme.dark(
//                     primary: ColorsManager.darkPrimaryGreen,
//                     onPrimary: ColorsManager.darkScaffold,
//                     surface: ColorsManager.darkScaffold,
//                     onSurface: Colors.white,
//                   )
//                 : ColorScheme.light(
//                     primary: ColorsManager.primaryGreen,
//                     onPrimary: Colors.white,
//                     surface: ColorsManager.cardBackground,
//                     onSurface: ColorsManager.primaryText,
//                   ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _searchDate = pickedDate;
//         _searchController.text = DateFormat('MMM d, yyyy').format(pickedDate);
//       });
//     }
//   }
//
//   // ✅ Clear search
//   void _clearSearch() {
//     setState(() {
//       _searchDate = null;
//       _searchController.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         title: _isSearching
//             ? _buildSearchField(s)
//             : Text(
//                 s.my_workouts,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: ColorsManager.getPrimaryText(context),
//                 ),
//               ),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//         iconTheme: IconThemeData(color: ColorsManager.getPrimaryText(context)),
//         leading: _isSearching
//             ? IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed: _toggleSearch,
//               )
//             : null,
//         actions: [
//           if (!_isSearching)
//             IconButton(
//               icon: Icon(
//                 Icons.search,
//                 color: ColorsManager.getPrimaryGreen(context),
//               ),
//               onPressed: _toggleSearch,
//             ),
//           if (!_isSearching)
//             IconButton(
//               icon: Icon(
//                 Icons.filter_list,
//                 color: ColorsManager.getPrimaryGreen(context),
//               ),
//               onPressed: () => _showFilterSheet(context),
//             ),
//           if (_isSearching && _searchDate != null)
//             IconButton(
//               icon: const Icon(Icons.clear, color: Colors.red),
//               onPressed: _clearSearch,
//             ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () async {
//           _loadWorkouts();
//         },
//         color: ColorsManager.primaryGreen,
//         child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
//           listenWhen: (previous, current) =>
//               current is WorkoutsError ||
//               (current is WorkoutSessionLoaded &&
//                   _pendingNavigationSessionId != null),
//           listener: (context, state) {
//             if (state is WorkoutsError) {
//               _showErrorSnackBar(state.message);
//               if (_pendingNavigationSessionId != null) {
//                 setState(() {
//                   _pendingNavigationSessionId = null;
//                 });
//               }
//             }
//
//             if (state is WorkoutSessionLoaded &&
//                 _pendingNavigationSessionId != null) {
//               _showSuccessSnackBar(S.of(context).workout_session_created);
//
//               final sessionId = _pendingNavigationSessionId;
//               _pendingNavigationSessionId = null;
//
//               Future.delayed(const Duration(milliseconds: 1600), () {
//                 if (mounted) {
//                   Navigator.pushNamed(
//                     context,
//                     Routes.workoutDetails,
//                     arguments: sessionId,
//                   ).then((_) => _loadWorkouts());
//                 }
//               });
//             }
//           },
//           buildWhen: (previous, current) {
//             if (current is WorkoutsLoading &&
//                 _pendingNavigationSessionId != null) {
//               return false;
//             }
//
//             if (current is WorkoutSessionLoaded &&
//                 _pendingNavigationSessionId != null) {
//               return false;
//             }
//
//             if (current is WorkoutsUpdating) {
//               return false;
//             }
//
//             return current is WorkoutHistoryLoaded ||
//                 (current is WorkoutsLoading &&
//                     previous is! WorkoutHistoryLoaded);
//           },
//           builder: (context, state) {
//             if (state is WorkoutsLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: ColorsManager.primaryGreen,
//                 ),
//               );
//             }
//
//             if (state is WorkoutHistoryLoaded) {
//               // ✅ Apply search filter first
//               List<WorkoutSessionModel> workouts = state.sessions;
//
//               if (_searchDate != null) {
//                 workouts = workouts.where((workout) {
//                   final workoutDate = DateTime(
//                     workout.date.year,
//                     workout.date.month,
//                     workout.date.day,
//                   );
//                   final searchDay = DateTime(
//                     _searchDate!.year,
//                     _searchDate!.month,
//                     _searchDate!.day,
//                   );
//                   return workoutDate == searchDay;
//                 }).toList();
//               }
//
//               final filteredWorkouts = _filterWorkouts(workouts);
//
//               return SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 padding: EdgeInsets.all(20.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // ✅ Show search info banner if searching
//                     if (_searchDate != null) ...[
//                       _buildSearchInfoBanner(s, filteredWorkouts.length),
//                       SizedBox(height: 16.h),
//                     ],
//
//                     // Show stats only when not searching
//                     if (_searchDate == null) ...[
//                       // _buildStatsRow(state.sessions, s),
//                       WorkoutStatsRow(sessions: state.sessions),
//                       SizedBox(height: 24.h),
//                     ],
//
//                     _buildFilterChips(s),
//                     SizedBox(height: 24.h),
//                     _buildSectionHeader(s, filteredWorkouts.length),
//                     SizedBox(height: 16.h),
//
//                     if (filteredWorkouts.isEmpty)
//                       _buildEmptyState(s)
//                     else
//                       ...filteredWorkouts.asMap().entries.map((entry) {
//                         return _buildAnimatedWorkoutCard(
//                           entry.value,
//                           entry.key,
//                         );
//                       }).toList(),
//                   ],
//                 ),
//               );
//             }
//
//             return _buildEmptyState(s);
//           },
//         ),
//       ),
//       floatingActionButton: _buildAnimatedFAB(s),
//     );
//   }
//
//   // ✅ Search field in app bar
//   Widget _buildSearchField(S s) {
//     return TextField(
//       controller: _searchController,
//       readOnly: true,
//       onTap: _selectSearchDate,
//       style: TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w600,
//         color: ColorsManager.getPrimaryText(context),
//       ),
//       decoration: InputDecoration(
//         hintText: s.search_by_date,
//         hintStyle: TextStyle(
//           fontSize: 14,
//           color: ColorsManager.getSecondaryText(context),
//         ),
//         border: InputBorder.none,
//         prefixIcon: Icon(
//           Icons.calendar_today,
//           color: ColorsManager.getPrimaryGreen(context),
//           size: 20.sp,
//         ),
//         suffixIcon: _searchDate != null
//             ? null
//             : Icon(
//                 Icons.keyboard_arrow_down,
//                 color: ColorsManager.getSecondaryText(context),
//                 size: 20.sp,
//               ),
//       ),
//     );
//   }
//
//   // ✅ Search info banner
//   Widget _buildSearchInfoBanner(S s, int resultCount) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: const Duration(milliseconds: 400),
//       builder: (context, value, child) {
//         return Transform.scale(
//           scale: value,
//           child: Container(
//             padding: EdgeInsets.all(16.w),
//             decoration: BoxDecoration(
//               color: ColorsManager.getPrimaryGreen(
//                 context,
//               ).withValues(alpha: isDark ? 0.15 : 0.1),
//               borderRadius: BorderRadius.circular(12.r),
//               border: Border.all(
//                 color: ColorsManager.getPrimaryGreen(
//                   context,
//                 ).withValues(alpha: isDark ? 0.4 : 0.3),
//                 width: 1.5,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(8.w),
//                   decoration: BoxDecoration(
//                     color: ColorsManager.getPrimaryGreen(context),
//                     borderRadius: BorderRadius.circular(8.r),
//                   ),
//                   child: Icon(
//                     Icons.search,
//                     color: isDark ? ColorsManager.darkScaffold : Colors.white,
//                     size: 20.sp,
//                   ),
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         s.searching_for,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: ColorsManager.getSecondaryText(context),
//                         ),
//                       ),
//                       SizedBox(height: 4.h),
//                       Text(
//                         DateFormat('EEEE, MMMM d, yyyy').format(_searchDate!),
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           color: ColorsManager.getPrimaryGreen(context),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 12.w,
//                     vertical: 6.h,
//                   ),
//                   decoration: BoxDecoration(
//                     color: ColorsManager.getPrimaryGreen(context),
//                     borderRadius: BorderRadius.circular(20.r),
//                   ),
//                   child: Text(
//                     '$resultCount ${s.found}',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: isDark ? ColorsManager.darkScaffold : Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildStatCard({
//     required IconData icon,
//     required String value,
//     required String label,
//     required Color color,
//   }) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Container(
//       padding: EdgeInsets.all(12.w),
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardTheme.color,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: isDark
//                 ? Colors.black.withValues(alpha: 0.3)
//                 : Colors.black.withValues(alpha: 0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: color, size: 28.sp),
//           SizedBox(height: 8.h),
//           TweenAnimationBuilder<int>(
//             tween: IntTween(begin: 0, end: int.tryParse(value) ?? 0),
//             duration: const Duration(milliseconds: 800),
//             builder: (context, val, child) {
//               return Text(
//                 val.toString(),
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: ColorsManager.getPrimaryText(context),
//                 ),
//               );
//             },
//           ),
//           SizedBox(height: 4.h),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: ColorsManager.getSecondaryText(context),
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // ========== SECTION HEADER ==========
//   Widget _buildSectionHeader(S s, int count) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           _searchDate != null ? s.search_results : s.workout_history,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: ColorsManager.getPrimaryText(context),
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
//           decoration: BoxDecoration(
//             color: ColorsManager.getPrimaryGreen(
//               context,
//             ).withValues(alpha: isDark ? 0.15 : 0.1),
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: Text(
//             '$count ${s.sessions}',
//             style: TextStyle(
//               fontSize: 12,
//               color: ColorsManager.getPrimaryGreen(context),
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   // ========== FILTER CHIPS ==========
//   Widget _buildFilterChips(S s) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           _buildAnimatedChip(s.all, 'all', 0),
//           SizedBox(width: 8.w),
//           _buildAnimatedChip(s.in_progress, 'in_progress', 1),
//           SizedBox(width: 8.w),
//           _buildAnimatedChip(s.completed, 'completed', 2),
//           SizedBox(width: 8.w),
//           _buildAnimatedChip(s.today, 'today', 3),
//           SizedBox(width: 8.w),
//           _buildAnimatedChip(s.this_week, 'week', 4),
//           SizedBox(width: 8.w),
//           _buildAnimatedChip(s.this_month, 'month', 5),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAnimatedChip(String label, String value, int index) {
//     final isSelected = _selectedFilter == value;
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(milliseconds: 400 + (index * 100)),
//       curve: Curves.elasticOut,
//       builder: (context, scale, child) {
//         return Transform.scale(
//           scale: scale,
//           child: FilterChip(
//             label: Text(label),
//             selected: isSelected,
//             onSelected: (selected) {
//               setState(() => _selectedFilter = value);
//             },
//             backgroundColor: Theme.of(context).cardTheme.color,
//             selectedColor: isDark
//                 ? ColorsManager.darkPrimaryGreen
//                 : ColorsManager.primaryGreen,
//             checkmarkColor: isDark ? ColorsManager.darkScaffold : Colors.white,
//             labelStyle: TextStyle(
//               fontSize: 14,
//               color: isSelected
//                   ? (isDark ? ColorsManager.darkScaffold : Colors.white)
//                   : ColorsManager.getPrimaryText(context),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   // ========== WORKOUT CARDS ==========
//   Widget _buildAnimatedWorkoutCard(WorkoutSessionModel workout, int index) {
//     return TweenAnimationBuilder<double>(
//       tween: Tween(begin: 0.0, end: 1.0),
//       duration: Duration(
//         milliseconds: 500 + (index * 100),
//       ), // ✅ Staggered timing
//       curve: Curves.easeOutCubic, // ✅ Smooth curve
//       builder: (context, value, child) {
//         return Transform.translate(
//           offset: Offset(30 * (1 - value), 0), // ✅ Slide from right
//           child: Transform.scale(
//             scale: 0.8 + (value * 0.2), // ✅ Scale from 0.8 to 1.0
//             child: Opacity(
//               opacity: value,
//               child: Padding(
//                 padding: EdgeInsets.only(bottom: 12.h),
//                 child: _buildWorkoutCard(workout),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildWorkoutCard(WorkoutSessionModel workout) {
//     final s = S.of(context);
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final dateFormat = DateFormat('EEEE, MMM d');
//     final timeFormat = DateFormat('h:mm a');
//
//     return InkWell(
//       onTap: () => Navigator.pushNamed(
//         context,
//         Routes.workoutDetails,
//         arguments: workout.id,
//       ).then((_) => _loadWorkouts()),
//       borderRadius: BorderRadius.circular(16.r),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardTheme.color,
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color: workout.isCompleted
//                 ? ColorsManager.success.withValues(alpha: isDark ? 0.4 : 0.3)
//                 : ColorsManager.info.withValues(alpha: isDark ? 0.4 : 0.3),
//             width: 1.5,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: isDark
//                   ? Colors.black.withValues(alpha: 0.3)
//                   : Colors.black.withValues(alpha: 0.08),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header Row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(8.w),
//                       decoration: BoxDecoration(
//                         color:
//                             (workout.isCompleted
//                                     ? ColorsManager.success
//                                     : ColorsManager.info)
//                                 .withValues(alpha: isDark ? 0.15 : 0.1),
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: Icon(
//                         workout.isCompleted
//                             ? Icons.check_circle
//                             : workout.startTime != null
//                             ? Icons.play_circle
//                             : Icons.pending,
//                         color: workout.isCompleted
//                             ? ColorsManager.success
//                             : ColorsManager.info,
//                         size: 20.sp,
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           dateFormat.format(workout.date),
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: ColorsManager.getPrimaryText(context),
//                           ),
//                         ),
//                         Text(
//                           workout.startTime != null
//                               ? timeFormat.format(workout.startTime!)
//                               : s.not_started,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: ColorsManager.getSecondaryText(context),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     if (!workout.isCompleted &&
//                         workout.workoutExercises.isNotEmpty)
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 8.w,
//                           vertical: 4.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: ColorsManager.getPrimaryGreen(
//                             context,
//                           ).withValues(alpha: isDark ? 0.15 : 0.1),
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                         child: Text(
//                           s.in_progress,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: ColorsManager.getPrimaryGreen(context),
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     SizedBox(width: 8.w),
//                     Icon(
//                       Icons.chevron_right,
//                       color: ColorsManager.getSecondaryText(context),
//                       size: 24.sp,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//
//             // Notes Section
//             if (workout.notes != null && workout.notes!.isNotEmpty) ...[
//               SizedBox(height: 12.h),
//               Container(
//                 padding: EdgeInsets.all(12.w),
//                 decoration: BoxDecoration(
//                   color: ColorsManager.getPrimaryGreen(
//                     context,
//                   ).withValues(alpha: isDark ? 0.1 : 0.05),
//                   borderRadius: BorderRadius.circular(8.r),
//                   border: Border.all(
//                     color: ColorsManager.getPrimaryGreen(
//                       context,
//                     ).withValues(alpha: isDark ? 0.3 : 0.2),
//                     width: 1,
//                   ),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Icon(
//                       Icons.note_outlined,
//                       size: 16.sp,
//                       color: ColorsManager.getPrimaryGreen(context),
//                     ),
//                     SizedBox(width: 8.w),
//                     Expanded(
//                       child: Text(
//                         workout.notes!,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: ColorsManager.getPrimaryText(context),
//                           fontStyle: FontStyle.italic,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//
//             // Exercise Stats
//             if (workout.workoutExercises.isNotEmpty) ...[
//               SizedBox(height: 12.h),
//               Divider(
//                 color: isDark
//                     ? ColorsManager.darkBorder
//                     : ColorsManager.lightBorder,
//                 height: 1,
//               ),
//               SizedBox(height: 12.h),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.fitness_center,
//                     size: 16.sp,
//                     color: ColorsManager.getPrimaryGreen(context),
//                   ),
//                   SizedBox(width: 4.w),
//                   Text(
//                     '${workout.workoutExercises.length} ${s.exercises}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: ColorsManager.getSecondaryText(context),
//                     ),
//                   ),
//                   SizedBox(width: 16.w),
//                   Icon(
//                     Icons.repeat,
//                     size: 16.sp,
//                     color: ColorsManager.getPrimaryGreen(context),
//                   ),
//                   SizedBox(width: 4.w),
//                   Text(
//                     '${_getTotalSets(workout)} ${s.sets}',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: ColorsManager.getSecondaryText(context),
//                     ),
//                   ),
//                   if (workout.durationMinutes != null) ...[
//                     SizedBox(width: 16.w),
//                     Icon(
//                       Icons.timer,
//                       size: 16.sp,
//                       color: ColorsManager.getPrimaryGreen(context),
//                     ),
//                     SizedBox(width: 4.w),
//                     Text(
//                       '${workout.durationMinutes} ${s.minutes}',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: ColorsManager.getSecondaryText(context),
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ] else
//               Padding(
//                 padding: EdgeInsets.only(top: 8.h),
//                 child: Text(
//                   s.no_exercises_added_yet,
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: ColorsManager.getSecondaryText(context),
//                     fontStyle: FontStyle.italic,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ========== EMPTY STATE ==========
//   Widget _buildEmptyState(S s) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(40.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 800),
//               builder: (context, value, child) {
//                 return Transform.scale(
//                   scale: value,
//                   child: Icon(
//                     _searchDate != null
//                         ? Icons.search_off
//                         : Icons.fitness_center_outlined,
//                     size: 80.sp,
//                     color: ColorsManager.getSecondaryText(context),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 24.h),
//             Text(
//               _searchDate != null ? s.no_workouts_found : s.no_workouts_yet,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: ColorsManager.getPrimaryText(context),
//               ),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               _searchDate != null
//                   ? s.try_different_date
//                   : s.start_your_fitness_journey,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: ColorsManager.getSecondaryText(context),
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ========== ANIMATED FAB ==========
//   Widget _buildAnimatedFAB(S s) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return ScaleTransition(
//       scale: _fabAnimation,
//       child: FloatingActionButton.extended(
//         heroTag: 'create_workout_fab',
//         onPressed: () => _createNewWorkout(),
//         backgroundColor: ColorsManager.getPrimaryGreen(context),
//         foregroundColor: isDark ? ColorsManager.darkScaffold : Colors.white,
//         icon: const Icon(Icons.add),
//         label: Text(
//           s.create_workout,
//           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
//
//   // ========== HELPERS ==========
//   List<WorkoutSessionModel> _filterWorkouts(
//     List<WorkoutSessionModel> sessions,
//   ) {
//     final now = DateTime.now();
//
//     switch (_selectedFilter) {
//       case 'completed':
//         return sessions.where((s) => s.isCompleted).toList();
//       case 'in_progress':
//         return sessions.where((s) => !s.isCompleted).toList();
//       case 'today':
//         return sessions.where((s) {
//           return s.date.year == now.year &&
//               s.date.month == now.month &&
//               s.date.day == now.day;
//         }).toList();
//       case 'week':
//         final weekStart = now.subtract(Duration(days: now.weekday - 1));
//         return sessions.where((s) => s.date.isAfter(weekStart)).toList();
//       case 'month':
//         return sessions.where((s) {
//           return s.date.year == now.year && s.date.month == now.month;
//         }).toList();
//       default:
//         return sessions;
//     }
//   }
//
//   int _getTotalSets(WorkoutSessionModel workout) {
//     return workout.workoutExercises.fold(
//       0,
//       (total, exercise) => total + exercise.sets.length,
//     );
//   }
//
//   void _createNewWorkout() {
//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (dialogContext) => CreateWorkoutDialog(
//         onConfirm: (DateTime date, String? notes) async {
//           await context.read<WorkoutsCubit>().createWorkoutSession(
//             date: date,
//             notes: notes,
//           );
//
//           final state = context.read<WorkoutsCubit>().state;
//           if (state is WorkoutSessionLoaded) {
//             setState(() {
//               _pendingNavigationSessionId = state.session.id;
//             });
//           }
//         },
//       ),
//     );
//   }
//
//   void _showSuccessSnackBar(String message) {
//     if (!mounted) return;
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.elasticOut,
//               builder: (context, value, child) {
//                 return Transform.scale(
//                   scale: value,
//                   child: Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.check_circle,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     S.of(context).success,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     message,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.white.withValues(alpha: 0.9),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: ColorsManager.success,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         margin: EdgeInsets.all(16.w),
//         duration: const Duration(seconds: 3),
//       ),
//     );
//   }
//
//   void _showErrorSnackBar(String message) {
//     if (!mounted) return;
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             TweenAnimationBuilder<double>(
//               tween: Tween(begin: 0.0, end: 1.0),
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.elasticOut,
//               builder: (context, value, child) {
//                 return Transform.rotate(
//                   angle: value * 6.28,
//                   child: Container(
//                     padding: EdgeInsets.all(8.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withValues(alpha: 0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.error_outline,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ),
//                 );
//               },
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     S.of(context).error,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     message,
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.white.withValues(alpha: 0.9),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         margin: EdgeInsets.all(16.w),
//         duration: const Duration(seconds: 4),
//         action: SnackBarAction(
//           label: S.of(context).dismiss,
//           textColor: Colors.white,
//           onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
//         ),
//       ),
//     );
//   }
//
//   void _showFilterSheet(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).cardTheme.color,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//       ),
//       builder: (context) {
//         final s = S.of(context);
//         return Padding(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 s.filter,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: ColorsManager.getPrimaryText(context),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               _buildFilterOption(s.all, 'all', Icons.all_inclusive),
//               _buildFilterOption(
//                 s.in_progress,
//                 'in_progress',
//                 Icons.play_circle,
//               ),
//               _buildFilterOption(s.completed, 'completed', Icons.check_circle),
//               _buildFilterOption(s.today, 'today', Icons.today),
//               _buildFilterOption(s.this_week, 'week', Icons.date_range),
//               _buildFilterOption(s.this_month, 'month', Icons.calendar_month),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildFilterOption(String label, String value, IconData icon) {
//     final isSelected = _selectedFilter == value;
//
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: isSelected
//             ? ColorsManager.getPrimaryGreen(context)
//             : ColorsManager.getSecondaryText(context),
//       ),
//       title: Text(
//         label,
//         style: TextStyle(
//           fontSize: 14,
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           color: isSelected
//               ? ColorsManager.getPrimaryGreen(context)
//               : ColorsManager.getPrimaryText(context),
//         ),
//       ),
//       trailing: isSelected
//           ? Icon(Icons.check, color: ColorsManager.getPrimaryGreen(context))
//           : null,
//       onTap: () {
//         setState(() => _selectedFilter = value);
//         Navigator.pop(context);
//       },
//     );
//   }
// }

class UserWorkoutsScreen extends StatefulWidget {
  final bool Function()? isVisible;

  const UserWorkoutsScreen({super.key, this.isVisible});

  @override
  State<UserWorkoutsScreen> createState() => _UserWorkoutsScreenState();
}

class _UserWorkoutsScreenState extends State<UserWorkoutsScreen>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'all';
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  String? _pendingNavigationSessionId;

  // Search functionality
  DateTime? _searchDate;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();

    // Load workouts only if visible or no visibility callback
    if (widget.isVisible == null || widget.isVisible!()) {
      _loadWorkouts();
    }
  }

  @override
  void didUpdateWidget(UserWorkoutsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reload workouts when becoming visible
    if (widget.isVisible != null) {
      final wasVisible = oldWidget.isVisible?.call() ?? false;
      final isNowVisible = widget.isVisible!();

      if (!wasVisible && isNowVisible) {
        _loadWorkouts();
      }
    }
  }

  void _setupAnimations() {
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fabAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fabController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _fabController.forward();
    });
  }

  void _loadWorkouts() {
    // Only load if visible or no visibility callback
    if (widget.isVisible == null || widget.isVisible!()) {
      context.read<WorkoutsCubit>().loadWorkoutHistory();
    }
  }

  @override
  void dispose() {
    _fabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Toggle search mode
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchDate = null;
        _searchController.clear();
      }
    });
  }

  // Show date picker for search
  Future<void> _selectSearchDate() async {
    final now = DateTime.now();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _searchDate ?? now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? ColorScheme.dark(
                    primary: ColorsManager.darkPrimaryGreen,
                    onPrimary: ColorsManager.darkScaffold,
                    surface: ColorsManager.darkScaffold,
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
      setState(() {
        _searchDate = pickedDate;
        _searchController.text = DateFormat('MMM d, yyyy').format(pickedDate);
      });
    }
  }

  // Clear search
  void _clearSearch() {
    setState(() {
      _searchDate = null;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: _isSearching
            ? _buildSearchField(s)
            : Text(
                s.my_workouts,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryText(context),
                ),
              ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.getPrimaryText(context)),
        leading: _isSearching
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _toggleSearch,
              )
            : null,
        automaticallyImplyLeading: widget.isVisible == null,
        actions: [
          if (!_isSearching)
            IconButton(
              icon: Icon(
                Icons.search,
                color: ColorsManager.getPrimaryGreen(context),
              ),
              onPressed: _toggleSearch,
            ),
          if (!_isSearching)
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color: ColorsManager.getPrimaryGreen(context),
              ),
              onPressed: () => _showFilterSheet(context),
            ),
          if (_isSearching && _searchDate != null)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.red),
              onPressed: _clearSearch,
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadWorkouts();
        },
        color: ColorsManager.primaryGreen,
        child: BlocConsumer<WorkoutsCubit, WorkoutsState>(
          listenWhen: (previous, current) =>
              current is WorkoutsError ||
              (current is WorkoutSessionLoaded &&
                  _pendingNavigationSessionId != null),
          listener: (context, state) {
            if (state is WorkoutsError) {
              _showErrorSnackBar(state.message);
              if (_pendingNavigationSessionId != null) {
                setState(() {
                  _pendingNavigationSessionId = null;
                });
              }
            }

            if (state is WorkoutSessionLoaded &&
                _pendingNavigationSessionId != null) {
              _showSuccessSnackBar(S.of(context).workout_session_created);

              final sessionId = _pendingNavigationSessionId;
              _pendingNavigationSessionId = null;

              Future.delayed(const Duration(milliseconds: 1600), () {
                if (mounted) {
                  Navigator.pushNamed(
                    context,
                    Routes.workoutDetails,
                    arguments: sessionId,
                  ).then((_) => _loadWorkouts());
                }
              });
            }
          },
          buildWhen: (previous, current) {
            if (current is WorkoutsLoading &&
                _pendingNavigationSessionId != null) {
              return false;
            }

            if (current is WorkoutSessionLoaded &&
                _pendingNavigationSessionId != null) {
              return false;
            }

            if (current is WorkoutsUpdating) {
              return false;
            }

            return current is WorkoutHistoryLoaded ||
                (current is WorkoutsLoading &&
                    previous is! WorkoutHistoryLoaded);
          },
          builder: (context, state) {
            if (state is WorkoutsLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.primaryGreen,
                ),
              );
            }

            if (state is WorkoutHistoryLoaded) {
              // Apply search filter first
              List<WorkoutSessionModel> workouts = state.sessions;

              if (_searchDate != null) {
                workouts = workouts.where((workout) {
                  final workoutDate = DateTime(
                    workout.date.year,
                    workout.date.month,
                    workout.date.day,
                  );
                  final searchDay = DateTime(
                    _searchDate!.year,
                    _searchDate!.month,
                    _searchDate!.day,
                  );
                  return workoutDate == searchDay;
                }).toList();
              }

              final filteredWorkouts = _filterWorkouts(workouts);

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show search info banner if searching
                    if (_searchDate != null) ...[
                      _buildSearchInfoBanner(s, filteredWorkouts.length),
                      SizedBox(height: 16.h),
                    ],

                    // Show stats only when not searching
                    if (_searchDate == null) ...[
                      WorkoutStatsRow(sessions: state.sessions),
                      SizedBox(height: 24.h),
                    ],

                    _buildFilterChips(s),
                    SizedBox(height: 24.h),
                    _buildSectionHeader(s, filteredWorkouts.length),
                    SizedBox(height: 16.h),

                    if (filteredWorkouts.isEmpty)
                      _buildEmptyState(s)
                    else
                      ...filteredWorkouts.asMap().entries.map((entry) {
                        return _buildAnimatedWorkoutCard(
                          entry.value,
                          entry.key,
                        );
                      }).toList(),
                  ],
                ),
              );
            }

            return _buildEmptyState(s);
          },
        ),
      ),
      floatingActionButton: _buildAnimatedFAB(s),
    );
  }

  // Search field in app bar
  Widget _buildSearchField(S s) {
    return TextField(
      controller: _searchController,
      readOnly: true,
      onTap: _selectSearchDate,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: ColorsManager.getPrimaryText(context),
      ),
      decoration: InputDecoration(
        hintText: s.search_by_date,
        hintStyle: TextStyle(
          fontSize: 14,
          color: ColorsManager.getSecondaryText(context),
        ),
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.calendar_today,
          color: ColorsManager.getPrimaryGreen(context),
          size: 20.sp,
        ),
        suffixIcon: _searchDate != null
            ? null
            : Icon(
                Icons.keyboard_arrow_down,
                color: ColorsManager.getSecondaryText(context),
                size: 20.sp,
              ),
      ),
    );
  }

  // Search info banner
  Widget _buildSearchInfoBanner(S s, int resultCount) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
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
                    Icons.search,
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
                        s.searching_for,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.getSecondaryText(context),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        DateFormat('EEEE, MMMM d, yyyy').format(_searchDate!),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.getPrimaryGreen(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.getPrimaryGreen(context),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '$resultCount ${s.found}',
                    style: TextStyle(
                      fontSize: 10,
                      color: isDark ? ColorsManager.darkScaffold : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Section header
  Widget _buildSectionHeader(S s, int count) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _searchDate != null ? s.search_results : s.workout_history,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: ColorsManager.getPrimaryGreen(
              context,
            ).withValues(alpha: isDark ? 0.15 : 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            '$count ${s.sessions}',
            style: TextStyle(
              fontSize: 12,
              color: ColorsManager.getPrimaryGreen(context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Filter chips
  Widget _buildFilterChips(S s) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildAnimatedChip(s.all, 'all', 0),
          SizedBox(width: 8.w),
          _buildAnimatedChip(s.in_progress, 'in_progress', 1),
          SizedBox(width: 8.w),
          _buildAnimatedChip(s.completed, 'completed', 2),
          SizedBox(width: 8.w),
          _buildAnimatedChip(s.today, 'today', 3),
          SizedBox(width: 8.w),
          _buildAnimatedChip(s.this_week, 'week', 4),
          SizedBox(width: 8.w),
          _buildAnimatedChip(s.this_month, 'month', 5),
        ],
      ),
    );
  }

  Widget _buildAnimatedChip(String label, String value, int index) {
    final isSelected = _selectedFilter == value;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 100)),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: FilterChip(
            label: Text(label),
            selected: isSelected,
            onSelected: (selected) {
              setState(() => _selectedFilter = value);
            },
            backgroundColor: Theme.of(context).cardTheme.color,
            selectedColor: isDark
                ? ColorsManager.darkPrimaryGreen
                : ColorsManager.primaryGreen,
            checkmarkColor: isDark ? ColorsManager.darkScaffold : Colors.white,
            labelStyle: TextStyle(
              fontSize: 14,
              color: isSelected
                  ? (isDark ? ColorsManager.darkScaffold : Colors.white)
                  : ColorsManager.getPrimaryText(context),
            ),
          ),
        );
      },
    );
  }

  // Workout cards
  Widget _buildAnimatedWorkoutCard(WorkoutSessionModel workout, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(30 * (1 - value), 0),
          child: Transform.scale(
            scale: 0.8 + (value * 0.2),
            child: Opacity(
              opacity: value,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildWorkoutCard(workout),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWorkoutCard(WorkoutSessionModel workout) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dateFormat = DateFormat('EEEE, MMM d');
    final timeFormat = DateFormat('h:mm a');

    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        Routes.workoutDetails,
        arguments: workout.id,
      ).then((_) => _loadWorkouts()),
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: workout.isCompleted
                ? ColorsManager.success.withValues(alpha: isDark ? 0.4 : 0.3)
                : ColorsManager.info.withValues(alpha: isDark ? 0.4 : 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color:
                            (workout.isCompleted
                                    ? ColorsManager.success
                                    : ColorsManager.info)
                                .withValues(alpha: isDark ? 0.15 : 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        workout.isCompleted
                            ? Icons.check_circle
                            : workout.startTime != null
                            ? Icons.play_circle
                            : Icons.pending,
                        color: workout.isCompleted
                            ? ColorsManager.success
                            : ColorsManager.info,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dateFormat.format(workout.date),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.getPrimaryText(context),
                          ),
                        ),
                        Text(
                          workout.startTime != null
                              ? timeFormat.format(workout.startTime!)
                              : s.not_started,
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (!workout.isCompleted &&
                        workout.workoutExercises.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: ColorsManager.getPrimaryGreen(
                            context,
                          ).withValues(alpha: isDark ? 0.15 : 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          s.in_progress,
                          style: TextStyle(
                            fontSize: 10,
                            color: ColorsManager.getPrimaryGreen(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.chevron_right,
                      color: ColorsManager.getSecondaryText(context),
                      size: 24.sp,
                    ),
                  ],
                ),
              ],
            ),

            // Notes Section
            if (workout.notes != null && workout.notes!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: ColorsManager.getPrimaryGreen(
                    context,
                  ).withValues(alpha: isDark ? 0.1 : 0.05),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: ColorsManager.getPrimaryGreen(
                      context,
                    ).withValues(alpha: isDark ? 0.3 : 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.note_outlined,
                      size: 16.sp,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        workout.notes!,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorsManager.getPrimaryText(context),
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Exercise Stats
            if (workout.workoutExercises.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Divider(
                color: isDark
                    ? ColorsManager.darkBorder
                    : ColorsManager.lightBorder,
                height: 1,
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Icon(
                    Icons.fitness_center,
                    size: 16.sp,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${workout.workoutExercises.length} ${s.exercises}',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Icon(
                    Icons.repeat,
                    size: 16.sp,
                    color: ColorsManager.getPrimaryGreen(context),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${_getTotalSets(workout)} ${s.sets}',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                  if (workout.durationMinutes != null) ...[
                    SizedBox(width: 16.w),
                    Icon(
                      Icons.timer,
                      size: 16.sp,
                      color: ColorsManager.getPrimaryGreen(context),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      '${workout.durationMinutes} ${s.minutes}',
                      style: TextStyle(
                        fontSize: 12,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ] else
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  s.no_exercises_added_yet,
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorsManager.getSecondaryText(context),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Empty state
  Widget _buildEmptyState(S s) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    _searchDate != null
                        ? Icons.search_off
                        : Icons.fitness_center_outlined,
                    size: 80.sp,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                );
              },
            ),
            SizedBox(height: 24.h),
            Text(
              _searchDate != null ? s.no_workouts_found : s.no_workouts_yet,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsManager.getPrimaryText(context),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _searchDate != null
                  ? s.try_different_date
                  : s.start_your_fitness_journey,
              style: TextStyle(
                fontSize: 14,
                color: ColorsManager.getSecondaryText(context),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Animated FAB
  Widget _buildAnimatedFAB(S s) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ScaleTransition(
      scale: _fabAnimation,
      child: FloatingActionButton.extended(
        heroTag: 'create_workout_fab',
        onPressed: () => _createNewWorkout(),
        backgroundColor: ColorsManager.getPrimaryGreen(context),
        foregroundColor: isDark ? ColorsManager.darkScaffold : Colors.white,
        icon: const Icon(Icons.add),
        label: Text(
          s.create_workout,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  // Helpers
  List<WorkoutSessionModel> _filterWorkouts(
    List<WorkoutSessionModel> sessions,
  ) {
    final now = DateTime.now();

    switch (_selectedFilter) {
      case 'completed':
        return sessions.where((s) => s.isCompleted).toList();
      case 'in_progress':
        return sessions.where((s) => !s.isCompleted).toList();
      case 'today':
        return sessions.where((s) {
          return s.date.year == now.year &&
              s.date.month == now.month &&
              s.date.day == now.day;
        }).toList();
      case 'week':
        final weekStart = now.subtract(Duration(days: now.weekday - 1));
        return sessions.where((s) => s.date.isAfter(weekStart)).toList();
      case 'month':
        return sessions.where((s) {
          return s.date.year == now.year && s.date.month == now.month;
        }).toList();
      default:
        return sessions;
    }
  }

  int _getTotalSets(WorkoutSessionModel workout) {
    return workout.workoutExercises.fold(
      0,
      (total, exercise) => total + exercise.sets.length,
    );
  }

  void _createNewWorkout() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => CreateWorkoutDialog(
        onConfirm: (DateTime date, String? notes) async {
          await context.read<WorkoutsCubit>().createWorkoutSession(
            date: date,
            notes: notes,
          );

          final state = context.read<WorkoutsCubit>().state;
          if (state is WorkoutSessionLoaded) {
            setState(() {
              _pendingNavigationSessionId = state.session.id;
            });
          }
        },
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).success,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: ColorsManager.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.rotate(
                  angle: value * 6.28,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    S.of(context).error,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: S.of(context).dismiss,
          textColor: Colors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        final s = S.of(context);
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                s.filter,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.getPrimaryText(context),
                ),
              ),
              SizedBox(height: 20.h),
              _buildFilterOption(s.all, 'all', Icons.all_inclusive),
              _buildFilterOption(
                s.in_progress,
                'in_progress',
                Icons.play_circle,
              ),
              _buildFilterOption(s.completed, 'completed', Icons.check_circle),
              _buildFilterOption(s.today, 'today', Icons.today),
              _buildFilterOption(s.this_week, 'week', Icons.date_range),
              _buildFilterOption(s.this_month, 'month', Icons.calendar_month),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(String label, String value, IconData icon) {
    final isSelected = _selectedFilter == value;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? ColorsManager.getPrimaryGreen(context)
            : ColorsManager.getSecondaryText(context),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected
              ? ColorsManager.getPrimaryGreen(context)
              : ColorsManager.getPrimaryText(context),
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: ColorsManager.getPrimaryGreen(context))
          : null,
      onTap: () {
        setState(() => _selectedFilter = value);
        Navigator.pop(context);
      },
    );
  }
}
