import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/token_manager.dart';
import 'dart:developer' as dev;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'api_constants.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final TokenManager _tokenManager = TokenManager.instance;

  AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Get token from TokenManager
      final token = await _tokenManager.getAccessToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        dev.log('🔑 Added Bearer token to request', name: 'AuthInterceptor');
        dev.log(
          '🔑 Token: ${token.substring(0, 20)}...',
          name: 'AuthInterceptor',
        );
      } else {
        dev.log('⚠️ No token found', name: 'AuthInterceptor');
      }

      return handler.next(options);
    } catch (e) {
      dev.log('❌ AuthInterceptor onRequest error: $e', name: 'AuthInterceptor');
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      // Save token if present in response (for login/refresh)
      final responseData = response.data;

      if (responseData is Map<String, dynamic>) {
        final token =
            responseData['accessToken'] ??
            responseData['access_token'] ??
            responseData['token'];

        if (token != null && token is String) {
          dev.log(
            '✅ Token found in response, already saved by repository',
            name: 'AuthInterceptor',
          );
        }
      }

      return handler.next(response);
    } catch (e) {
      dev.log(
        '❌ AuthInterceptor onResponse error: $e',
        name: 'AuthInterceptor',
      );
      return handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode == 401) {
        dev.log(
          '🔒 Unauthorized (401) - Token may be expired',
          name: 'AuthInterceptor',
        );

        final refreshToken = await _tokenManager.getRefreshToken();
        final expiredAccessToken = await _tokenManager.getAccessToken();

        if (refreshToken != null &&
            refreshToken.isNotEmpty &&
            expiredAccessToken != null) {
          try {
            dev.log(
              '🔄 Attempting to refresh token...',
              name: 'AuthInterceptor',
            );

            final response = await _dio.post(
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
                '✅ Token refreshed successfully',
                name: 'AuthInterceptor',
              );

              // Retry original request with new token
              final retryRequest = await _dio.fetch(
                err.requestOptions
                  ..headers['Authorization'] = 'Bearer $newAccessToken',
              );
              return handler.resolve(retryRequest);
            }
          } catch (e) {
            dev.log('❌ Token refresh failed: $e', name: 'AuthInterceptor');
            await _tokenManager.clearTokens();
          }
        } else {
          dev.log('⚠️ No refresh token found', name: 'AuthInterceptor');
          await _tokenManager.clearTokens();
        }
      }

      return handler.next(err);
    } catch (e) {
      dev.log('❌ AuthInterceptor onError error: $e', name: 'AuthInterceptor');
      return handler.next(err);
    }
  }
}
