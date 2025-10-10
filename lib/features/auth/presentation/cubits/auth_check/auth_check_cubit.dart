import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/api_constants.dart';
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

      // Check expiry (using NTP now inside TokenManager)
      final isExpired = await _tokenManager.isTokenExpired();

      if (isExpired) {
        dev.log('⏰ Token expired - trying refresh...', name: 'AuthCheckCubit');

        final refreshToken = await _tokenManager.getRefreshToken();
        final expiredAccessToken = await _tokenManager.getAccessToken();

        if (refreshToken != null &&
            refreshToken.isNotEmpty &&
            expiredAccessToken != null) {
          try {
            final dio = Dio();
            final response = await dio.post(
              '${ApiEndpoints.apiBaseUrl}${ApiEndpoints.refreshToken}',
              data: {
                "refreshToken": refreshToken,
                "expiredAccessToken": expiredAccessToken,
              },
            );

            final data = response.data;
            final newAccessToken = data['accessToken'] ?? data['access_token'];
            final newRefreshToken = data['refreshToken'] ?? refreshToken;
            final expiresOnUtc = DateTime.parse(data['expiresOnUtc']);

            if (newAccessToken != null) {
              await _tokenManager.saveTokens(
                accessToken: newAccessToken,
                refreshToken: newRefreshToken,
                expiresOnUtc: expiresOnUtc,
              );

              dev.log(
                '✅ Token refreshed successfully - continue session',
                name: 'AuthCheckCubit',
              );
            } else {
              throw Exception('No new token in response');
            }
          } catch (e) {
            dev.log('❌ Refresh token failed: $e', name: 'AuthCheckCubit');
            await _tokenManager.clearTokens();
            emit(AuthCheckUnauthenticated());
            return;
          }
        } else {
          dev.log('⚠️ No refresh token found', name: 'AuthCheckCubit');
          await _tokenManager.clearTokens();
          emit(AuthCheckUnauthenticated());
          return;
        }
      }

      // ✅ If we reach here → Token is valid (refreshed or not), fetch profile
      dev.log('✅ Token valid, fetching profile...', name: 'AuthCheckCubit');

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
