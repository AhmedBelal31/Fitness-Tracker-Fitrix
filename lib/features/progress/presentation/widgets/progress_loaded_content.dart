import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../cubit/progress_cubit.dart';
import '../cubit/progress_state.dart';
import '../widgets/measurement_card_switcher.dart';
import '../widgets/goals_list_card.dart';
import '../widgets/statistics_cards.dart';
import '../widgets/view_history_button.dart';
import '../widgets/section_header.dart';
import '../widgets/celebration_overlay.dart';

// class ProgressLoadedContent extends StatelessWidget {
//   final ProgressLoaded state;
//
//   const ProgressLoadedContent({super.key, required this.state});
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
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
//                 // Measurement Cards
//                 MeasurementCardSwitcher(
//                   cards: state.measurementCards,
//                   selectedType: state.selectedCardType,
//                 ),
//                 SizedBox(height: 30.h),
//
//                 // View History Button
//                 const ViewHistoryButton(),
//                 SizedBox(height: 30.h),
//
//                 // Goals Section
//                 SectionHeader(title: s.goals),
//                 SizedBox(height: 12.h),
//                 GoalsListCard(cards: state.measurementCards, s: s),
//                 SizedBox(height: 20.h),
//
//                 // Statistics Section
//                 SectionHeader(title: s.statistics),
//                 SizedBox(height: 12.h),
//                 StatisticsCards(statistics: state.statistics, s: s),
//               ],
//             ),
//           ),
//         ),
//
//         // Celebration Overlay
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
// }

class ProgressLoadedContent extends StatelessWidget {
  final ProgressLoaded state;
  final bool Function()? isVisible; // ✅ Add visibility callback

  const ProgressLoadedContent({super.key, required this.state, this.isVisible});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    // ✅ Check if screen is visible
    final showCelebration =
        (isVisible?.call() ?? true) &&
        state.shouldShowCelebration &&
        state.celebrationMessage != null &&
        state.celebrationProgress != null;

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => context.read<ProgressCubit>().refreshData(),
          color: ColorsManager.primaryGreen,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MeasurementCardSwitcher(
                  cards: state.measurementCards,
                  selectedType: state.selectedCardType,
                ),
                SizedBox(height: 30.h),

                const ViewHistoryButton(),
                SizedBox(height: 30.h),

                SectionHeader(title: s.goals),
                SizedBox(height: 12.h),
                GoalsListCard(cards: state.measurementCards, s: s),
                SizedBox(height: 20.h),

                SectionHeader(title: s.statistics),
                SizedBox(height: 12.h),
                StatisticsCards(statistics: state.statistics, s: s),
              ],
            ),
          ),
        ),

        // ✅ Only show celebration when screen is visible
        if (showCelebration)
          CelebrationOverlay(
            message: state.celebrationMessage!,
            progressPercent: state.celebrationProgress!,
            onDismiss: () {
              context.read<ProgressCubit>().dismissCelebration();
            },
          ),
      ],
    );
  }
}
