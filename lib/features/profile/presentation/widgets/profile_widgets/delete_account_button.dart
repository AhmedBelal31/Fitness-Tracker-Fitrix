import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitrix/core/di/get_it.dart';
import 'package:fitrix/core/theming/app_colors.dart';
import 'package:fitrix/generated/l10n.dart';
import '../../cubits/delete_account_cubit/delete_account_cubit.dart';
import 'delete_account_confirmation_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: () => _showDeleteConfirmation(context),
        icon: Icon(
          Icons.delete_outline_rounded,
          color: ColorsManager.error,
          size: 20.sp,
        ),
        label: Text(
          s.delete_account,
          style: TextStyle(
            color: ColorsManager.error,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return BlocProvider(
          create: (_) => di<DeleteAccountCubit>(),
          child: const DeleteAccountConfirmationDialog(),
        );
      },
    );
  }
}
