import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/get_it.dart';
import '../../../../core/helpers/snackbar_manager.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/models/trainee_request_model.dart';
import '../cubit/trainer_requests_cubit.dart';
import '../widgets/all_trainees_tab.dart';
import '../widgets/my_trainees_tab.dart';
import '../widgets/trainee_requests_tab.dart';

class TrainerRequestsScreen extends StatelessWidget {
  const TrainerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.get<TrainerRequestsCubit>()
        ..getSentRequests()
        ..getAllTrainees(),
      child: const TrainerRequestsScreenBody(),
    );
  }
}

class TrainerRequestsScreenBody extends StatefulWidget {
  const TrainerRequestsScreenBody({super.key});

  @override
  State<TrainerRequestsScreenBody> createState() =>
      TrainerRequestsScreenBodyState();
}

class TrainerRequestsScreenBodyState extends State<TrainerRequestsScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    searchController.clear();

    if (tabController.index == 2) {
      context.read<TrainerRequestsCubit>().getAllTrainees();
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorsManager.getScaffoldBackground(context),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorsManager.getPrimaryText(context),
            size: 20.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          s.trainee_requests,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.getPrimaryText(context),
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: Column(
            children: [
              TabBar(
                controller: tabController,
                labelColor: ColorsManager.getPrimaryGreen(context),
                unselectedLabelColor: ColorsManager.getSecondaryText(context),
                indicatorColor: ColorsManager.getPrimaryGreen(context),
                indicatorWeight: 3,
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                ),
                tabs: [
                  Tab(text: s.my_requests),
                  Tab(text: s.my_trainees),
                  Tab(text: s.all_trainees),
                ],
              ),
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      ColorsManager.getPrimaryGreen(
                        context,
                      ).withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          const TraineeRequestsTab(),
          const MyTraineesTab(),
          AllTraineesTab(searchController: searchController),
        ],
      ),
    );
  }
}
