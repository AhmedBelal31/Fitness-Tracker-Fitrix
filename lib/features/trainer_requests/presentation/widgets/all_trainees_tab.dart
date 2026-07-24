import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/helpers/snackbar_manager.dart';
import '../../../user_requests/presentation/widgets/empty_state_widget.dart';
import '../cubit/trainer_requests_cubit.dart';
import '../cubit/trainer_requests_state.dart';
import 'trainee_card.dart';

class AllTraineesTab extends StatefulWidget {
  final TextEditingController searchController;

  const AllTraineesTab({super.key, required this.searchController});

  @override
  State<AllTraineesTab> createState() => _AllTraineesTabState();
}

class _AllTraineesTabState extends State<AllTraineesTab> {
  @override
  void initState() {
    super.initState();
    widget.searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = widget.searchController.text.trim();
    context.read<TrainerRequestsCubit>().searchTrainees(query);
    setState(() {}); // Rebuild to show/hide clear button
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
              hintText: s.search_trainees,
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
                        context.read<TrainerRequestsCubit>().getAllTrainees();
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
          child: BlocConsumer<TrainerRequestsCubit, TrainerRequestsState>(
            // ✅ ADD LISTENER FOR ERRORS
            listener: (context, state) {
              if (state is TrainerRequestsData && state.error != null) {
                SnackBarManager.showError(context, state.error!);
              }
            },
            builder: (context, state) {
              if (state is TrainerRequestsData) {
                final isLoading = state.isTraineesLoading;

                if (isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        ColorsManager.getPrimaryGreen(context),
                      ),
                    ),
                  );
                }

                final trainees = state.trainees;

                if (trainees == null || trainees.isEmpty) {
                  return Center(
                    child: EmptyStateWidget(
                      icon: Icons.search_off_rounded,
                      title: s.no_trainees_found,
                      subtitle: s.no_trainees_message,
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: trainees.length,
                  itemBuilder: (context, index) {
                    return TraineeCard(trainee: trainees[index]);
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
