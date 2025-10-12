import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repositories/auth_repository.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;
  ForgotPasswordCubit(this._authRepository)
    : super(const ForgotPasswordState());

  Future<void> submit(String email) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, isSuccess: false));
    final result = await _authRepository.forgotPassword(email);
    result.fold(
      (failure) => emit(
        state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
      ),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  void clear() => emit(const ForgotPasswordState());
}
