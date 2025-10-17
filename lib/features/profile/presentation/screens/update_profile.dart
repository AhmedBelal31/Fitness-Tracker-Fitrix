import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitrix/core/di/get_it.dart';
import '../cubits/update_profile_cubit/update_profile_cubit.dart';
import '../cubits/update_profile_cubit/update_profile_state.dart';
import '../widgets/update_profile_widgets/update_profile_listener.dart';
import '../widgets/update_profile_widgets/update_profile_screen_body.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<UpdateProfileCubit>(),
      child: BlocListener<UpdateProfileCubit, UpdateProfileState>(
        listener: UpdateProfileListener.handleStateChange,
        child: const UpdateProfileScreenBody(),
      ),
    );
  }
}
