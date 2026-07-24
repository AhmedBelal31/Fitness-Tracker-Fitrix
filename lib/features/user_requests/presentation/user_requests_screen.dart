import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../core/di/get_it.dart';
import '../../../core/helpers/snackbar_manager.dart';
import '../data/trainer.dart';
import '../data/user_request.dart';
import 'cubit/user_requests_cubit.dart';
import 'cubit/user_requests_state.dart';
import 'widgets/user_requests_screen_body.dart';

class UserRequestsScreen extends StatelessWidget {
  const UserRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<UserRequestsCubit>()
        ..getReceivedRequests()
        ..getAllTrainers(),
      child: const UserRequestsScreenBody(),
    );
  }
}
