// lib/features/trainer/presentation/widgets/client_workouts_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/routing/routes.dart';
import '../cubits/trainees_cubit.dart';
import '../cubits/trainees_states.dart';
import 'client_workout_card.dart';

class ClientWorkoutsTab extends StatelessWidget {
  const ClientWorkoutsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    S.of(context).select_client_to_create_workout,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.getPrimaryText(context),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Client List
          Expanded(
            child: BlocBuilder<TraineesCubit, TraineesState>(
              builder: (context, state) {
                if (state is TraineesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is TraineesError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(
                        color: ColorsManager.error,
                        fontSize: 14.sp,
                      ),
                    ),
                  );
                }

                if (state is TraineesLoaded) {
                  if (state.trainees.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64.sp,
                            color: ColorsManager.getSecondaryText(context),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            S.of(context).no_clients_to_create_workout,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: ColorsManager.getSecondaryText(context),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                Routes.trainerClients,
                              );
                            },
                            icon: const Icon(Icons.person_add),
                            label: Text(S.of(context).add_client),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.getPrimaryGreen(
                                context,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: state.trainees.length,
                    itemBuilder: (context, index) {
                      final trainee = state.trainees[index];
                      return ClientWorkoutCard(
                        trainee: trainee,
                        onCreateWorkout: () {
                          Navigator.pushNamed(
                            context,
                            Routes.createWorkoutForClient,
                            arguments: trainee,
                          );
                        },
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
