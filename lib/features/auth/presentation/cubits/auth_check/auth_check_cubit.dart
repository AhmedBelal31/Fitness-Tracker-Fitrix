import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/api_constants.dart';
import 'package:fitrix/features/auth/data/models/login_profile_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/networking/token_manager.dart';
import '../../../../../core/services/hive_service.dart';

part 'auth_check_state.dart';

class AuthCheckCubit extends Cubit<AuthCheckState> {
  final TokenManager _tokenManager = TokenManager.instance;
  final HiveService _hiveService = HiveService();

  AuthCheckCubit() : super(AuthCheckInitial());

  Future<void> checkAuthStatus() async {
    dev.log('🚀 Checking auth status...', name: 'AuthCheckCubit');
    emit(AuthCheckLoading());

    try {
      // 👇 CHECK SESSION FLAG FIRST
      final isSessionRemembered = await _tokenManager.isSessionRemembered();

      if (!isSessionRemembered) {
        dev.log(
          '⏳ Session was temporary - clearing and redirecting to login',
          name: 'AuthCheckCubit',
        );
        await _tokenManager.clearTokens();
        await _hiveService.clearProfile();
        emit(AuthCheckUnauthenticated());
        return;
      }

      dev.log(
        '✅ Session is remembered, checking token...',
        name: 'AuthCheckCubit',
      );

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

      // Check expiry
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
            await _hiveService.clearProfile();
            emit(AuthCheckUnauthenticated());
            return;
          }
        } else {
          dev.log('⚠️ No refresh token found', name: 'AuthCheckCubit');
          await _tokenManager.clearTokens();
          await _hiveService.clearProfile();
          emit(AuthCheckUnauthenticated());
          return;
        }
      }

      // ✅ Token is valid, load profile from Hive
      dev.log(
        '✅ Token valid, loading profile from Hive...',
        name: 'AuthCheckCubit',
      );

      final userProfile = _hiveService.getProfile();

      if (userProfile == null) {
        dev.log(
          '❌ No profile found in Hive - user needs to login',
          name: 'AuthCheckCubit',
        );
        await _tokenManager.clearTokens();
        emit(AuthCheckUnauthenticated());
        return;
      }

      dev.log(
        '✅ Profile loaded from Hive: ${userProfile.firstName ?? "Incomplete"}',
        name: 'AuthCheckCubit',
      );

      emit(AuthCheckAuthenticated(userProfile));
    } catch (e) {
      dev.log('❌ Error during auth check: $e', name: 'AuthCheckCubit');
      await _tokenManager.clearTokens();
      await _hiveService.clearProfile();
      emit(AuthCheckUnauthenticated());
    }
  }
}
