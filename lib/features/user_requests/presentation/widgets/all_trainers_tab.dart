import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../cubit/user_requests_cubit.dart';
import '../cubit/user_requests_state.dart';
import 'empty_state_widget.dart';
import 'trainer_card.dart';

// class AllTrainersTab extends StatefulWidget {
//   final TextEditingController searchController;
//
//   const AllTrainersTab({super.key, required this.searchController});
//
//   @override
//   State<AllTrainersTab> createState() => _AllTrainersTabState();
// }
//
// class _AllTrainersTabState extends State<AllTrainersTab> {
//   @override
//   Widget build(BuildContext context) {
//     final s = S.of(context);
//
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(20.w),
//           child: TextField(
//             controller: widget.searchController,
//             style: TextStyle(color: ColorsManager.getPrimaryText(context)),
//             decoration: InputDecoration(
//               hintText: s.search_trainers,
//               hintStyle: TextStyle(
//                 color: ColorsManager.getSecondaryText(context),
//               ),
//               fillColor: ColorsManager.getCardBackground(context),
//               filled: true,
//               prefixIcon: Icon(
//                 Icons.search_rounded,
//                 color: ColorsManager.getPrimaryGreen(context),
//               ),
//               suffixIcon: widget.searchController.text.isNotEmpty
//                   ? IconButton(
//                       icon: Icon(
//                         Icons.clear,
//                         color: ColorsManager.getSecondaryText(context),
//                       ),
//                       onPressed: () {
//                         widget.searchController.clear();
//                         context.read<UserRequestsCubit>().getAllTrainers();
//                         setState(() {}); // Force rebuild to hide clear button
//                       },
//                     )
//                   : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide.none,
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//                 borderSide: BorderSide(
//                   color: ColorsManager.getPrimaryGreen(context),
//                   width: 2,
//                 ),
//               ),
//             ),
//             onChanged: (value) {
//               setState(() {}); // Rebuild to show/hide clear button
//             },
//           ),
//         ),
//         Expanded(
//           child: BlocBuilder<UserRequestsCubit, UserRequestsState>(
//             builder: (context, state) {
//               if (state is UserRequestsData) {
//                 final isLoading = state.isTrainersLoading;
//
//                 if (isLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation(
//                         ColorsManager.getPrimaryGreen(context),
//                       ),
//                     ),
//                   );
//                 }
//
//                 final trainers = state.trainers;
//
//                 if (trainers == null || trainers.isEmpty) {
//                   return Center(
//                     child: EmptyStateWidget(
//                       icon: Icons.search_off_rounded,
//                       title: s.no_trainers_found,
//                       subtitle: s.no_trainers_message,
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   itemCount: trainers.length,
//                   itemBuilder: (context, index) {
//                     return TrainerCard(trainer: trainers[index]);
//                   },
//                 );
//               }
//
//               return const SizedBox();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/helpers/snackbar_manager.dart';
import '../cubit/user_requests_cubit.dart';
import '../cubit/user_requests_state.dart';
import 'empty_state_widget.dart';
import 'trainer_card.dart';

class AllTrainersTab extends StatefulWidget {
  final TextEditingController searchController;

  const AllTrainersTab({super.key, required this.searchController});

  @override
  State<AllTrainersTab> createState() => _AllTrainersTabState();
}

class _AllTrainersTabState extends State<AllTrainersTab> {
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = widget.searchController.text.trim();
    context.read<UserRequestsCubit>().searchTrainers(query);
    setState(() {});
  }

  @override
  void dispose() {
    widget.searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20.w),
          child: TextField(
            controller: widget.searchController,
            style: TextStyle(color: ColorsManager.getPrimaryText(context)),
            decoration: InputDecoration(
              hintText: s.search_trainers,
              hintStyle: TextStyle(
                color: ColorsManager.getSecondaryText(context),
              ),
              fillColor: ColorsManager.getCardBackground(context),
              filled: true,
              prefixIcon: Icon(
                Icons.search_rounded,
                color: ColorsManager.getPrimaryGreen(context),
              ),
              suffixIcon: widget.searchController.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: ColorsManager.getSecondaryText(context),
                      ),
                      onPressed: () {
                        widget.searchController.clear();
                        context.read<UserRequestsCubit>().getAllTrainers();
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: ColorsManager.getPrimaryGreen(context),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocConsumer<UserRequestsCubit, UserRequestsState>(
            // ✅ ADD LISTENER FOR ERRORS
            listener: (context, state) {
              if (state is UserRequestsData && state.error != null) {
                SnackBarManager.showError(context, state.error!);
              }
            },
            builder: (context, state) {
              if (state is UserRequestsData) {
                final isLoading = state.isTrainersLoading;

                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        ColorsManager.getPrimaryGreen(context),
                      ),
                    ),
                  );
                }

                final trainers = state.trainers;

                if (trainers == null || trainers.isEmpty) {
                  return Center(
                    child: EmptyStateWidget(
                      icon: Icons.search_off_rounded,
                      title: s.no_trainers_found,
                      subtitle: s.no_trainers_message,
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: trainers.length,
                  itemBuilder: (context, index) {
                    return TrainerCard(trainer: trainers[index]);
                  },
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
