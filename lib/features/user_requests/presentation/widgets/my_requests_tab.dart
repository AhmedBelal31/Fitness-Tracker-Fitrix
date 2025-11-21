import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/helpers/snackbar_manager.dart';
import '../cubit/user_requests_cubit.dart';
import '../cubit/user_requests_state.dart';
import 'empty_state_widget.dart';
import 'request_card.dart';

class MyRequestsTab extends StatelessWidget {
  const MyRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocConsumer<UserRequestsCubit, UserRequestsState>(
      listener: (context, state) {
        if (state is UserRequestsData && state.error != null) {
          SnackBarManager.showError(context, state.error!);
        }
      },
      builder: (context, state) {
        if (state is UserRequestsData) {
          if (state.isRequestsLoading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                  ColorsManager.getPrimaryGreen(context),
                ),
              ),
            );
          }

          if (state.requests == null || state.requests!.isEmpty) {
            return Center(
              child: EmptyStateWidget(
                icon: Icons.people_outline_rounded,
                title: s.no_requests_found,
                subtitle: s.no_trainer_requests_message,
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
                        s.pending_requests_count(state.requests!.length),
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
                  itemCount: state.requests!.length,
                  itemBuilder: (context, index) {
                    return RequestCard(request: state.requests![index]);
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
