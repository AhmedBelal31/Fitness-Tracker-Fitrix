import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';

// class UserHomeScreenBodyBody extends StatelessWidget {
//   const UserHomeScreenBodyBody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final dashboard = MockData.getMockUserDashboard();
//     final sections = MockExercisesData.getMockSections();
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: () async {
//             await Future.delayed(const Duration(seconds: 1));
//           },
//           color: ColorsManager.primaryGreen,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Welcome Header
//                 WelcomeHeader(),
//                 SizedBox(height: 24.h),
//
//                 // Quick Stats
//                 _buildQuickStats(s, dashboard.workoutStats),
//                 SizedBox(height: 32.h),
//
//                 // Workout Sections
//                 _buildSectionHeader(context, s.workout_sections),
//                 SizedBox(height: 16.h),
//                 _buildSectionsGrid(context, sections),
//                 SizedBox(height: 32.h),
//
//                 // Quick Actions
//                 _buildQuickActions(context, s),
//                 SizedBox(height: 32.h),
//
//                 // Recent Workouts
//                 _buildSectionHeader(
//                   context,
//                   s.recent_workouts,
//                   actionText: s.view_all,
//                   onAction: () {},
//                 ),
//                 SizedBox(height: 16.h),
//                 if (dashboard.recentWorkouts != null &&
//                     dashboard.recentWorkouts!.isNotEmpty)
//                   ...dashboard.recentWorkouts!
//                       .take(3)
//                       .toList()
//                       .asMap()
//                       .entries
//                       .map(
//                         (entry) => Padding(
//                           padding: EdgeInsets.only(bottom: 12.h),
//                           child: RecentWorkoutCard(
//                             workout: entry.value,
//                             index: entry.key,
//                           ),
//                         ),
//                       )
//                 else
//                   _buildEmptyState(s.no_recent_workouts),
//                 SizedBox(height: 24.h),
//
//                 // Body Progress
//                 if (dashboard.bodyProgress != null) ...[
//                   _buildSectionHeader(context, s.body_progress),
//                   SizedBox(height: 16.h),
//                   ProgressChartWidget(bodyProgress: dashboard.bodyProgress!),
//                   SizedBox(height: 24.h),
//                 ],
//
//                 // Personal Records
//                 _buildSectionHeader(context, s.personal_records),
//                 SizedBox(height: 16.h),
//                 if (dashboard.personalRecords != null &&
//                     dashboard.personalRecords!.isNotEmpty)
//                   _buildPersonalRecords(context, dashboard.personalRecords!)
//                 else
//                   _buildEmptyState(s.no_personal_records_yet),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuickStats(S s, workoutStats) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: [
//           StatCard(
//             icon: Icons.fitness_center,
//             title: s.workout,
//             value: workoutStats?.thisMonth.toString() ?? '0',
//             subtitle: s.this_month,
//             color: ColorsManager.info,
//             index: 0,
//           ),
//           SizedBox(width: 12.w),
//           StatCard(
//             icon: Icons.timer,
//             title: s.avg_duration,
//             value: '${workoutStats?.averageDuration ?? 0}',
//             subtitle: s.minutes,
//             color: ColorsManager.success,
//             index: 1,
//           ),
//           SizedBox(width: 12.w),
//           StatCard(
//             icon: Icons.check_circle,
//             title: s.completion,
//             value: '${workoutStats?.completionRate ?? 0}%',
//             subtitle: s.rate,
//             color: ColorsManager.warning,
//             index: 2,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSectionsGrid(BuildContext context, List sections) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 12.w,
//         mainAxisSpacing: 12.h,
//         childAspectRatio: 1.0,
//       ),
//       itemCount: sections.length,
//       itemBuilder: (context, index) {
//         return SectionCard(
//           section: sections[index],
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               Routes.sectionExercises,
//               arguments: sections[index],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget _buildQuickActions(BuildContext context, S s) {
//     return Column(
//       children: [
//         // Start Workout Button
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             gradient: ColorsManager.buttonGradient,
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: ColorsManager.primaryShadow,
//           ),
//           child: ElevatedButton.icon(
//             onPressed: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(s.start_workout),
//                   backgroundColor: ColorsManager.success,
//                 ),
//               );
//             },
//             icon: const Icon(Icons.play_arrow, size: 28),
//             label: Text(s.start_workout, style: TextStyles.buttonLarge),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.transparent,
//               shadowColor: Colors.transparent,
//               padding: EdgeInsets.symmetric(vertical: 18.h),
//             ),
//           ),
//         ),
//         SizedBox(height: 12.h),
//
//         // Secondary Actions
//         Row(
//           children: [
//             Expanded(
//               child: OutlinedButton.icon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, Routes.customExercises);
//                 },
//                 icon: const Icon(Icons.add_circle_outline),
//                 label: Text(
//                   s.custom,
//                   style: TextStyles.bodyMedium.copyWith(
//                     color: ColorsManager.primaryGreen,
//                   ),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 14.h),
//                   side: const BorderSide(
//                     color: ColorsManager.primaryGreen,
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: OutlinedButton.icon(
//                 onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(s.log_measurement),
//                       backgroundColor: ColorsManager.info,
//                     ),
//                   );
//                 },
//                 icon: const Icon(Icons.monitor_weight),
//                 label: Text(
//                   s.log,
//                   style: TextStyles.bodyMedium.copyWith(
//                     color: ColorsManager.primaryGreen,
//                   ),
//                 ),
//                 style: OutlinedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 14.h),
//                   side: const BorderSide(
//                     color: ColorsManager.primaryGreen,
//                     width: 2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildSectionHeader(
//     BuildContext context,
//     String title, {
//     String? actionText,
//     VoidCallback? onAction,
//   }) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title, style: TextStyles.subtitle1),
//         if (actionText != null && onAction != null)
//           TextButton(
//             onPressed: onAction,
//             child: Text(
//               actionText,
//               style: TextStyles.font14PrimaryGreenSemiBold,
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildPersonalRecords(BuildContext context, List records) {
//     final s = S.of(context);
//     return Container(
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: ColorsManager.cardShadow,
//       ),
//       child: Column(
//         children: records
//             .take(3)
//             .map(
//               (record) => Padding(
//                 padding: EdgeInsets.only(bottom: 12.h),
//                 child: Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.all(10.w),
//                       decoration: BoxDecoration(
//                         gradient: ColorsManager.primaryGradient,
//                         borderRadius: BorderRadius.circular(12.r),
//                       ),
//                       child: Icon(
//                         Icons.emoji_events,
//                         color: ColorsManager.whiteText,
//                         size: 24.sp,
//                       ),
//                     ),
//                     SizedBox(width: 12.w),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             record.exerciseName,
//                             style: TextStyles.font16PrimaryTextRegular,
//                           ),
//                           Text(
//                             '${record.value} ${s.kg} • ${record.achievedDate}',
//                             style: TextStyles.bodySmall,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Icon(
//                       Icons.chevron_right,
//                       color: ColorsManager.lightText,
//                       size: 24.sp,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String message) {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: ColorsManager.softShadow,
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Icon(
//               Icons.inbox_outlined,
//               size: 48.sp,
//               color: ColorsManager.lightText,
//             ),
//             SizedBox(height: 12.h),
//             Text(message, style: TextStyles.bodyMedium),
//           ],
//         ),
//       ),
//     );
//   }
// }

import '../../../exercises/presentation/cubit/sections_cubit.dart';
import '../../../exercises/presentation/cubit/sections_state.dart';
import '../widgets/user_home_screen_body.dart';
import '../widgets/user_widgets/user_home_body_progress.dart';
import '../widgets/user_widgets/user_home_custom_exercises.dart';
import '../widgets/user_widgets/user_home_header.dart';
import '../widgets/user_widgets/user_home_records.dart';
import '../widgets/user_widgets/user_home_sections.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.get<SectionsCubit>()..loadSections(),
      child: const UserHomeScreenBody(),
    );
  }
}
