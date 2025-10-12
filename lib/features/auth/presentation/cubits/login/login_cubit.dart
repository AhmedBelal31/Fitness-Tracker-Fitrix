import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../../../core/services/hive_service.dart';
import '../../../data/models/params/login_params.dart';
import '../../../data/models/login_profile_model.dart';
import '../../../data/models/login_response_model.dart';
import '../../../domain/repositories/auth_repositories/auth_repository.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final TokenManager _tokenManager = TokenManager.instance;
  final HiveService _hiveService = HiveService();

  LoginCubit(this._authRepository) : super(const LoginState()) {
    _loadSavedPreferences();
  }

  Future<void> initialize() async {
    await _loadSavedPreferences();
  }

  Future<void> _loadSavedPreferences() async {
    final email = await _tokenManager.getSavedEmail();

    // 👇 Always start with Remember Me = true (default)
    emit(
      state.copyWith(
        rememberMe: true, // Always default to checked
        savedEmail: email,
      ),
    );

    dev.log(
      '💾 Remember Me defaulted to true, Email loaded: ${email ?? "none"}',
      name: 'LoginCubit',
    );
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  // 👇 UPDATED: Toggle only affects current session, not saved permanently
  void toggleRememberMe() {
    final newValue = !state.rememberMe;
    emit(state.copyWith(rememberMe: newValue));

    // 👇 DO NOT save to SharedPreferences - only session change
    dev.log(
      '🔄 Remember Me toggled to: $newValue (session only)',
      name: 'LoginCubit',
    );

    // Clear saved email immediately if unchecked
    if (!newValue) {
      _tokenManager.clearSavedEmail();
      emit(state.copyWith(savedEmail: null));
    }
  }

  void setRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
    if (!value) {
      _tokenManager.clearSavedEmail();
      emit(state.copyWith(savedEmail: null));
    }
  }

  /// 🚀 Login logic

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

    // 👇 UPDATED: Mark session based on Remember Me state
    if (state.rememberMe) {
      await _tokenManager.saveEmail(email);
      await _tokenManager.markSessionAsRemembered(); // 👈 Save session flag
      dev.log('💾 Session will persist on app restart', name: 'LoginCubit');
    } else {
      await _tokenManager.clearSavedEmail();
      await _tokenManager.markSessionAsTemporary(); // 👈 Mark as temporary
      dev.log(
        '⏳ Session is temporary - will logout on app restart',
        name: 'LoginCubit',
      );
    }

    final result = await _authRepository.login(params);

    result.fold(
      (failure) {
        dev.log('❌ Login failed: ${failure.errorMessage}', name: 'LoginCubit');
        emit(
          state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
        );
      },
      (loginResponse) async {
        final userProfile = loginResponse.profile;

        if (userProfile == null) {
          dev.log(
            '⚠️ No profile found - user needs to complete profile',
            name: 'LoginCubit',
          );

          final role = loginResponse.token.user.roles.contains('Trainer')
              ? 2
              : 1;
          await _tokenManager.saveUserRole(role);

          dev.log('💾 User role cached from JWT: $role', name: 'LoginCubit');

          emit(
            state.copyWith(
              isLoading: false,
              loginResponse: loginResponse,
              userProfile: null,
              needsProfileCompletion: true,
            ),
          );
          return;
        }

        dev.log('✅ Login successful, got profile data.', name: 'LoginCubit');

        await _hiveService.saveProfile(userProfile);

        if (userProfile.role != null) {
          await _tokenManager.saveUserRole(userProfile.role!);
          dev.log(
            '💾 User role cached: ${userProfile.roleString} (${userProfile.role})',
            name: 'LoginCubit',
          );
        }

        final needsCompletion =
            userProfile.firstName == null ||
            userProfile.lastName == null ||
            userProfile.gender == null;

        if (needsCompletion) {
          dev.log(
            '⚠️ Profile incomplete, needs completion.',
            name: 'LoginCubit',
          );
        } else {
          dev.log('✅ Profile complete, proceeding.', name: 'LoginCubit');
        }

        emit(
          state.copyWith(
            isLoading: false,
            loginResponse: loginResponse,
            userProfile: userProfile,
            needsProfileCompletion: needsCompletion,
          ),
        );
      },
    );
  }

  void loadLocalProfile() {
    final profile = _hiveService.getProfile();
    if (profile != null) {
      final needsCompletion =
          profile.firstName == null ||
          profile.lastName == null ||
          profile.gender == null;

      emit(
        state.copyWith(
          userProfile: profile,
          needsProfileCompletion: needsCompletion,
          isLoading: false,
        ),
      );
      dev.log(
        '📦 Loaded profile from Hive: ${profile.firstName}',
        name: 'LoginCubit',
      );
    }
  }

  Future<void> logout() async {
    dev.log('🚪 Logging out user', name: 'LoginCubit');

    // Always clear profile from Hive
    await _hiveService.clearProfile();

    // Clear tokens
    await _tokenManager.clearTokens();

    // 👇 DO NOT clear email - keep it for next session if it was saved
    dev.log('💾 Email preserved for next session', name: 'LoginCubit');

    // Reset state (remember me will default back to true on next login screen)
    emit(const LoginState());
  }

  void clearError() => emit(state.copyWith(errorMessage: null));

  void reset() => emit(const LoginState());
}
