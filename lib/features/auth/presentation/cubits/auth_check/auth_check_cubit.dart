import 'dart:developer' as dev;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/networking/error/failures.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../data/models/user_model.dart';

part 'auth_check_state.dart';

class AuthCheckCubit extends Cubit<AuthCheckState> {
  final AuthRepository _authRepository;
  final TokenManager _tokenManager = TokenManager.instance;

  AuthCheckCubit(this._authRepository) : super(AuthCheckInitial());

  Future<void> checkAuthStatus() async {
    dev.log('🚀 Checking auth status...', name: 'AuthCheckCubit');
    emit(AuthCheckLoading());

    try {
      // Check if token exists
      final token = await _tokenManager.getAccessToken();

      if (token == null || token.isEmpty) {
        dev.log(
          '❌ No token found - user needs to login',
          name: 'AuthCheckCubit',
        );
        emit(AuthCheckUnauthenticated());
        return;
      }

      dev.log('✅ Token found, checking expiry...', name: 'AuthCheckCubit');

      // Check if token is expired
      final isExpired = await _tokenManager.isTokenExpired();

      if (isExpired) {
        dev.log(
          '⏰ Token is expired - clearing and redirecting to login',
          name: 'AuthCheckCubit',
        );
        await _tokenManager.clearTokens();
        emit(AuthCheckUnauthenticated());
        return;
      }

      dev.log('✅ Token is valid, fetching profile...', name: 'AuthCheckCubit');

      // Token exists and is valid - fetch profile
      final profileResult = await _authRepository.getProfile();

      profileResult.fold(
        (failure) {
          if (failure is ProfileNotFoundFailure) {
            dev.log(
              '⚠️ Profile not found - needs completion',
              name: 'AuthCheckCubit',
            );
            emit(AuthCheckNeedsProfileCompletion());
          } else {
            dev.log(
              '❌ Profile fetch failed: ${failure.errorMessage}',
              name: 'AuthCheckCubit',
            );
            _tokenManager.clearTokens();
            emit(AuthCheckUnauthenticated());
          }
        },
        (userProfile) {
          dev.log(
            '✅ Profile fetched successfully - user authenticated',
            name: 'AuthCheckCubit',
          );
          emit(AuthCheckAuthenticated(userProfile));
        },
      );
    } catch (e) {
      dev.log('❌ Error during auth check: $e', name: 'AuthCheckCubit');
      emit(AuthCheckUnauthenticated());
    }
  }
}
