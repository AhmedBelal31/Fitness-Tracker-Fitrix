import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/goal_model.dart';
import '../../data/models/progress_models.dart';
import '../cubit/progress_cubit.dart';
import '../cubit/progress_state.dart';
import '../widgets/animated_goals_card.dart';
import '../widgets/celebration_overlay.dart';
import '../widgets/goals_list_card.dart';
import '../widgets/measurement_card_switcher.dart';
import '../widgets/measurements_list_card.dart';
import '../widgets/statistics_cards.dart';
import 'measurement_history_screen.dart';

// class UserProgressScreen extends StatelessWidget {
//   const UserProgressScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => di<ProgressCubit>()..loadMeasurementCards(),
//       child: const _UserProgressView(),
//     );
//   }
// }
//
// class _UserProgressView extends StatelessWidget {
//   const _UserProgressView();
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       appBar: _buildAppBar(s),
//       body: BlocBuilder<ProgressCubit, ProgressState>(
//         builder: (context, state) => _buildBody(context, state, s),
//       ),
//     );
//   }
//
//   AppBar _buildAppBar(S s) {
//     return AppBar(
//       title: Text(s.my_progress, style: TextStyles.headline3),
//       backgroundColor: ColorsManager.scaffoldBackground,
//       elevation: 0,
//     );
//   }
//
//   Widget _buildBody(BuildContext context, ProgressState state, S s) {
//     if (state is ProgressLoading) {
//       return _buildLoadingState();
//     }
//
//     if (state is ProgressError) {
//       return _buildErrorState(context, state.message);
//     }
//
//     if (state is ProgressLoaded) {
//       return _buildLoadedState(context, state, s);
//     }
//
//     return const SizedBox.shrink();
//   }
//
//   Widget _buildLoadingState() {
//     return const Center(
//       child: CircularProgressIndicator(color: ColorsManager.primaryGreen),
//     );
//   }
//
//   Widget _buildErrorState(BuildContext context, String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
//           SizedBox(height: 16.h),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 32.w),
//             child: Text(
//               message,
//               style: TextStyles.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ),
//           SizedBox(height: 16.h),
//           ElevatedButton(
//             onPressed: () =>
//                 context.read<ProgressCubit>().loadMeasurementCards(),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: ColorsManager.primaryGreen,
//               padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
//             ),
//             child: Text('Retry', style: TextStyles.font16WhiteSemiBold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadedState(BuildContext context, ProgressLoaded state, S s) {
//     return Stack(
//       children: [
//         RefreshIndicator(
//           onRefresh: () => context.read<ProgressCubit>().refreshData(),
//           color: ColorsManager.primaryGreen,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: EdgeInsets.all(20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 MeasurementCardSwitcher(
//                   cards: state.measurementCards,
//                   selectedType: state.selectedCardType,
//                 ),
//                 SizedBox(height: 30.h),
//
//                 _buildViewHistoryButton(context),
//                 SizedBox(height: 30.h),
//
//                 _buildSectionHeader(s.goals),
//                 SizedBox(height: 12.h),
//                 GoalsListCard(cards: state.measurementCards, s: s),
//                 SizedBox(height: 20.h),
//
//                 _buildSectionHeader(s.statistics),
//                 SizedBox(height: 12.h),
//                 // ✅ Pass statistics
//                 StatisticsCards(statistics: state.statistics, s: s),
//               ],
//             ),
//           ),
//         ),
//
//         if (state.shouldShowCelebration &&
//             state.celebrationMessage != null &&
//             state.celebrationProgress != null)
//           CelebrationOverlay(
//             message: state.celebrationMessage!,
//             progressPercent: state.celebrationProgress!,
//             onDismiss: () => context.read<ProgressCubit>().dismissCelebration(),
//           ),
//       ],
//     );
//   }
//
//   // ✅ Extract goals from measurement cards data
//   List<GoalData> _extractGoalsFromCards(MeasurementCardsResponse cards) {
//     return [
//       // Weight Goal
//       GoalData(
//         title: 'Weight Goal',
//         currentValue: cards.weightCard.lastWeight,
//         goalValue: cards.weightCard.weightGoal,
//         startValue: cards.weightCard.firstWeight,
//         unit: 'kg',
//         type: GoalType.decrease,
//         icon: '⚖️',
//       ),
//
//       // Body Fat Goal
//       GoalData(
//         title: 'Body Fat Goal',
//         currentValue: cards.bodyFatCard.lastBodyFat,
//         goalValue: cards.bodyFatCard.bodyFatGoal,
//         startValue: cards.bodyFatCard.firstBodyFat,
//         unit: '%',
//         type: GoalType.decrease,
//         icon: '💧',
//       ),
//
//       // Muscle Mass Goal
//       GoalData(
//         title: 'Muscle Mass Goal',
//         currentValue: cards.muscleMassCard.lastMuscleMass,
//         goalValue: cards.muscleMassCard.muscleMassGoal,
//         startValue: cards.muscleMassCard.firstMuscleMass,
//         unit: 'kg',
//         type: GoalType.increase,
//         icon: '💪',
//       ),
//     ];
//   }
//
//   Widget _buildViewHistoryButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (_) => const MeasurementHistoryScreen()),
//         );
//       },
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               ColorsManager.primaryGreen.withOpacity(0.1),
//               ColorsManager.secondaryGreen.withOpacity(0.05),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16.r),
//           border: Border.all(
//             color: ColorsManager.primaryGreen.withOpacity(0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Measurement History',
//                       style: TextStyles.font16PrimaryTextSemiBold,
//                     ),
//                     SizedBox(height: 4.h),
//                     Text(
//                       'View detailed charts & analytics',
//                       style: TextStyles.font12SecondaryTextRegular,
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(10.w),
//                   decoration: BoxDecoration(
//                     gradient: ColorsManager.primaryGradient,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     Icons.insights,
//                     color: ColorsManager.whiteText,
//                     size: 20.sp,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 12.h),
//
//             // Mini chart icons preview
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildMiniChartIcon(Icons.show_chart, 'Line'),
//                 _buildMiniChartIcon(Icons.bar_chart, 'Bar'),
//                 _buildMiniChartIcon(Icons.area_chart, 'Area'),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMiniChartIcon(IconData icon, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8.w),
//           decoration: BoxDecoration(
//             color: ColorsManager.primaryGreen.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8.r),
//           ),
//           child: Icon(icon, color: ColorsManager.primaryGreen, size: 20.sp),
//         ),
//         SizedBox(height: 4.h),
//         Text(label, style: TextStyles.font10Bold),
//       ],
//     );
//   }
//
//   ///Fourth
//   ///Fourth
//   ///Fourth
//   // Widget _buildViewHistoryButton(BuildContext context) {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       Navigator.push(
//   //         context,
//   //         MaterialPageRoute(builder: (_) => const MeasurementHistoryScreen()),
//   //       );
//   //     },
//   //     child: Container(
//   //       height: 100.h,
//   //       decoration: BoxDecoration(
//   //         gradient: LinearGradient(
//   //           colors: [ColorsManager.primaryGreen, ColorsManager.secondaryGreen],
//   //           begin: Alignment.topLeft,
//   //           end: Alignment.bottomRight,
//   //         ),
//   //         borderRadius: BorderRadius.circular(16.r),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: ColorsManager.primaryGreen.withOpacity(0.4),
//   //             blurRadius: 12,
//   //             offset: const Offset(0, 6),
//   //           ),
//   //         ],
//   //       ),
//   //       child: Stack(
//   //         children: [
//   //           // Background pattern
//   //           Positioned.fill(
//   //             child: CustomPaint(painter: _GraphPatternPainter()),
//   //           ),
//   //
//   //           // Content
//   //           Padding(
//   //             padding: EdgeInsets.all(16.w),
//   //             child: Row(
//   //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //               children: [
//   //                 Expanded(
//   //                   child: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     mainAxisAlignment: MainAxisAlignment.center,
//   //                     children: [
//   //                       Row(
//   //                         children: [
//   //                           Icon(
//   //                             Icons.trending_up,
//   //                             color: ColorsManager.whiteText,
//   //                             size: 24.sp,
//   //                           ),
//   //                           SizedBox(width: 8.w),
//   //                           Text(
//   //                             'View History',
//   //                             style: TextStyles.font18WhiteBold,
//   //                           ),
//   //                         ],
//   //                       ),
//   //                       SizedBox(height: 4.h),
//   //                       Text(
//   //                         'Analyze your progress with charts',
//   //                         style: TextStyles.font12WhiteRegular.copyWith(
//   //                           color: ColorsManager.whiteText.withOpacity(0.9),
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //                 Container(
//   //                   padding: EdgeInsets.all(12.w),
//   //                   decoration: BoxDecoration(
//   //                     color: Colors.white.withOpacity(0.2),
//   //                     shape: BoxShape.circle,
//   //                   ),
//   //                   child: Icon(
//   //                     Icons.arrow_forward,
//   //                     color: ColorsManager.whiteText,
//   //                     size: 20.sp,
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget _buildSectionHeader(String title) {
//     return Text(title, style: TextStyles.subtitle1);
//   }
// }

import '../widgets/progress_app_bar.dart';
import '../widgets/progress_loading_state.dart';
import '../widgets/progress_error_state.dart';
import '../widgets/progress_loaded_content.dart';

class UserProgressScreen extends StatelessWidget {
  const UserProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ProgressCubit>()..loadProgress(),
      child: const _UserProgressView(),
    );
  }
}

class _UserProgressView extends StatelessWidget {
  const _UserProgressView();

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: ProgressAppBar(title: s.my_progress),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (state is ProgressLoading) {
            return const ProgressLoadingState();
          }

          if (state is ProgressError) {
            return ProgressErrorState(message: state.message);
          }

          if (state is ProgressLoaded) {
            return ProgressLoadedContent(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
