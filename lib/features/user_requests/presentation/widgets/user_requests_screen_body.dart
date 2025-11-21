import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../cubit/user_requests_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'all_trainers_tab.dart';
import 'my_requests_tab.dart';
import 'my_trainers_tab.dart';

class UserRequestsScreenBody extends StatefulWidget {
  const UserRequestsScreenBody({super.key});

  @override
  State<UserRequestsScreenBody> createState() => UserRequestsScreenBodyState();
}

class UserRequestsScreenBodyState extends State<UserRequestsScreenBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    searchController.addListener(_onSearchChanged);
    tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    searchController.clear();

    if (tabController.index == 2) {
      // All Trainers tab - reload trainers
      context.read<UserRequestsCubit>().getAllTrainers();
    }
  }

  void _onSearchChanged() {
    final query = searchController.text.trim();

    // Only apply search on "All Trainers" tab (index 2)
    if (tabController.index == 2) {
      context.read<UserRequestsCubit>().searchTrainers(query);
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
          s.trainer_requests,
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
                  Tab(text: s.my_trainers),
                  Tab(text: s.all_trainers),
                ],
              ),
              Container(
                height: 1.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      ColorsManager.getPrimaryGreen(context).withOpacity(0.2),
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
          const MyRequestsTab(),
          const MyTrainersTab(),
          AllTrainersTab(searchController: searchController),
        ],
      ),
    );
  }
}
