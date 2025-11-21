import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../user_requests/presentation/widgets/empty_state_widget.dart';
import '../../data/models/trainee_request_model.dart';
import '../cubit/trainer_requests_cubit.dart';
import '../cubit/trainer_requests_state.dart';
import 'my_trainee_card.dart';

class MyTraineesTab extends StatelessWidget {
  const MyTraineesTab({super.key});

  List<Trainee> _getMyTrainees(List<Trainee>? trainees) {
    if (trainees == null) return [];
    return trainees.where((trainee) => trainee.isInRelation).toList();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<TrainerRequestsCubit, TrainerRequestsState>(
      builder: (context, state) {
        if (state is TrainerRequestsData) {
          if (state.isTraineesLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  ColorsManager.getPrimaryGreen(context),
                ),
              ),
            );
          }

          final myTrainees = _getMyTrainees(state.trainees);

          if (myTrainees.isEmpty) {
            return Center(
              child: EmptyStateWidget(
                icon: Icons.people_rounded,
                title: s.no_my_trainees_found,
                subtitle: s.no_my_trainees_message,
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
                      ).withValues(alpha: isDark ? 0.15 : 0.08),
                      ColorsManager.getSecondaryGreen(
                        context,
                      ).withValues(alpha: isDark ? 0.12 : 0.06),
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
                        s.my_trainees_count(myTrainees.length),
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
                  itemCount: myTrainees.length,
                  itemBuilder: (context, index) {
                    return MyTraineeCard(trainee: myTrainees[index]);
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
