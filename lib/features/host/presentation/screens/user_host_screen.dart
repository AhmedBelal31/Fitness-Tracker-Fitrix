import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/get_it.dart';
import '../cubits/host_cubit.dart';

import '../widgets/user_host_screen_body.dart';

class UserHostScreen extends StatelessWidget {
  const UserHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => di.get<HostCubit>())],
      child: const UserHostScreenBody(),
    );
  }
}
