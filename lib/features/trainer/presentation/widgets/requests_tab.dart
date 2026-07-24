// lib/features/trainer/presentation/widgets/requests_tab.dart
import 'package:fitrix/features/trainer/presentation/widgets/request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../cubits/trainer_requests_cubit.dart';

class RequestsTab extends StatefulWidget {
  const RequestsTab({super.key});

  @override
  State<RequestsTab> createState() => _RequestsTabState();
}

class _RequestsTabState extends State<RequestsTab> {
  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load requests only once when the widget is first built
    if (!_isInitialized) {
      context.read<TrainerRequestsCubit>().loadReceivedRequests();
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainerRequestsCubit, TrainerRequestsState>(
      listener: (context, state) {
        if (state is RequestActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ColorsManager.success,
            ),
          );
          context.read<TrainerRequestsCubit>().loadReceivedRequests();
        }
      },
      builder: (context, state) {
        if (state is TrainerRequestsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TrainerRequestsError) {
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
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<TrainerRequestsCubit>().loadReceivedRequests();
                  },
                  child: Text(S.of(context).retry),
                ),
              ],
            ),
          );
        }

        if (state is ReceivedRequestsLoaded) {
          if (state.requests.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64.sp,
                    color: ColorsManager.getSecondaryText(context),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    S.of(context).no_pending_requests,
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
              await context.read<TrainerRequestsCubit>().loadReceivedRequests();
            },
            color: ColorsManager.getPrimaryGreen(context),
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: state.requests.length,
              itemBuilder: (context, index) {
                final request = state.requests[index];
                return RequestCard(
                  request: request,
                  onAccept: () {
                    context.read<TrainerRequestsCubit>().acceptRequest(
                      request.id,
                    );
                  },
                  onReject: () {
                    context.read<TrainerRequestsCubit>().rejectRequest(
                      request.id,
                    );
                  },
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
