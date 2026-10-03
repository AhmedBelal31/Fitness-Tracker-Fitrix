import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/routing/routes.dart';
import 'package:fitrix/core/theming/app_colors.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../cubits/delete_account_cubit/delete_account_cubit.dart';
import '../../cubits/delete_account_cubit/delete_account_state.dart';

class DeleteAccountConfirmationDialog extends StatelessWidget {
  const DeleteAccountConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil(Routes.loginScreen, (route) => false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(s.delete_account_success),
              backgroundColor: ColorsManager.success,
            ),
          );
        } else if (state is DeleteAccountError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ColorsManager.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is DeleteAccountLoading;

        return AlertDialog(
          backgroundColor: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: ColorsManager.error,
                size: 26.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  s.delete_account,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.getPrimaryText(context),
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            s.delete_account_confirm_message,
            style: TextStyle(
              fontSize: 14.sp,
              height: 1.4,
              color: ColorsManager.getSecondaryText(context),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isLoading
                  ? null
                  : () => Navigator.of(context, rootNavigator: true).pop(),
              child: Text(
                s.cancel,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: ColorsManager.getSecondaryText(context),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () => context.read<DeleteAccountCubit>().deleteAccount(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.error,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      s.delete_account,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
