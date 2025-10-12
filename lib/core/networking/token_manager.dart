import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;
import '../helpers/constants.dart';

// class TokenManager {
//   static TokenManager? _instance;
//   SharedPreferences? _prefs;
//   bool _isInitialized = false;
//
//   TokenManager._();
//
//   static TokenManager get instance {
//     _instance ??= TokenManager._();
//     return _instance!;
//   }
//
//   Future<void> init() async {
//     if (!_isInitialized) {
//       _prefs = await SharedPreferences.getInstance();
//       _isInitialized = true;
//       dev.log('✅ TokenManager initialized', name: 'TokenManager');
//     }
//   }
//
//   /// Save user role (1 = User, 2 = Trainer)
//
//   Future<void> saveUserRole(int role) async {
//     await init();
//     await _prefs?.setInt(Constants.userRoleKey, role);
//     dev.log('💾 User role saved: $role', name: 'TokenManager');
//   }
//
//   /// Get saved user role
//   Future<int?> getUserRole() async {
//     await init();
//     return _prefs?.getInt(Constants.userRoleKey);
//   }
//
//   /// Check if user is a regular user (role = 1)
//   Future<bool> get isUser async {
//     final role = await getUserRole();
//     return role == Constants.userRole;
//   }
//
//   /// Check if user is a trainer (role = 2)
//   Future<bool> get isTrainer async {
//     final role = await getUserRole();
//     return role == Constants.trainerRole;
//   }
//
//   /// Clear user role
//   Future<void> clearUserRole() async {
//     await init();
//     await _prefs?.remove(Constants.userRoleKey);
//     dev.log('🗑️ User role cleared', name: 'TokenManager');
//   }
//
//   // ========== REMEMBER ME ==========
//
//   /// Returns null if no preference exists, otherwise returns the saved value
//   Future<bool?> getRememberMe() async {
//     await init();
//     // Check if key exists
//     if (!_prefs!.containsKey(Constants.rememberMeKey)) {
//       return null; // No preference saved yet
//     }
//     return _prefs?.getBool(Constants.rememberMeKey) ??
//         Constants.rememberMeDefault;
//   }
//
//   Future<void> saveRememberMe(bool value) async {
//     await init();
//     await _prefs?.setBool(Constants.rememberMeKey, value);
//     dev.log('💾 Remember me saved: $value', name: 'TokenManager');
//   }
//
//   // ========== EMAIL ==========
//
//   Future<String?> getSavedEmail() async {
//     await init();
//     return _prefs?.getString(Constants.savedEmailKey);
//   }
//
//   Future<void> saveEmail(String email) async {
//     await init();
//     await _prefs?.setString(Constants.savedEmailKey, email);
//     dev.log('💾 Email saved', name: 'TokenManager');
//   }
//
//   Future<void> clearSavedEmail() async {
//     await init();
//     await _prefs?.remove(Constants.savedEmailKey);
//     dev.log('🗑️ Saved email cleared', name: 'TokenManager');
//   }
//
//   // ========== TOKENS ==========
//
//   Future<void> saveTokens({
//     required String accessToken,
//     required String refreshToken,
//     required DateTime expiresOnUtc,
//     String? userId,
//   }) async {
//     await init();
//
//     try {
//       // Save all tokens in SharedPreferences
//       await _prefs?.setString(Constants.accessTokenKey, accessToken);
//       await _prefs?.setString(Constants.refreshTokenKey, refreshToken);
//       await _prefs?.setString(
//         Constants.tokenExpiryKey,
//         expiresOnUtc.toIso8601String(),
//       );
//
//       // Save userId if provided
//       if (userId != null) {
//         await _prefs?.setString(Constants.userIdKey, userId);
//       }
//
//       dev.log(
//         '✅ Tokens saved with expiry: $expiresOnUtc',
//         name: 'TokenManager',
//       );
//     } catch (e) {
//       dev.log('❌ Error saving tokens: $e', name: 'TokenManager');
//     }
//   }
//
//   Future<String?> getAccessToken() async {
//     await init();
//     final token = _prefs?.getString(Constants.accessTokenKey);
//     if (token != null) {
//       dev.log(
//         '🔑 Access token retrieved: exists = ${token.substring(0, token.length > 50 ? 50 : token.length)}...',
//         name: 'TokenManager',
//       );
//     } else {
//       dev.log('🔑 Access token retrieved: null', name: 'TokenManager');
//     }
//     return token;
//   }
//
//   Future<String?> getRefreshToken() async {
//     await init();
//     return _prefs?.getString(Constants.refreshTokenKey);
//   }
//
//   Future<DateTime?> getTokenExpiry() async {
//     await init();
//     final expiryStr = _prefs?.getString(Constants.tokenExpiryKey);
//     if (expiryStr != null) {
//       final expiry = DateTime.tryParse(expiryStr);
//       dev.log('⏰ Token expiry: $expiry', name: 'TokenManager');
//       return expiry;
//     }
//     dev.log('⏰ Token expiry: null', name: 'TokenManager');
//     return null;
//   }
//
//   Future<bool> isTokenExpired() async {
//     final expiry = await getTokenExpiry();
//
//     if (expiry == null) {
//       dev.log(
//         '⚠️ No expiry date found - considering token expired',
//         name: 'TokenManager',
//       );
//       return true;
//     }
//
//     // Get accurate server time instead of local
//     DateTime now;
//     try {
//       now = await NTP.now();
//     } catch (e) {
//       dev.log(
//         '⚠️ Failed to get NTP time, fallback to device time',
//         name: 'TokenManager',
//       );
//       now = DateTime.now().toUtc();
//     }
//
//     // Subtract 5 mins as buffer
//     final expiryWithBuffer = expiry.subtract(const Duration(minutes: 5));
//     final isExpired = now.isAfter(expiryWithBuffer);
//
//     dev.log(
//       '⏰ Token expired check: Now=$now, Expiry=$expiryWithBuffer, IsExpired=$isExpired',
//       name: 'TokenManager',
//     );
//
//     return isExpired;
//   }
//
//   // ========== USER ID ==========
//
//   Future<String?> getUserId() async {
//     await init();
//     return _prefs?.getString(Constants.userIdKey);
//   }
//
//   Future<bool> get hasToken async {
//     final token = await getAccessToken();
//     return token != null && token.isNotEmpty;
//   }
//
//   Future<void> clearTokens() async {
//     await init();
//
//     try {
//       // Clear all token-related data
//       await _prefs?.remove(Constants.accessTokenKey);
//       await _prefs?.remove(Constants.refreshTokenKey);
//       await _prefs?.remove(Constants.tokenExpiryKey);
//       await _prefs?.remove(Constants.userIdKey);
//       await clearUserRole();
//
//       dev.log('🗑️ All tokens cleared', name: 'TokenManager');
//     } catch (e) {
//       dev.log('❌ Error clearing tokens: $e', name: 'TokenManager');
//     }
//   }
//
//   // Clear all data (logout)
//   Future<void> clearAll() async {
//     await clearTokens();
//     await clearSavedEmail();
//     await saveRememberMe(false);
//     dev.log('🗑️ All data cleared', name: 'TokenManager');
//   }
//
//   // ========== DEBUG HELPERS (UPDATED) ==========
//
//   Future<void> debugPrintAll() async {
//     await init();
//     dev.log('=== TokenManager Debug ===', name: 'TokenManager');
//     dev.log(
//       'Access Token: ${await getAccessToken() != null ? "exists" : "null"}',
//       name: 'TokenManager',
//     );
//     dev.log(
//       'Refresh Token: ${await getRefreshToken() != null ? "exists" : "null"}',
//       name: 'TokenManager',
//     );
//     dev.log('Token Expiry: ${await getTokenExpiry()}', name: 'TokenManager');
//     dev.log('User ID: ${await getUserId()}', name: 'TokenManager');
//     dev.log(
//       'User Role: ${await getUserRole()}',
//       name: 'TokenManager',
//     ); // 👈 NEW
//     dev.log('Remember Me: ${await getRememberMe()}', name: 'TokenManager');
//     dev.log(
//       'Saved Email: ${await getSavedEmail() != null ? "exists" : "null"}',
//       name: 'TokenManager',
//     );
//     dev.log('=========================', name: 'TokenManager');
//   }
// }
class TokenManager {
  static TokenManager? _instance;
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  TokenManager._();

