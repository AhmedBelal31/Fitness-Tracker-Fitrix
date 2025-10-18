import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/theming/styles.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../../../core/theming/app_colors.dart';
import '../cubit/progress_cubit.dart';

class ProgressErrorState extends StatelessWidget {
  final String message;

  const ProgressErrorState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64.sp, color: ColorsManager.error),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              message,
              style: TextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => context.read<ProgressCubit>().loadProgress(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryGreen,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
            ),
            child: Text(s.retry, style: TextStyles.font16WhiteSemiBold),
          ),
        ],
      ),
    );
  }
}
