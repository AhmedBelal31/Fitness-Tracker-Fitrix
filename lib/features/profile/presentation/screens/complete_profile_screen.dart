import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../cubits/profile_cubit/complete_profile_cubit.dart';
import '../widgets/complete_profile_widgets/complete_profile_screen_body.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<CompleteProfileCubit>(),
      child: CompleteProfileScreenBody(),
    );
  }
}
