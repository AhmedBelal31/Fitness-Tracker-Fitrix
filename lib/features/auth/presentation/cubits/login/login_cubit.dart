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

// class LoginCubit extends Cubit<LoginState> {
//   final AuthRepository _authRepository;
//   final TokenManager _tokenManager = TokenManager.instance;
//   final HiveService _hiveService = HiveService();
//
//   LoginCubit(this._authRepository) : super(const LoginState()) {
//     _loadSavedPreferences();
//   }
//
//   Future<void> initialize() async {
//     await _loadSavedPreferences();
//   }
//
//   // 👇 Load saved preferences (email and remember me status)
//   Future<void> _loadSavedPreferences() async {
//     final savedRememberMe = await _tokenManager.getRememberMe();
//
//     dev.log(
//       '🔍 Checking saved Remember Me: $savedRememberMe',
//       name: 'LoginCubit',
//     );
//
//     if (savedRememberMe != null) {
//       // User has a saved preference
//       emit(state.copyWith(rememberMe: savedRememberMe));
//       dev.log('💾 Remember Me loaded: $savedRememberMe', name: 'LoginCubit');
//
//       if (savedRememberMe) {
//         final email = await _tokenManager.getSavedEmail();
//         if (email != null) {
//           emit(state.copyWith(savedEmail: email));
//           dev.log('💾 Saved email loaded: $email', name: 'LoginCubit');
//         }
//       }
//     } else {
//       // No saved preference - use default (true) and EMIT
//       await _tokenManager.saveRememberMe(true);
//       emit(state.copyWith(rememberMe: true));
//       dev.log('💾 Remember Me defaulted to true', name: 'LoginCubit');
//     }
//   }
//
//   void togglePasswordVisibility() {
//     emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
//   }
//
//   void toggleRememberMe() {
//     final newValue = !state.rememberMe;
//     emit(state.copyWith(rememberMe: newValue));
//     _tokenManager.saveRememberMe(newValue);
//
//     dev.log('🔄 Remember Me toggled to: $newValue', name: 'LoginCubit');
//
//     // Clear email if user unchecks remember me
//     if (!newValue) {
//       _tokenManager.clearSavedEmail();
//       emit(state.copyWith(savedEmail: null));
//     }
//   }
//
//   void setRememberMe(bool value) {
//     emit(state.copyWith(rememberMe: value));
//     _tokenManager.saveRememberMe(value);
//     if (!value) {
//       _tokenManager.clearSavedEmail();
//       emit(state.copyWith(savedEmail: null));
//     }
//   }
//
//   /// 🚀 Login logic
//   /// 🚀 Login logic
//   Future<void> login({required String email, required String password}) async {
//     dev.log('🚀 Starting login process', name: 'LoginCubit');
//
//     emit(
//       state.copyWith(
//         isLoading: true,
//         errorMessage: null,
//         loginResponse: null,
//         userProfile: null,
//         needsProfileCompletion: false,
//       ),
//     );
//
//     final params = LoginParams(email: email, password: password);
//
//     // Save email and remember me preference
//     if (state.rememberMe) {
//       await _tokenManager.saveEmail(email);
//       await _tokenManager.saveRememberMe(true);
//       dev.log(
//         '💾 Saving credentials (Remember Me enabled)',
//         name: 'LoginCubit',
//       );
//     } else {
//       await _tokenManager.clearSavedEmail();
//       await _tokenManager.saveRememberMe(false);
//       dev.log(
//         '🗑️ Not saving credentials (Remember Me disabled)',
//         name: 'LoginCubit',
//       );
//     }
//
//     final result = await _authRepository.login(params);
//
//     result.fold(
//       (failure) {
//         dev.log('❌ Login failed: ${failure.errorMessage}', name: 'LoginCubit');
//         emit(
//           state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
//         );
//       },
//       (loginResponse) async {
//         final userProfile = loginResponse.profile;
//
//         // 👇 Check if profile exists
//         if (userProfile == null) {
//           dev.log(
//             '⚠️ No profile found - user needs to complete profile',
//             name: 'LoginCubit',
//           );
//
//           // Get role from JWT token user data
//           final role = loginResponse.token.user.roles.contains('Trainer')
//               ? 2
//               : 1;
//
//           // Cache role for later use
//           await _tokenManager.saveUserRole(role);
//
//           dev.log('💾 User role cached from JWT: $role', name: 'LoginCubit');
//
//           emit(
//             state.copyWith(
//               isLoading: false,
//               loginResponse: loginResponse,
//               userProfile: null,
//               needsProfileCompletion: true,
//             ),
//           );
//           return;
//         }
//
//         dev.log('✅ Login successful, got profile data.', name: 'LoginCubit');
//
//         // Save profile to Hive
//         await _hiveService.saveProfile(userProfile);
//
//         // Cache user role
//         if (userProfile.role != null) {
//           await _tokenManager.saveUserRole(userProfile.role!);
//           dev.log(
//             '💾 User role cached: ${userProfile.roleString} (${userProfile.role})',
//             name: 'LoginCubit',
//           );
//         }
//
//         // Check if profile needs completion
//         final needsCompletion =
//             userProfile.firstName == null ||
//             userProfile.lastName == null ||
//             userProfile.gender == null;
//
//         if (needsCompletion) {
//           dev.log(
//             '⚠️ Profile incomplete, needs completion.',
//             name: 'LoginCubit',
//           );
//         } else {
//           dev.log('✅ Profile complete, proceeding.', name: 'LoginCubit');
//         }
//
//         emit(
//           state.copyWith(
//             isLoading: false,
//             loginResponse: loginResponse,
//             userProfile: userProfile,
//             needsProfileCompletion: needsCompletion,
//           ),
//         );
//       },
//     );
//   }
//
//   /// 📦 Load profile from Hive on app start
//   void loadLocalProfile() {
//     final profile = _hiveService.getProfile();
//     if (profile != null) {
//       final needsCompletion =
//           profile.firstName == null ||
//           profile.lastName == null ||
//           profile.gender == null;
//
//       emit(
//         state.copyWith(
//           userProfile: profile,
//           needsProfileCompletion: needsCompletion,
//           isLoading: false,
//         ),
//       );
//       dev.log(
//         '📦 Loaded profile from Hive: ${profile.firstName}',
//         name: 'LoginCubit',
//       );
//     }
//   }
//
//   Future<void> logout() async {
//     dev.log('🚪 Logging out user', name: 'LoginCubit');
//
//     // Check if remember me is enabled
//     final rememberMe = await _tokenManager.getRememberMe();
//
//     if (rememberMe == true) {
//       // Keep tokens and email if remember me is checked
//       dev.log(
//         '💾 Remember Me enabled - keeping credentials',
//         name: 'LoginCubit',
//       );
//       // Only clear profile from Hive, keep tokens
//       await _hiveService.clearProfile();
//     } else {
//       // Clear everything if remember me is unchecked
//       dev.log(
//         '🗑️ Remember Me disabled - clearing all data',
//         name: 'LoginCubit',
//       );
//       await _tokenManager.clearAll();
//       await _hiveService.clearProfile();
//     }
//
//     // Reset state
//     emit(const LoginState());
//   }
//
//   void clearError() => emit(state.copyWith(errorMessage: null));
//
//   void reset() => emit(const LoginState());
// }
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

  // 👇 UPDATED: Only load email, always default rememberMe to true
  Future<void> _loadSavedPreferences() async {
    // 👇 Load saved email (if remember me was true in last session)
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
  // Future<void> login({required String email, required String password}) async {
  //   dev.log('🚀 Starting login process', name: 'LoginCubit');
  //
  //   emit(
  //     state.copyWith(
  //       isLoading: true,
  //       errorMessage: null,
  //       loginResponse: null,
  //       userProfile: null,
  //       needsProfileCompletion: false,
  //     ),
  //   );
  //
  //   final params = LoginParams(email: email, password: password);
  //
  //   // 👇 UPDATED: Only save email if remember me is checked
  //   if (state.rememberMe) {
  //     await _tokenManager.saveEmail(email);
  //     dev.log(
  //       '💾 Saving email (Remember Me enabled for next session)',
  //       name: 'LoginCubit',
  //     );
  //   } else {
  //     await _tokenManager.clearSavedEmail();
  //     dev.log(
  //       '🗑️ Not saving email (Remember Me disabled)',
  //       name: 'LoginCubit',
  //     );
  //   }
  //
  //   final result = await _authRepository.login(params);
  //
  //   result.fold(
  //     (failure) {
  //       dev.log('❌ Login failed: ${failure.errorMessage}', name: 'LoginCubit');
  //       emit(
  //         state.copyWith(isLoading: false, errorMessage: failure.errorMessage),
  //       );
  //     },
  //     (loginResponse) async {
  //       final userProfile = loginResponse.profile;
  //
  //       if (userProfile == null) {
  //         dev.log(
  //           '⚠️ No profile found - user needs to complete profile',
  //           name: 'LoginCubit',
  //         );
  //
  //         final role = loginResponse.token.user.roles.contains('Trainer')
  //             ? 2
  //             : 1;
  //         await _tokenManager.saveUserRole(role);
  //
  //         dev.log('💾 User role cached from JWT: $role', name: 'LoginCubit');
  //
  //         emit(
  //           state.copyWith(
  //             isLoading: false,
  //             loginResponse: loginResponse,
  //             userProfile: null,
  //             needsProfileCompletion: true,
  //           ),
  //         );
  //         return;
  //       }
  //
  //       dev.log('✅ Login successful, got profile data.', name: 'LoginCubit');
  //
  //       await _hiveService.saveProfile(userProfile);
  //
  //       if (userProfile.role != null) {
  //         await _tokenManager.saveUserRole(userProfile.role!);
  //         dev.log(
  //           '💾 User role cached: ${userProfile.roleString} (${userProfile.role})',
  //           name: 'LoginCubit',
  //         );
  //       }
  //
  //       final needsCompletion =
  //           userProfile.firstName == null ||
  //           userProfile.lastName == null ||
  //           userProfile.gender == null;
  //
  //       if (needsCompletion) {
  //         dev.log(
  //           '⚠️ Profile incomplete, needs completion.',
  //           name: 'LoginCubit',
  //         );
  //       } else {
  //         dev.log('✅ Profile complete, proceeding.', name: 'LoginCubit');
  //       }
  //
  //       emit(
  //         state.copyWith(
  //           isLoading: false,
  //           loginResponse: loginResponse,
  //           userProfile: userProfile,
  //           needsProfileCompletion: needsCompletion,
  //         ),
  //       );
  //     },
  //   );
  // }
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
