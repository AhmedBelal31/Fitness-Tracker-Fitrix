import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

class TokenManager {
  static TokenManager? _instance;
  SharedPreferences? _prefs;
  bool _isInitialized = false;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';
  static const String _userIdKey = 'user_id';
  static const String _rememberMeKey = 'remember_me';
  static const String _savedEmailKey = 'saved_email';

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

  // Token management methods
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresOnUtc,
    String? userId,
  }) async {
    await init();
    await _prefs?.setString(_accessTokenKey, accessToken);
    await _prefs?.setString(_refreshTokenKey, refreshToken);
    await _prefs?.setString(_tokenExpiryKey, expiresOnUtc.toIso8601String());
    if (userId != null) {
      await _prefs?.setString(_userIdKey, userId);
    }
    dev.log('✅ Tokens saved with expiry: $expiresOnUtc', name: 'TokenManager');
  }

  Future<String?> getAccessToken() async {
    await init();
    final token = _prefs?.getString(_accessTokenKey);
    if (token != null) {
      dev.log(
        '🔑 Access token retrieved: exists = ${token.substring(0, 50)}...',
        name: 'TokenManager',
      );
    } else {
      dev.log('🔑 Access token retrieved: null', name: 'TokenManager');
    }
    return token;
  }

  Future<String?> getRefreshToken() async {
    await init();
    return _prefs?.getString(_refreshTokenKey);
  }

  Future<DateTime?> getTokenExpiry() async {
    await init();
    final expiryStr = _prefs?.getString(_tokenExpiryKey);
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

    // Get accurate server time instead of local
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

    // Subtract 5 mins as buffer
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
    return _prefs?.getString(_userIdKey);
  }

  Future<void> clearTokens() async {
    await init();
    await _prefs?.remove(_accessTokenKey);
    await _prefs?.remove(_refreshTokenKey);
    await _prefs?.remove(_tokenExpiryKey);
    await _prefs?.remove(_userIdKey);
    dev.log('🗑️ All tokens cleared', name: 'TokenManager');
  }

  bool get hasToken {
    return _prefs?.getString(_accessTokenKey) != null;
  }

  // Remember Me methods
  Future<void> saveRememberMe(bool value) async {
    await init();
    await _prefs?.setBool(_rememberMeKey, value);
    dev.log('💾 Remember me saved: $value', name: 'TokenManager');
  }

  Future<bool> getRememberMe() async {
    await init();
    return _prefs?.getBool(_rememberMeKey) ?? false;
  }

  Future<void> saveEmail(String email) async {
    await init();
    await _prefs?.setString(_savedEmailKey, email);
    dev.log('💾 Email saved for remember me', name: 'TokenManager');
  }

  Future<String?> getSavedEmail() async {
    await init();
    return _prefs?.getString(_savedEmailKey);
  }

  Future<void> clearSavedEmail() async {
    await init();
    await _prefs?.remove(_savedEmailKey);
    dev.log('🗑️ Saved email cleared', name: 'TokenManager');
  }

  // Clear all data (logout)
  Future<void> clearAll() async {
    await clearTokens();
    await clearSavedEmail();
    await saveRememberMe(false);
    dev.log('🗑️ All data cleared', name: 'TokenManager');
  }
}
