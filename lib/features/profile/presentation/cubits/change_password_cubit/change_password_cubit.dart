import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../../auth/data/models/params/reset_password_request_params.dart';
import '../../../../auth/domain/repositories/profile_repository/profile_repository.dart';
import 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ProfileRepository _profileRepository;

  ChangePasswordCubit(this._profileRepository) : super(ChangePasswordInitial());

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());

    // ✅ Create request model
    final request = ChangePasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    // ✅ Pass model to repository
    final result = await _profileRepository.changePassword(request);

    result.fold(
      (failure) => emit(ChangePasswordError(failure.errorMessage)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
}