  static TokenManager get instance {
    _instance ??= TokenManager._();
    return _instance!;
  }

  Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
      dev.log('✅ TokenManager initialized', name: 'TokenManager');
    }
  }

  // ========== SESSION FLAG (New) ==========

  /// Mark current session as "Remember Me" enabled
  /// This flag is checked on app restart
  Future<void> markSessionAsRemembered() async {
    await init();
    await _prefs?.setBool('session_remembered', true);
    dev.log('💾 Session marked as remembered', name: 'TokenManager');
  }

  /// Mark current session as "Remember Me" disabled (session only)
  Future<void> markSessionAsTemporary() async {
    await init();
    await _prefs?.setBool('session_remembered', false);
    dev.log('⏳ Session marked as temporary', name: 'TokenManager');
  }

  /// Check if current session should persist
  Future<bool> isSessionRemembered() async {
    await init();
    return _prefs?.getBool('session_remembered') ?? true; // Default to true
  }

  /// Clear session flag
  Future<void> clearSessionFlag() async {
    await init();
    await _prefs?.remove('session_remembered');
    dev.log('🗑️ Session flag cleared', name: 'TokenManager');
  }

  // ========== USER ROLE ==========

  Future<void> saveUserRole(int role) async {
    await init();
    await _prefs?.setInt(Constants.userRoleKey, role);
    dev.log('💾 User role saved: $role', name: 'TokenManager');
  }

  Future<int?> getUserRole() async {
    await init();
    return _prefs?.getInt(Constants.userRoleKey);
  }

  Future<bool> get isUser async {
    final role = await getUserRole();
    return role == Constants.userRole;
  }

  Future<bool> get isTrainer async {
    final role = await getUserRole();
    return role == Constants.trainerRole;
  }

  Future<void> clearUserRole() async {
    await init();
    await _prefs?.remove(Constants.userRoleKey);
    dev.log('🗑️ User role cleared', name: 'TokenManager');
  }

  // ========== EMAIL ==========

  Future<String?> getSavedEmail() async {
    await init();
    return _prefs?.getString(Constants.savedEmailKey);
  }

  Future<void> saveEmail(String email) async {
    await init();
    await _prefs?.setString(Constants.savedEmailKey, email);
    dev.log('💾 Email saved for next session', name: 'TokenManager');
  }

  Future<void> clearSavedEmail() async {
    await init();
    await _prefs?.remove(Constants.savedEmailKey);
    dev.log('🗑️ Saved email cleared', name: 'TokenManager');
  }

  // ========== TOKENS ==========

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresOnUtc,
    String? userId,
  }) async {
    await init();

    try {
      await _prefs?.setString(Constants.accessTokenKey, accessToken);
      await _prefs?.setString(Constants.refreshTokenKey, refreshToken);
      await _prefs?.setString(
        Constants.tokenExpiryKey,
        expiresOnUtc.toIso8601String(),
      );

      if (userId != null) {
        await _prefs?.setString(Constants.userIdKey, userId);
      }

      dev.log(
        '✅ Tokens saved with expiry: $expiresOnUtc',
        name: 'TokenManager',
      );
    } catch (e) {
      dev.log('❌ Error saving tokens: $e', name: 'TokenManager');
    }
  }

  Future<String?> getAccessToken() async {
    await init();
    final token = _prefs?.getString(Constants.accessTokenKey);
    if (token != null) {
      dev.log('🔑 Access token retrieved: exists', name: 'TokenManager');
    } else {
      dev.log('🔑 Access token retrieved: null', name: 'TokenManager');
    }
    return token;
  }

  Future<String?> getRefreshToken() async {
    await init();
    return _prefs?.getString(Constants.refreshTokenKey);
  }

  Future<DateTime?> getTokenExpiry() async {
    await init();
    final expiryStr = _prefs?.getString(Constants.tokenExpiryKey);
    if (expiryStr != null) {
      final expiry = DateTime.tryParse(expiryStr);
      dev.log('⏰ Token expiry: $expiry', name: 'TokenManager');
      return expiry;
    }
    dev.log('⏰ Token expiry: null', name: 'TokenManager');
    return null;
  }

  Future<bool> isTokenExpired() async {
    final expiry = await getTokenExpiry();

    if (expiry == null) {
      dev.log(
        '⚠️ No expiry date found - considering token expired',
        name: 'TokenManager',
      );
      return true;
    }

    DateTime now;
    try {
      now = await NTP.now();
    } catch (e) {
      dev.log(
        '⚠️ Failed to get NTP time, fallback to device time',
        name: 'TokenManager',
      );
      now = DateTime.now().toUtc();
    }

    final expiryWithBuffer = expiry.subtract(const Duration(minutes: 5));
    final isExpired = now.isAfter(expiryWithBuffer);

    dev.log(
      '⏰ Token expired check: Now=$now, Expiry=$expiryWithBuffer, IsExpired=$isExpired',
      name: 'TokenManager',
    );

    return isExpired;
  }

  Future<String?> getUserId() async {
    await init();
    return _prefs?.getString(Constants.userIdKey);
  }

  Future<bool> get hasToken async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> clearTokens() async {
    await init();

    try {
      await _prefs?.remove(Constants.accessTokenKey);
      await _prefs?.remove(Constants.refreshTokenKey);
      await _prefs?.remove(Constants.tokenExpiryKey);
      await _prefs?.remove(Constants.userIdKey);
      await clearUserRole();
      await clearSessionFlag(); // 👈 Clear session flag too

      dev.log('🗑️ All tokens cleared', name: 'TokenManager');
    } catch (e) {
      dev.log('❌ Error clearing tokens: $e', name: 'TokenManager');
    }
  }

  Future<void> clearAll() async {
    await clearTokens();
    await clearSavedEmail();
    dev.log('🗑️ All data cleared', name: 'TokenManager');
  }

  Future<void> debugPrintAll() async {
    await init();
    dev.log('=== TokenManager Debug ===', name: 'TokenManager');
    dev.log(
      'Access Token: ${await getAccessToken() != null ? "exists" : "null"}',
      name: 'TokenManager',
    );
    dev.log(
      'Refresh Token: ${await getRefreshToken() != null ? "exists" : "null"}',
      name: 'TokenManager',
    );
    dev.log('Token Expiry: ${await getTokenExpiry()}', name: 'TokenManager');
    dev.log('User ID: ${await getUserId()}', name: 'TokenManager');
    dev.log('User Role: ${await getUserRole()}', name: 'TokenManager');
    dev.log(
      'Session Remembered: ${await isSessionRemembered()}',
      name: 'TokenManager',
    ); // 👈 NEW
    dev.log(
      'Saved Email: ${await getSavedEmail() != null ? "exists" : "null"}',
      name: 'TokenManager',
    );
    dev.log('=========================', name: 'TokenManager');
  }
}
