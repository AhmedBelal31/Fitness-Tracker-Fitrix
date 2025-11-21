import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../data/trainer.dart';
import '../cubit/user_requests_cubit.dart';
import '../cubit/user_requests_state.dart';
import 'empty_state_widget.dart';
import 'my_trainer_card.dart';

class MyTrainersTab extends StatelessWidget {
  const MyTrainersTab({super.key});

  List<Trainer> _getMyTrainers(List<Trainer>? trainers) {
    if (trainers == null) return [];
    return trainers.where((trainer) => trainer.isInRelation).toList();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<UserRequestsCubit, UserRequestsState>(
      builder: (context, state) {
        if (state is UserRequestsData) {
          if (state.isTrainersLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  ColorsManager.getPrimaryGreen(context),
                ),
              ),
            );
          }

          final myTrainers = _getMyTrainers(state.trainers);

          if (myTrainers.isEmpty) {
            return Center(
              child: EmptyStateWidget(
                icon: Icons.fitness_center_rounded,
                title: s.no_my_trainers_found,
                subtitle: s.no_my_trainers_message,
              ),
            );
          }

          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorsManager.getPrimaryGreen(
                        context,
                      ).withOpacity(isDark ? 0.15 : 0.08),
                      ColorsManager.getSecondaryGreen(
                        context,
                      ).withOpacity(isDark ? 0.12 : 0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: ColorsManager.getPrimaryGreen(context),
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        s.my_trainers_count(myTrainers.length),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorsManager.getPrimaryText(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: myTrainers.length,
                  itemBuilder: (context, index) {
                    return MyTrainerCard(trainer: myTrainers[index]);
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
