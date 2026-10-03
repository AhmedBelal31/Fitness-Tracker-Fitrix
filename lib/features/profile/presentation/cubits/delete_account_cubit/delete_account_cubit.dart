import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fitrix/core/networking/token_manager.dart';
import 'package:fitrix/core/services/hive_service.dart';
import 'package:fitrix/core/services/signalr_service.dart';
import 'package:fitrix/features/auth/domain/repositories/profile_repository/profile_repository.dart';
import 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  final ProfileRepository _profileRepository;

  DeleteAccountCubit(this._profileRepository) : super(DeleteAccountInitial());

  Future<void> deleteAccount() async {
    emit(DeleteAccountLoading());

    final result = await _profileRepository.deleteAccount();

    await result.fold(
      (failure) async {
        dev.log(
          '❌ Delete account failed: ${failure.errorMessage}',
          name: 'DeleteAccountCubit',
        );
        emit(DeleteAccountError(failure.errorMessage));
      },
      (_) async {
        dev.log('✅ Account successfully deleted', name: 'DeleteAccountCubit');
        try {
          await SignalRService.instance.disconnect();
          await HiveService().clearAll();
          await TokenManager.instance.clearAll();
        } catch (e) {
          dev.log(
            '⚠️ Error during post-deletion cleanup: $e',
            name: 'DeleteAccountCubit',
          );
        }
        emit(DeleteAccountSuccess());
      },
    );
  }
}
