import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../host/presentation/widgets/trainee_card.dart';
import '../../data/mock_data.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

// class TrainerHomeScreen extends StatelessWidget {
//   const TrainerHomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => di.get<HomeCubit>(),
//       child: TrainerHomeScreenBody(),
//     );
//   }
// }
//
// class TrainerHomeScreenBody extends StatefulWidget {
//   const TrainerHomeScreenBody({super.key});
//
//   @override
//   State<TrainerHomeScreenBody> createState() => _TrainerHomeScreenBodyState();
// }
//
// class _TrainerHomeScreenBodyState extends State<TrainerHomeScreenBody> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeCubit>().loadTrainees();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       body: SafeArea(
//         child: BlocBuilder<HomeCubit, HomeState>(
//           builder: (context, state) {
//             if (state is HomeLoading) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircularProgressIndicator(
//                       color: ColorsManager.primaryGreen,
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(s.loading, style: TextStyles.bodyMedium),
//                   ],
//                 ),
//               );
//             }
//
//             if (state is HomeError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.error_outline,
//                       size: 64.sp,
//                       color: ColorsManager.error,
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(state.message, style: TextStyles.bodyLarge),
//                     SizedBox(height: 16.h),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<HomeCubit>().loadTrainees();
//                       },
//                       child: Text(s.retry),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (state is TraineesLoaded) {
//               final trainees = state.trainees;
//               return RefreshIndicator(
//                 onRefresh: () async {
//                   context.read<HomeCubit>().loadTrainees();
//                 },
//                 color: ColorsManager.primaryGreen,
//                 child: SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   padding: EdgeInsets.all(20.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Header
//                       Text(s.welcome_trainer, style: TextStyles.bodyMedium),
//                       SizedBox(height: 4.h),
//                       Text(s.my_trainees, style: TextStyles.headline2),
//                       SizedBox(height: 24.h),
//
//                       // Quick Actions
//                       _buildQuickActions(context, s),
//                       SizedBox(height: 32.h),
//
//                       // Trainees List
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(s.active_trainees, style: TextStyles.subtitle1),
//                           TextButton(
//                             onPressed: () {
//                               // Navigate to all trainees screen
//                             },
//                             child: Text(
//                               s.view_all,
//                               style: TextStyles.font14PrimaryGreenSemiBold,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 16.h),
//
//                       if (trainees.isNotEmpty)
//                         ...trainees
//                             .map(
//                               (trainee) => Padding(
//                                 padding: EdgeInsets.only(bottom: 12.h),
//                                 child: TraineeCard(trainee: trainee),
//                               ),
//                             )
//                             .toList()
//                       else
//                         _buildEmptyState(s),
//                     ],
//                   ),
//                 ),
//               );
//             }
//
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         heroTag: 'add_trainee_fab', // Add unique tag
//         onPressed: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(s.add_trainee),
//               backgroundColor: ColorsManager.success,
//             ),
//           );
//         },
//         backgroundColor: ColorsManager.primaryGreen,
//         foregroundColor: ColorsManager.whiteText,
//         icon: const Icon(Icons.person_add),
//         label: Text(s.add_trainee, style: TextStyles.buttonMedium),
//       ),
//     );
//   }
//
//   Widget _buildQuickActions(BuildContext context, S s) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildActionCard(
//             context,
//             icon: Icons.group,
//             title: s.manage_trainees,
//             onTap: () {},
//           ),
//         ),
//         SizedBox(width: 12.w),
//         Expanded(
//           child: _buildActionCard(
//             context,
//             icon: Icons.calendar_today,
//             title: s.schedule_session,
//             onTap: () {},
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildActionCard(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16.r),
//       child: Container(
//         padding: EdgeInsets.all(16.w),
//         decoration: BoxDecoration(
//           color: ColorsManager.cardBackground,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: ColorsManager.cardShadow,
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.all(12.w),
//               decoration: BoxDecoration(
//                 gradient: ColorsManager.primaryGradient,
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: Icon(icon, color: ColorsManager.whiteText, size: 32.sp),
//             ),
//             SizedBox(height: 8.h),
//             Text(
//               title,
//               style: TextStyles.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(S s) {
//     return Container(
//       padding: EdgeInsets.all(32.w),
//       decoration: BoxDecoration(
//         color: ColorsManager.cardBackground,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: ColorsManager.softShadow,
//       ),
//       child: Center(
//         child: Column(
//           children: [
//             Icon(
//               Icons.people_outline,
//               size: 64.sp,
//               color: ColorsManager.lightText,
//             ),
//             SizedBox(height: 16.h),
//             Text(s.no_trainees_yet, style: TextStyles.headline3),
//             SizedBox(height: 8.h),
//             Text(
//               s.add_first_trainee,
//               style: TextStyles.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class TrainerHomeScreen extends StatelessWidget {
  const TrainerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Using mock data instead of Cubit
    final trainees = MockData.getMockTrainees();
    final s = S.of(context);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Simulate refresh delay
            await Future.delayed(const Duration(seconds: 1));
          },
          color: ColorsManager.primaryGreen,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(s.welcome_trainer, style: TextStyles.bodyMedium),
                SizedBox(height: 4.h),
                Text(s.my_trainees, style: TextStyles.headline2),
                SizedBox(height: 24.h),

                // Quick Actions
                _buildQuickActions(context, s),
                SizedBox(height: 32.h),

                // Trainees List
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(s.active_trainees, style: TextStyles.subtitle1),
                    TextButton(
                      onPressed: () {
                        // Navigate to all trainees screen
                      },
                      child: Text(
                        s.view_all,
                        style: TextStyles.font14PrimaryGreenSemiBold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                if (trainees.isNotEmpty)
                  ...trainees
                      .asMap()
                      .entries
                      .map(
                        (entry) => Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: TraineeCard(
                            trainee: entry.value,
                            index: entry.key, // Pass index for animation
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Opening ${entry.value.fullName} profile',
                                  ),
                                  backgroundColor: ColorsManager.success,
                                ),
                              );
                            },
                          ),
                        ),
                      )
                      .toList()
                else
                  _buildEmptyState(s),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_trainee_fab',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.add_trainee),
              backgroundColor: ColorsManager.success,
            ),
          );
        },
        backgroundColor: ColorsManager.primaryGreen,
        foregroundColor: ColorsManager.whiteText,
        icon: const Icon(Icons.person_add),
        label: Text(s.add_trainee, style: TextStyles.buttonMedium),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, S s) {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.group,
            title: s.manage_trainees,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.manage_trainees),
                  backgroundColor: ColorsManager.info,
                ),
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionCard(
            context,
            icon: Icons.calendar_today,
            title: s.schedule_session,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(s.schedule_session),
                  backgroundColor: ColorsManager.info,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: ColorsManager.cardShadow,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                gradient: ColorsManager.primaryGradient,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: ColorsManager.whiteText, size: 32.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(S s) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 64.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 16.h),
            Text(s.no_trainees_yet, style: TextStyles.headline3),
            SizedBox(height: 8.h),
            Text(
              s.add_first_trainee,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
