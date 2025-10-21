import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/progress_cubit.dart';
import '../cubit/progress_state.dart';

import '../widgets/progress_app_bar.dart';
import '../widgets/progress_loading_state.dart';
import '../widgets/progress_error_state.dart';
import '../widgets/progress_loaded_content.dart';

// class UserProgressScreen extends StatelessWidget {
//   const UserProgressScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => di<ProgressCubit>()..loadProgress(),
//       child: const _UserProgressView(),
//     );
//   }
// }
//
// class _UserProgressView extends StatelessWidget {
//   const _UserProgressView();
//
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Scaffold(
//       backgroundColor: ColorsManager.scaffoldBackground,
//       appBar: ProgressAppBar(title: s.my_progress),
//       body: BlocBuilder<ProgressCubit, ProgressState>(
//         builder: (context, state) {
//           if (state is ProgressLoading) {
//             return const ProgressLoadingState();
//           }
//
//           if (state is ProgressError) {
//             return ProgressErrorState(message: state.message);
//           }
//
//           if (state is ProgressLoaded) {
//             return ProgressLoadedContent(state: state);
//           }
//
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }

class UserProgressScreen extends StatelessWidget {
  final bool Function()? isVisible;

  const UserProgressScreen({super.key, this.isVisible});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di<ProgressCubit>()..loadProgress(),
      child: _UserProgressView(isVisible: isVisible),
    );
  }
}

class _UserProgressView extends StatelessWidget {
  final bool Function()? isVisible;

  const _UserProgressView({this.isVisible});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: ProgressAppBar(title: s.my_progress),
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (state is ProgressLoading) {
            return const ProgressLoadingState();
          }

          if (state is ProgressError) {
            return ProgressErrorState(message: state.message);
          }

          if (state is ProgressLoaded) {
            return ProgressLoadedContent(state: state, isVisible: isVisible);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
