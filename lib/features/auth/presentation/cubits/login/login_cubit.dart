// lib/features/auth/presentation/cubits/login/login_cubit.dart
import 'dart:developer' as dev;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../data/models/login_params.dart';
import '../../../data/models/login_response_model.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/repositories/auth_repository.dart';

part 'login_state.dart';

// lib/features/auth/presentation/cubits/login/login_cubit.dart

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final TokenManager _tokenManager = TokenManager.instance;

  LoginCubit(this._authRepository) : super(const LoginState()) {
    _loadRememberMePreference();
  }

  Future<void> _loadRememberMePreference() async {
    final rememberMe = await _tokenManager.getRememberMe();
    if (rememberMe) {
      final email = await _tokenManager.getSavedEmail();
      emit(state.copyWith(rememberMe: rememberMe, savedEmail: email));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleRememberMe() {
    final newValue = !state.rememberMe;
    emit(state.copyWith(rememberMe: newValue));
    _tokenManager.saveRememberMe(newValue);
    if (!newValue) {
      _tokenManager.clearSavedEmail();
    }
  }

  void setRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
    _tokenManager.saveRememberMe(value);
    if (!value) {
      _tokenManager.clearSavedEmail();
    }
  }

  Future<void> login({required String email, required String password}) async {
    dev.log('🚀 Starting login process', name: 'LoginCubit');

    emit(
      state.copyWith(
        isLoading: true,
        errorMessage: null,
        loginResponse: null,
        userProfile: null,
        needsProfileCompletion: false,
      ),
    );

    final params = LoginParams(email: email, password: password);

    // Save email if remember me is checked
    if (state.rememberMe) {
      await _tokenManager.saveEmail(email);
    }

    // Call login
    final loginResult = await _authRepository.login(params);

    // Use async fold pattern to prevent profile fetch on login failure
    final shouldFetchProfile = await loginResult.fold(
      (failure) async {
        // Login failed - emit error state and stop
        dev.log('❌ Login failed: ${failure.errorMessage}', name: 'LoginCubit');
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.errorMessage,
            loginResponse: null,
            userProfile: null,
            needsProfileCompletion: false,
          ),
        );
        return false; // Don't fetch profile
      },
      (loginResponse) async {
        // Login successful
        dev.log(
          '✅ Login successful, preparing to fetch profile...',
          name: 'LoginCubit',
        );

        // Update state with login response
        emit(state.copyWith(loginResponse: loginResponse, errorMessage: null));

        return true; // Fetch profile
      },
    );

    // Only fetch profile if login was successful
    if (shouldFetchProfile) {
      // Small delay to ensure token is saved
      await Future.delayed(const Duration(milliseconds: 100));
      await _fetchProfile();
    }
  }

  Future<void> _fetchProfile() async {
    dev.log('🚀 Fetching user profile', name: 'LoginCubit');

    final profileResult = await _authRepository.getProfile();

    profileResult.fold(
      (failure) {
        if (failure is ProfileNotFoundFailure) {
          dev.log(
            '⚠️ Profile not found - needs completion',
            name: 'LoginCubit',
          );
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: null,
              needsProfileCompletion: true,
            ),
          );
        } else {
          dev.log(
            '❌ Profile fetch failed: ${failure.errorMessage}',
            name: 'LoginCubit',
          );
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: failure.errorMessage,
            ),
          );
        }
      },
      (userProfile) {
        dev.log(
          '✅ Profile fetched successfully: ${userProfile.userName}',
          name: 'LoginCubit',
        );
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: null,
            userProfile: userProfile,
            needsProfileCompletion: false,
          ),
        );
      },
    );
  }

  void clearError() {
    emit(state.copyWith(errorMessage: null));
  }

  void reset() {
    emit(const LoginState());
  }
}
