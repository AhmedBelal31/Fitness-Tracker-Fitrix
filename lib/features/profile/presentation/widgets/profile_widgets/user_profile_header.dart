import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/styles.dart';
import '../../../../../generated/l10n.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    var profile = HiveService().getProfile();
    String firstName = profile?.firstName ?? 'F';
    String lastName = profile?.lastName ?? 'R';
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: ColorsManager.primaryGradient,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: ColorsManager.primaryShadow,
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100.w,
                height: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManager.whiteText, width: 4),
                  color: ColorsManager.whiteText,
                ),
                child: Center(
                  child: Text(
                    "${firstName.isNotEmpty ? firstName[0] : 'F'}.${lastName.isNotEmpty ? lastName[0] : 'R'}",
                    style: TextStyles.headline1.copyWith(
                      color: ColorsManager.primaryGreen,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   right: 0,
              //   child: Container(
              //     padding: EdgeInsets.all(8.w),
              //     decoration: const BoxDecoration(
              //       color: ColorsManager.whiteText,
              //       shape: BoxShape.circle,
              //     ),
              //     child: Icon(
              //       Icons.camera_alt,
              //       size: 20.sp,
              //       color: ColorsManager.primaryGreen,
              //     ),
              //   ),
              // ),
            ],
          ),
          SizedBox(height: 16.h),
          Text("${"$firstName $lastName"} ", style: TextStyles.font24WhiteBold),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.whiteText,
              foregroundColor: ColorsManager.primaryGreen,
            ),
            child: Text(s.edit_your_profile),
          ),
        ],
      ),
    );
  }
}
