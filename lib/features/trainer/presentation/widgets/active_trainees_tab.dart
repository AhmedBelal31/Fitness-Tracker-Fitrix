// lib/features/trainer/presentation/widgets/active_trainees_tab.dart
import 'package:fitrix/features/trainer/presentation/cubits/trainees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainee_data.dart';
import '../cubits/trainees_states.dart';

// lib/features/trainer/presentation/widgets/active_trainees_tab.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'trainee_card.dart'; // ADD THIS IMPORT

class ActiveTraineesTab extends StatelessWidget {
  const ActiveTraineesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TraineesCubit, TraineesState>(
      builder: (context, state) {
        if (state is TraineesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TraineesError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sp,
                  color: ColorsManager.error,
                ),
                SizedBox(height: 16.h),
                Text(
                  state.message,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                ),
              ],
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
                    S.of(context).no_clients_yet,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorsManager.getSecondaryText(context),
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await context.read<TraineesCubit>().loadTrainees();
            },
            color: ColorsManager.getPrimaryGreen(context),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: state.trainees.length,
              itemBuilder: (context, index) {
                final trainee = state.trainees[index];
                return TraineeCard(
                  trainee: trainee,
                  onTap: () => _navigateToTraineeDetails(context, trainee),
                  onRemove: () => _showRemoveDialog(context, trainee),
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  // In active_trainees_tab.dart
  void _navigateToTraineeDetails(BuildContext context, TraineeData trainee) {
    Navigator.pushNamed(
      context,
      Routes.traineeDetails,
      arguments: trainee, // Pass the entire TraineeData object
    );
  }

  void _showRemoveDialog(BuildContext context, trainee) {
    final s = S.of(context);
    final name = '${trainee.firstName} ${trainee.lastName}';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(s.remove_client),
        content: Text(
          'Are you sure you want to remove $name as a client?', // Simple string
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(s.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TraineesCubit>().removeTrainee(trainee.id);
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.error,
            ),
            child: Text(s.remove),
          ),
        ],
      ),
    );
  }
}
