import 'package:dio/dio.dart';
import 'package:fitrix/core/networking/token_manager.dart';
import '../common_ui/widgets/app_logger.dart';
import 'api_constants.dart';

// class AuthInterceptor extends Interceptor {
//   final Dio _dio;
//   final TokenManager _tokenManager = TokenManager.instance;
//   bool _isRefreshing = false;
//   List<Function> _requestsWaitingForToken = [];
//
//   AuthInterceptor(this._dio);
//
//   @override
//   Future<void> onRequest(
//     RequestOptions options,
//     RequestInterceptorHandler handler,
//   ) async {
//     try {
//       // Skip adding token for refresh endpoint
//       if (options.path.contains('refresh-token')) {
//         dev.log(
//           '⏭️ Skipping token for refresh endpoint',
//           name: 'AuthInterceptor',
//         );
//         return handler.next(options);
//       }
//
//       final token = await _tokenManager.getAccessToken();
//
//       if (token != null && token.isNotEmpty) {
//         options.headers['Authorization'] = 'Bearer $token';
//         dev.log('🔑 Added Bearer token to request', name: 'AuthInterceptor');
//       } else {
//         dev.log('⚠️ No token found', name: 'AuthInterceptor');
//       }
//
//       return handler.next(options);
//     } catch (e) {
//       dev.log('❌ AuthInterceptor onRequest error: $e', name: 'AuthInterceptor');
//       return handler.next(options);
//     }
//   }
//
//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     try {
//       final responseData = response.data;
//
//       if (responseData is Map<String, dynamic>) {
//         final token =
//             responseData['accessToken'] ??
//             responseData['access_token'] ??
//             responseData['token'];
//
//         if (token != null && token is String) {
//           dev.log('✅ Token found in response', name: 'AuthInterceptor');
//         }
//       }
//
//       return handler.next(response);
//     } catch (e) {
//       dev.log(
//         '❌ AuthInterceptor onResponse error: $e',
//         name: 'AuthInterceptor',
//       );
//       return handler.next(response);
//     }
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     try {
//       // Only handle 401 errors
//       if (err.response?.statusCode != 401) {
//         AppLogger.e(
//           'Error: ${err.response?.statusCode} - ${err.response?.data}',
//         );
//         return handler.next(err);
//       }
//
//       // Don't retry refresh endpoint
//       if (err.requestOptions.path.contains('refresh-token')) {
//         dev.log('⏭️ Refresh token endpoint failed', name: 'AuthInterceptor');
//         await _tokenManager.clearTokens();
//         return handler.next(err);
//       }
//
//       dev.log(
//         '🔒 Unauthorized (401) - Attempting token refresh',
//         name: 'AuthInterceptor',
//       );
//
//       final refreshToken = await _tokenManager.getRefreshToken();
//       final expiredAccessToken = await _tokenManager.getAccessToken();
//
//       AppLogger.d('Expired Access Token: $expiredAccessToken');
//       AppLogger.d('Refresh Token: $refreshToken');
//       if (refreshToken == null || refreshToken.isEmpty) {
//         dev.log('⚠️ No refresh token available', name: 'AuthInterceptor');
//         await _tokenManager.clearTokens();
//         return handler.next(err);
//       }
//
//       if (expiredAccessToken == null || expiredAccessToken.isEmpty) {
//         dev.log(
//           '⚠️ No expired access token available',
//           name: 'AuthInterceptor',
//         );
//         await _tokenManager.clearTokens();
//         return handler.next(err);
//       }
//
//       // ✅ Prevent multiple simultaneous refresh attempts
//       if (_isRefreshing) {
//         dev.log(
//           '⏳ Already refreshing, queuing request',
//           name: 'AuthInterceptor',
//         );
//
//         // Queue the request to retry after refresh completes
//         await Future.delayed(const Duration(milliseconds: 100));
//         final token = await _tokenManager.getAccessToken();
//
//         if (token != null && token.isNotEmpty) {
//           try {
//             final retryRequest = await _dio.fetch(
//               err.requestOptions..headers['Authorization'] = 'Bearer $token',
//             );
//             return handler.resolve(retryRequest);
//           } catch (e) {
//             return handler.next(err);
//           }
//         }
//
//         return handler.next(err);
//       }
//
//       _isRefreshing = true;
//
//       try {
//         dev.log('🔄 Refreshing token...', name: 'AuthInterceptor');
//         dev.log(
//           '🔑 Refresh Token: ${refreshToken.substring(0, 20)}...',
//           name: 'AuthInterceptor',
//         );
//         dev.log(
//           '🔑 Expired Token: ${expiredAccessToken.substring(0, 20)}...',
//           name: 'AuthInterceptor',
//         );
//
//         // ✅ Create a new Dio instance without interceptors for refresh
//         final refreshDio = Dio(
//           BaseOptions(
//             baseUrl: ApiEndpoints.apiBaseUrl,
//             headers: {'Content-Type': 'application/json'},
//           ),
//         );
//
//         final response = await refreshDio.post(
//           ApiEndpoints.refreshToken,
//           data: {
//             "refreshToken": refreshToken,
//             "expiredAccessToken": expiredAccessToken,
//           },
//         );
//
//         dev.log(
//           '📨 Refresh response status: ${response.statusCode}',
//           name: 'AuthInterceptor',
//         );
//         dev.log(
//           '📨 Refresh response data: ${response.data}',
//           name: 'AuthInterceptor',
//         );
//
//         if (response.statusCode == 200) {
//           final data = response.data;
//           final newAccessToken = data['accessToken'] ?? data['access_token'];
//           final newRefreshToken =
//               data['refreshToken'] ?? data['refresh_token'] ?? refreshToken;
//           final expiresOnUtc = data['expiresOnUtc'] != null
//               ? DateTime.parse(data['expiresOnUtc'])
//               : DateTime.now().add(const Duration(hours: 1));
//
//           if (newAccessToken != null && newAccessToken is String) {
//             await _tokenManager.saveTokens(
//               accessToken: newAccessToken,
//               refreshToken: newRefreshToken,
//               expiresOnUtc: expiresOnUtc,
//             );
//
//             dev.log('✅ Token refreshed successfully', name: 'AuthInterceptor');
//
//             // ✅ Retry the original request with new token
//             try {
//               final retryRequest = await _dio.fetch(
//                 err.requestOptions
//                   ..headers['Authorization'] = 'Bearer $newAccessToken',
//               );
//               _isRefreshing = false;
//               return handler.resolve(retryRequest);
//             } catch (retryError) {
//               dev.log('❌ Retry failed: $retryError', name: 'AuthInterceptor');
//               _isRefreshing = false;
//               return handler.next(err);
//             }
//           } else {
//             dev.log(
//               '❌ No access token in refresh response',
//               name: 'AuthInterceptor',
//             );
//             await _tokenManager.clearTokens();
//             _isRefreshing = false;
//             return handler.next(err);
//           }
//         } else {
//           dev.log(
//             '❌ Refresh failed with status: ${response.statusCode}',
//             name: 'AuthInterceptor',
//           );
//           await _tokenManager.clearTokens();
//           _isRefreshing = false;
//           return handler.next(err);
//         }
//       } catch (e, stackTrace) {
//         dev.log('❌ Token refresh exception: $e', name: 'AuthInterceptor');
//         dev.log('Stack trace: $stackTrace', name: 'AuthInterceptor');
//         await _tokenManager.clearTokens();
//         _isRefreshing = false;
//         return handler.next(err);
//       }
//     } catch (e, stackTrace) {
//       dev.log(
//         '❌ AuthInterceptor onError exception: $e',
//         name: 'AuthInterceptor',
//       );
//       dev.log('Stack trace: $stackTrace', name: 'AuthInterceptor');
//       _isRefreshing = false;
//       return handler.next(err);
//     }
//   }
// }
//

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final TokenManager _tokenManager = TokenManager.instance;
  bool _isRefreshing = false;

  AuthInterceptor(this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      if (_shouldSkipAuth(options.path)) {
        AppLogger.d('[AuthInterceptor] ⏭️ Skipping auth for: ${options.path}');
        return handler.next(options);
      }

      final token = await _tokenManager.getAccessToken();

      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
        AppLogger.d('[AuthInterceptor] 🔑 Added Bearer token');
      }

      return handler.next(options);
    } catch (e) {
      AppLogger.e('[AuthInterceptor] ❌ onRequest error: $e');
      return handler.next(options);
    }
  }

  bool _shouldSkipAuth(String path) {
    return path.contains('login') ||
        path.contains('register') ||
        path.contains('refresh-token') ||
        path.contains('forgot-password');
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      final responseData = response.data;

      if (responseData is Map<String, dynamic>) {
        final token =
            responseData['accessToken'] ??
            responseData['access_token'] ??
            responseData['token'];

        if (token != null && token is String) {
          AppLogger.d('[AuthInterceptor] ✅ Token found in response');
        }
      }

      return handler.next(response);
    } catch (e) {
      AppLogger.e('[AuthInterceptor] ❌ onResponse error: $e');
      return handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    try {
      if (err.response?.statusCode != 401) {
        AppLogger.e('[AuthInterceptor] Error: ${err.response?.statusCode}');
        return handler.next(err);
      }

      if (_shouldSkipAuth(err.requestOptions.path)) {
        AppLogger.d(
          '[AuthInterceptor] ⏭️ Skipping refresh for: ${err.requestOptions.path}',
        );
        return handler.next(err);
      }

      AppLogger.d('[AuthInterceptor] 🔒 401 - Attempting token refresh');

      final refreshToken = await _tokenManager.getRefreshToken();
      final expiredAccessToken = await _tokenManager.getAccessToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        AppLogger.w('[AuthInterceptor] ⚠️ No refresh token available');
        await _tokenManager.clearTokens();
        return handler.next(err);
      }

      if (expiredAccessToken == null || expiredAccessToken.isEmpty) {
        AppLogger.w('[AuthInterceptor] ⚠️ No expired access token');
        await _tokenManager.clearTokens();
        return handler.next(err);
      }

      if (_isRefreshing) {
        AppLogger.d('[AuthInterceptor] ⏳ Already refreshing, waiting...');
        await Future.delayed(const Duration(milliseconds: 100));
        final token = await _tokenManager.getAccessToken();

        if (token != null && token.isNotEmpty) {
          try {
            final retryRequest = await _dio.fetch(
              err.requestOptions..headers['Authorization'] = 'Bearer $token',
            );
            return handler.resolve(retryRequest);
          } catch (e) {
            return handler.next(err);
          }
        }

        return handler.next(err);
      }

      _isRefreshing = true;

      try {
        AppLogger.d('[AuthInterceptor] 🔄 Refreshing token...');

        final refreshDio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.apiBaseUrl,
            headers: {'Content-Type': 'application/json'},
          ),
        );

        final response = await refreshDio.post(
          ApiEndpoints.refreshToken,
          data: {
            "refreshToken": refreshToken,
            "expiredAccessToken": expiredAccessToken,
          },
        );

        AppLogger.d(
          '[AuthInterceptor] 📨 Refresh response: ${response.statusCode}',
        );

        if (response.statusCode == 200) {
          final data = response.data;
          final newAccessToken = data['accessToken'] ?? data['access_token'];
          final newRefreshToken =
              data['refreshToken'] ?? data['refresh_token'] ?? refreshToken;
          final expiresOnUtc = data['expiresOnUtc'] != null
              ? DateTime.parse(data['expiresOnUtc'])
              : DateTime.now().add(const Duration(hours: 1));

          if (newAccessToken != null && newAccessToken is String) {
            await _tokenManager.saveTokens(
              accessToken: newAccessToken,
              refreshToken: newRefreshToken,
              expiresOnUtc: expiresOnUtc,
            );

            AppLogger.d('[AuthInterceptor] ✅ Token refreshed successfully');

            try {
              final retryRequest = await _dio.fetch(
                err.requestOptions
                  ..headers['Authorization'] = 'Bearer $newAccessToken',
              );
              _isRefreshing = false;
              return handler.resolve(retryRequest);
            } catch (retryError) {
              AppLogger.e('[AuthInterceptor] ❌ Retry failed: $retryError');
              _isRefreshing = false;
              return handler.next(err);
            }
          } else {
            AppLogger.e(
              '[AuthInterceptor] ❌ No access token in refresh response',
            );
            await _tokenManager.clearTokens();
            _isRefreshing = false;
            return handler.next(err);
          }
        } else {
          AppLogger.e(
            '[AuthInterceptor] ❌ Refresh failed: ${response.statusCode}',
          );
          await _tokenManager.clearTokens();
          _isRefreshing = false;
          return handler.next(err);
        }
      } catch (e, stackTrace) {
        AppLogger.e('[AuthInterceptor] ❌ Token refresh exception: $e');
        AppLogger.e('Stack trace: $stackTrace');
        await _tokenManager.clearTokens();
        _isRefreshing = false;
        return handler.next(err);
      }
    } catch (e, stackTrace) {
      AppLogger.e('[AuthInterceptor] ❌ onError exception: $e');
      AppLogger.e('Stack trace: $stackTrace');
      _isRefreshing = false;
      return handler.next(err);
    }
  }
}
