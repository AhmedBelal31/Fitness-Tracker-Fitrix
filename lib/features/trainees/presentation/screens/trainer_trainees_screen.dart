import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/styles.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/mock_data.dart';
import '../../../host/presentation/widgets/trainee_card.dart';

class TrainerTraineesScreen extends StatefulWidget {
  const TrainerTraineesScreen({super.key});

  @override
  State<TrainerTraineesScreen> createState() => _TrainerTraineesScreenState();
}

class _TrainerTraineesScreenState extends State<TrainerTraineesScreen> {
  String _searchQuery = '';
  String _filterStatus = 'all'; // all, active, inactive

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    final trainees = MockData.getMockTrainees();

    // Filter trainees based on search and status
    final filteredTrainees = trainees.where((trainee) {
      final matchesSearch = trainee.fullName.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: ColorsManager.scaffoldBackground,
      appBar: AppBar(
        title: Text(s.trainees, style: TextStyles.headline2),
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: ColorsManager.primaryGreen),
            onPressed: () => _showSearchSheet(context),
          ),
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: ColorsManager.primaryGreen,
            ),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        color: ColorsManager.primaryGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stats Summary
              _buildStatsSummary(s, trainees.length),
              SizedBox(height: 24.h),

              // Trainees List
              Text(
                '${filteredTrainees.length} ${s.trainees}',
                style: TextStyles.subtitle1,
              ),
              SizedBox(height: 16.h),

              if (filteredTrainees.isNotEmpty)
                ...filteredTrainees
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: TraineeCard(
                          trainee: entry.value,
                          index: entry.key,
                          onTap: () {
                            _showTraineeDetails(context, entry.value);
                          },
                        ),
                      ),
                    )
                    .toList()
              else
                _buildEmptyState(s),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'add_trainee_list_fab',
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.add_trainee),
              backgroundColor: ColorsManager.success,
            ),
          );
        },
        backgroundColor: ColorsManager.primaryGreen,
        foregroundColor: ColorsManager.whiteText,
        icon: const Icon(Icons.person_add),
        label: Text(s.add_trainee, style: TextStyles.buttonMedium),
      ),
    );
  }

  Widget _buildStatsSummary(S s, int totalCount) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.people,
            value: totalCount.toString(),
            label: s.active_trainees,
            color: ColorsManager.info,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            icon: Icons.fitness_center,
            value: '156',
            label: s.total_workouts,
            color: ColorsManager.success,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            icon: Icons.calendar_today,
            value: '12',
            label: 'This Week',
            color: ColorsManager.warning,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.cardShadow,
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28.sp),
          SizedBox(height: 8.h),
          Text(value, style: TextStyles.font20PrimaryTextSemiBold),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyles.caption,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(S s) {
    return Container(
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: ColorsManager.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: ColorsManager.softShadow,
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.people_outline,
              size: 64.sp,
              color: ColorsManager.lightText,
            ),
            SizedBox(height: 16.h),
            Text(s.no_trainees_yet, style: TextStyles.headline3),
            SizedBox(height: 8.h),
            Text(
              s.add_first_trainee,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search trainees...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showFilterSheet(BuildContext context) {
    final s = S.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(s.filter, style: TextStyles.headline3),
              SizedBox(height: 20.h),
              ListTile(
                leading: const Icon(
                  Icons.all_inclusive,
                  color: ColorsManager.primaryGreen,
                ),
                title: Text(s.all),
                onTap: () {
                  setState(() {
                    _filterStatus = 'all';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.check_circle,
                  color: ColorsManager.success,
                ),
                title: const Text('Active'),
                onTap: () {
                  setState(() {
                    _filterStatus = 'active';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.pause_circle,
                  color: ColorsManager.lightText,
                ),
                title: const Text('Inactive'),
                onTap: () {
                  setState(() {
                    _filterStatus = 'inactive';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTraineeDetails(BuildContext context, trainee) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorsManager.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        final s = S.of(context);
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40.r,
                backgroundColor: ColorsManager.primaryGreen,
                child: Text(
                  trainee.fullName[0].toUpperCase(),
                  style: TextStyles.headline1.copyWith(
                    color: ColorsManager.whiteText,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(trainee.fullName, style: TextStyles.headline2),
              SizedBox(height: 8.h),
              Text(trainee.email ?? 'No email', style: TextStyles.bodyMedium),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.fitness_center),
                    label: Text(s.workouts),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.trending_up),
                    label: Text(s.progress),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
