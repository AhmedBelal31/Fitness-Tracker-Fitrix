import 'package:flutter/material.dart';

class ColorsManager {
  // 🎨 Primary Fitness Green Colors
  static const Color primaryGreen = Color(0xFF48BB78);
  static const Color secondaryGreen = Color(0xFF38A169);
  static const Color lightGreen = Color(0xFF68D391);
  static const Color darkGreen = Color(0xFF2F855A);
  static const Color mintGreen = Color(0xFF81E6D9);
  static const Color forestGreen = Color(0xFF276749);
  static const Color emeraldGreen = Color(0xFF059669);
  static const Color limeGreen = Color(0xFF65D6AD);
  static const Color tealGreen = Color(0xFF319795);
  static const Color seafoamGreen = Color(0xFF4FD1C7);

  // 🎨 Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGreen, secondaryGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient appBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8F9FA), Colors.white, Color(0xFFF8F9FA)],
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient appBarBackgroundGradient = LinearGradient(
    colors: [primaryGreen, secondaryGreen, darkGreen],
    stops: [0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient cardGradient = RadialGradient(
    center: Alignment.topLeft,
    radius: 1.5,
    colors: [lightGreen, primaryGreen, secondaryGreen, darkGreen],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    colors: [primaryGreen, secondaryGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // 🧱 Shadows
  static final List<BoxShadow> primaryShadow = [
    BoxShadow(
      color: primaryGreen.withOpacity(0.3),
      blurRadius: 12,
      spreadRadius: 2,
      offset: const Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 15,
      spreadRadius: 1,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: primaryGreen.withOpacity(0.1),
      blurRadius: 8,
      spreadRadius: 0,
      offset: const Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: Colors.grey.withOpacity(0.1),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];

  // 🎨 Text Colors
  static const Color primaryText = Color(0xFF2D3748);
  static const Color secondaryText = Color(0xFF4A5568);
  static const Color lightText = Color(0xFF718096);
  static const Color placeholderText = Color(0xFF9CA3AF);
  static const Color whiteText = Colors.white;

  // 🎨 Background Colors
  static const Color scaffoldBackground = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color inputBackground = Color(0xFFF7FAFC);
  static const Color overlayBackground = Color(0x80000000);

  // 🎨 Border Colors
  static const Color primaryBorder = primaryGreen;
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color inputBorder = Color(0xFFCBD5E0);
  static const Color focusedBorder = primaryGreen;

  // 🎨 Status Colors
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFFBD38D);
  static const Color error = Color(0xFFE53E3E);
  static const Color info = Color(0xFF4299E1);

  // 🎨 Standard Colors (Updated to match fitness theme)
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFE53E3E);
  static const Color darkRed = Color(0xFFC53030);
  static const Color blue = Color(0xFF4299E1);
  static const Color yellow = Color(0xFFFBD38D);
  static const Color orange = Color(0xFFED8936);

  // 🎨 Grey Scale
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // 🎨 Legacy Colors (for backward compatibility)
  static const Color lightGray = grey100;
  static const Color grey = grey400;
  static const Color semiDarkGray = grey500;
  static const Color darkGray = grey600;
  static const Color darkGrey = grey700;
  static const Color lightGrey = grey300;
  static const Color lighterGrey = grey200;
  static const Color veryDarkGrey = grey900;
  static const Color green = primaryGreen;
  static const Color lightGreen2 = lightGreen;
  static const Color darkGreen2 = darkGreen;

  // 🎨 Fitness-Specific Colors
  static const Color caloriesBurned = Color(0xFFFF6B6B);
  static const Color stepsColor = Color(0xFF4ECDC4);
  static const Color waterIntake = Color(0xFF45B7D1);
  static const Color workoutTime = Color(0xFF96CEB4);
  static const Color heartRate = Color(0xFFFF7675);
  static const Color proteinColor = Color(0xFFD63031);
  static const Color carbsColor = Color(0xFFE17055);
  static const Color fatsColor = Color(0xFFF39C12);

  // 🎨 Progress Colors
  static const Color progressLow = Color(0xFFFF7675);
  static const Color progressMedium = Color(0xFFFFDA79);
  static const Color progressHigh = Color(0xFF00B894);
  static const Color progressComplete = primaryGreen;

  // 🎨 Difficulty Levels
  static const Color beginnerLevel = Color(0xFF74B9FF);
  static const Color intermediateLevel = Color(0xFFFFDA79);
  static const Color advancedLevel = Color(0xFFFF7675);
  static const Color expertLevel = Color(0xFF6C5CE7);

  static const Color buttonDisabledBackground = Color(0xFF444444);

  // 🎯 Helper Methods
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  static Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
