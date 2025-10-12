class Constants {
  Constants._();

  static const bool isPremiumUser = false;

  // User Roles
  static const int userRole = 1;
  static const int trainerRole = 2;
  // SharedPreferences Keys
  static const String isAlreadyLogin = 'isAlreadyLogin';
  static const String userToken = 'userToken';
  static const String refreshToken = 'refreshToken';
  static const String isRemembered = 'isRemembered';

  // keys for TokenManager
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String tokenExpiryKey = 'token_expiry';
  static const String savedEmailKey = 'saved_email';
  static const String userIdKey = 'user_id';
  static const String rememberMeKey = 'remember_me';
  static const String userRoleKey = 'user_role';

  static const bool rememberMeDefault = true;
}
