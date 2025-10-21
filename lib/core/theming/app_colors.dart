import 'package:flutter/material.dart';

// class ColorsManager {
//   // 🎨 Primary Fitness Green Colors
//   static const Color primaryGreen = Color(0xFF48BB78);
//   static const Color secondaryGreen = Color(0xFF38A169);
//   static const Color lightGreen = Color(0xFF68D391);
//   static const Color darkGreen = Color(0xFF2F855A);
//   static const Color mintGreen = Color(0xFF81E6D9);
//   static const Color forestGreen = Color(0xFF276749);
//   static const Color emeraldGreen = Color(0xFF059669);
//   static const Color limeGreen = Color(0xFF65D6AD);
//   static const Color tealGreen = Color(0xFF319795);
//   static const Color seafoamGreen = Color(0xFF4FD1C7);
//
//   // 🎨 Gradients
//   static const LinearGradient primaryGradient = LinearGradient(
//     colors: [primaryGreen, secondaryGreen],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
//
//   static const LinearGradient appBackgroundGradient = LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//     colors: [Color(0xFFF8F9FA), Colors.white, Color(0xFFF8F9FA)],
//     stops: [0.0, 0.5, 1.0],
//   );
//
//   static const LinearGradient appBarBackgroundGradient = LinearGradient(
//     colors: [primaryGreen, secondaryGreen, darkGreen],
//     stops: [0.0, 0.5, 1.0],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
//
//   static const RadialGradient cardGradient = RadialGradient(
//     center: Alignment.topLeft,
//     radius: 1.5,
//     colors: [lightGreen, primaryGreen, secondaryGreen, darkGreen],
//     stops: [0.0, 0.3, 0.7, 1.0],
//   );
//
//   static const LinearGradient buttonGradient = LinearGradient(
//     colors: [primaryGreen, secondaryGreen],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
//
//   // 🧱 Shadows
//   static final List<BoxShadow> primaryShadow = [
//     BoxShadow(
//       color: primaryGreen.withOpacity(0.3),
//       blurRadius: 12,
//       spreadRadius: 2,
//       offset: const Offset(0, 6),
//     ),
//   ];
//
//   static final List<BoxShadow> cardShadow = [
//     BoxShadow(
//       color: Colors.black.withOpacity(0.08),
//       blurRadius: 15,
//       spreadRadius: 1,
//       offset: const Offset(0, 4),
//     ),
//     BoxShadow(
//       color: primaryGreen.withOpacity(0.1),
//       blurRadius: 8,
//       spreadRadius: 0,
//       offset: const Offset(0, 2),
//     ),
//   ];
//
//   static final List<BoxShadow> softShadow = [
//     BoxShadow(
//       color: Colors.grey.withOpacity(0.1),
//       blurRadius: 10,
//       spreadRadius: 1,
//       offset: const Offset(0, 3),
//     ),
//   ];
//
//   // 🎨 Text Colors
//   static const Color primaryText = Color(0xFF2D3748);
//   static const Color secondaryText = Color(0xFF4A5568);
//   static const Color lightText = Color(0xFF718096);
//   static const Color placeholderText = Color(0xFF9CA3AF);
//   static const Color whiteText = Colors.white;
//
//   // 🎨 Background Colors
//   static const Color scaffoldBackground = Colors.white;
//   static const Color cardBackground = Colors.white;
//   static const Color lightBackground = Color(0xFFF8F9FA);
//   static const Color inputBackground = Color(0xFFF7FAFC);
//   static const Color overlayBackground = Color(0x80000000);
//
//   // 🎨 Border Colors
//   static const Color primaryBorder = primaryGreen;
//   static const Color lightBorder = Color(0xFFE2E8F0);
//   static const Color inputBorder = Color(0xFFCBD5E0);
//   static const Color focusedBorder = primaryGreen;
//
//   // 🎨 Status Colors
//   static const Color success = Color(0xFF48BB78);
//   // static const Color warning = Color(0xFFFBD38D);
//   static const Color warning = Colors.orange;
//   static const Color error = Color(0xFFE53E3E);
//   static const Color info = Color(0xFF4299E1);
//
//   // 🎨 Standard Colors (Updated to match fitness theme)
//   static const Color white = Colors.white;
//   static const Color black = Colors.black;
//   static const Color red = Color(0xFFE53E3E);
//   static const Color darkRed = Color(0xFFC53030);
//   static const Color blue = Color(0xFF4299E1);
//   static const Color yellow = Color(0xFFFBD38D);
//   static const Color orange = Color(0xFFED8936);
//
//   // 🎨 Grey Scale
//   static const Color grey50 = Color(0xFFF9FAFB);
//   static const Color grey100 = Color(0xFFF3F4F6);
//   static const Color grey200 = Color(0xFFE5E7EB);
//   static const Color grey300 = Color(0xFFD1D5DB);
//   static const Color grey400 = Color(0xFF9CA3AF);
//   static const Color grey500 = Color(0xFF6B7280);
//   static const Color grey600 = Color(0xFF4B5563);
//   static const Color grey700 = Color(0xFF374151);
//   static const Color grey800 = Color(0xFF1F2937);
//   static const Color grey900 = Color(0xFF111827);
//
//   // 🎨 Legacy Colors (for backward compatibility)
//   static const Color lightGray = grey100;
//   static const Color grey = grey400;
//   static const Color semiDarkGray = grey500;
//   static const Color darkGray = grey600;
//   static const Color darkGrey = grey700;
//   static const Color lightGrey = grey300;
//   static const Color lighterGrey = grey200;
//   static const Color veryDarkGrey = grey900;
//   static const Color green = primaryGreen;
//   static const Color lightGreen2 = lightGreen;
//   static const Color darkGreen2 = darkGreen;
//
//   // 🎨 Fitness-Specific Colors
//   static const Color caloriesBurned = Color(0xFFFF6B6B);
//   static const Color stepsColor = Color(0xFF4ECDC4);
//   static const Color waterIntake = Color(0xFF45B7D1);
//   static const Color workoutTime = Color(0xFF96CEB4);
//   static const Color heartRate = Color(0xFFFF7675);
//   static const Color proteinColor = Color(0xFFD63031);
//   static const Color carbsColor = Color(0xFFE17055);
//   static const Color fatsColor = Color(0xFFF39C12);
//
//   // 🎨 Progress Colors
//   static const Color progressLow = Color(0xFFFF7675);
//   static const Color progressMedium = Color(0xFFFFDA79);
//   static const Color progressHigh = Color(0xFF00B894);
//   static const Color progressComplete = primaryGreen;
//
//   // 🎨 Difficulty Levels
//   static const Color beginnerLevel = Color(0xFF74B9FF);
//   static const Color intermediateLevel = Color(0xFFFFDA79);
//   static const Color advancedLevel = Color(0xFFFF7675);
//   static const Color expertLevel = Color(0xFF6C5CE7);
//
//   static const Color buttonDisabledBackground = Color(0xFF444444);
//
//   // 🎯 Helper Methods
//   static Color withOpacity(Color color, double opacity) {
//     return color.withOpacity(opacity);
//   }
//
//   static Color lighten(Color color, [double amount = 0.1]) {
//     assert(amount >= 0 && amount <= 1);
//     final hsl = HSLColor.fromColor(color);
//     final hslLight = hsl.withLightness(
//       (hsl.lightness + amount).clamp(0.0, 1.0),
//     );
//     return hslLight.toColor();
//   }
//
//   static Color darken(Color color, [double amount = 0.1]) {
//     assert(amount >= 0 && amount <= 1);
//     final hsl = HSLColor.fromColor(color);
//     final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
//     return hslDark.toColor();
//   }
//
//   // Light theme colors (ADD THESE)
//   static const Color lightScaffoldBackground = Color(0xFFF5F5F5);
//   static const Color lightCardBackground = Color(0xFFFFFFFF);
//   static const Color lightPrimaryText = Color(0xFF1A1A1A);
//   static const Color lightSecondaryText = Color(0xFF6B7280);
//
//   // Add to ColorsManager class (after line with orange color)
//
//   // 🎨 Enhanced Fitness Card Colors (Better Contrast)
//   static const Color muscleMassOrange = Color(
//     0xFFFF8C42,
//   ); // Brighter, better contrast
//   static const Color muscleMassDark = Color(
//     0xFFE67E30,
//   ); // Darker shade for gradient
//   static const Color bodyFatBlue = Color(
//     0xFF5B9BD5,
//   ); // Better blue for body fat
//   static const Color bodyFatDark = Color(
//     0xFF3B7EBD,
//   ); // Darker blue for gradient
//
//   // 🎨 Card Style Gradients
//   static const LinearGradient weightCardGradient = LinearGradient(
//     colors: [primaryGreen, Color(0xFF2F9B63)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
//
//   static const LinearGradient bodyFatCardGradient = LinearGradient(
//     colors: [bodyFatBlue, bodyFatDark],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
//
//   static const LinearGradient muscleMassCardGradient = LinearGradient(
//     colors: [muscleMassOrange, muscleMassDark],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
// }

// // 🌙 DARK MODE COLORS
// class DarkModeColors {
//   // Base Dark Colors
//   static const Color darkScaffold = Color(0xFF0A0E14); // Very deep blue-black
//   static const Color darkSurface = Color(0xFF151B26); // Card/surface background
//   static const Color darkSurfaceElevated = Color(
//     0xFF1E2530,
//   ); // Elevated surfaces
//
//   // Dark Mode Greens - More vibrant for contrast
//   static const Color darkPrimaryGreen = Color(0xFF5EF38C); // Bright neon green
//   static const Color darkSecondaryGreen = Color(0xFF4ADE80); // Emerald green
//   static const Color darkAccentGreen = Color(0xFF7FFFA8); // Light mint
//
//   // Dark Mode Gradients
//   static const LinearGradient darkBackgroundGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [
//       Color(0xFF0A0E14), // Deep navy black
//       Color(0xFF151B26), // Darker blue-gray
//       Color(0xFF0F1419), // Pure dark
//     ],
//     stops: [0.0, 0.5, 1.0],
//   );
//
//   static const LinearGradient darkLogoGradient = LinearGradient(
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//     colors: [
//       Color(0xFF5EF38C), // Bright green
//       Color(0xFF4ADE80), // Mid green
//       Color(0xFF34D399), // Deep emerald
//     ],
//   );
//
//   static const RadialGradient darkGlowEffect = RadialGradient(
//     center: Alignment.center,
//     radius: 1.2,
//     colors: [
//       Color(0x405EF38C), // Green glow
//       Color(0x204ADE80),
//       Color(0x00000000), // Transparent
//     ],
//     stops: [0.0, 0.5, 1.0],
//   );
//
//   // Text Colors for Dark Mode
//   static const Color darkPrimaryText = Color(0xFFE8EAED);
//   static const Color darkSecondaryText = Color(0xFF9CA3AF);
//   static const Color darkHintText = Color(0xFF6B7280);
//
//   // Shadows for Dark Mode
//   static List<BoxShadow> darkGlowShadow = [
//     BoxShadow(
//       color: const Color(0xFF5EF38C).withOpacity(0.4),
//       blurRadius: 30,
//       spreadRadius: 5,
//       offset: const Offset(0, 0), // Centered glow
//     ),
//     BoxShadow(
//       color: const Color(0xFF4ADE80).withOpacity(0.3),
//       blurRadius: 20,
//       spreadRadius: 2,
//       offset: const Offset(0, 0),
//     ),
//   ];
//
//   static List<BoxShadow> darkCardShadow = [
//     BoxShadow(
//       color: Colors.black.withOpacity(0.4),
//       blurRadius: 20,
//       spreadRadius: 2,
//       offset: const Offset(0, 8),
//     ),
//   ];
// }
class ColorsManager {
  // 🎨 LIGHT MODE COLORS (existing)
  static const Color primaryGreen = Color(0xFF48BB78);
  static const Color secondaryGreen = Color(0xFF38A169);
  static const Color lightGreen = Color(0xFF68D391);
  static const Color darkGreen = Color(0xFF2F855A);

  // Light mode specific
  static const Color lightScaffoldBackground = Colors.white;
  static const Color lightCardBackground = Colors.white;
  static const Color lightPrimaryText = Color(0xFF2D3748);
  static const Color lightSecondaryText = Color(0xFF4A5568);
  static const Color lightInputBackground = Color(0xFFF7FAFC);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // 🌙 DARK MODE COLORS
  static const Color darkScaffold = Color(0xFF0A0E14);
  static const Color darkSurface = Color(0xFF151B26);
  static const Color darkSurfaceElevated = Color(0xFF1E2530);

  // Dark mode greens - More vibrant
  static const Color darkPrimaryGreen = Color(0xFF5EF38C);
  static const Color darkSecondaryGreen = Color(0xFF4ADE80);
  static const Color darkAccentGreen = Color(0xFF7FFFA8);

  // Dark mode text
  static const Color darkPrimaryText = Color(0xFFE8EAED);
  static const Color darkSecondaryText = Color(0xFF9CA3AF);
  static const Color darkHintText = Color(0xFF6B7280);
  static const Color darkInputBackground = Color(0xFF1A1F26);
  static const Color darkBorder = Color(0xFF2D3748);

  // 🎯 ADAPTIVE GETTERS - Auto-switch based on theme
  static Color getScaffoldBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkScaffold
        : lightScaffoldBackground;
  }

  static Color getCardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : lightCardBackground;
  }

  static Color getPrimaryText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimaryText
        : lightPrimaryText;
  }

  static Color getSecondaryText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSecondaryText
        : lightSecondaryText;
  }

  static Color getPrimaryGreen(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkPrimaryGreen
        : primaryGreen;
  }

  static Color getSecondaryGreen(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSecondaryGreen
        : secondaryGreen;
  }

  static Color getInputBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkInputBackground
        : lightInputBackground;
  }

  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  // 🎨 ADAPTIVE GRADIENTS
  static LinearGradient getBackgroundGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0A0E14), Color(0xFF151B26), Color(0xFF0F1419)],
        stops: [0.0, 0.5, 1.0],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF8F9FA), Colors.white, Color(0xFFF8F9FA)],
        stops: [0.0, 0.5, 1.0],
      );
    }
  }

  static LinearGradient getLogoGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF5EF38C), Color(0xFF4ADE80), Color(0xFF34D399)],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF48BB78), Color(0xFF38A169), Color(0xFF2F855A)],
      );
    }
  }

  // 🎨 ADAPTIVE SHADOWS
  static List<BoxShadow> getLogoShadow(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return [
        BoxShadow(
          color: const Color(0xFF5EF38C).withOpacity(0.4),
          blurRadius: 30,
          spreadRadius: 5,
          offset: const Offset(0, 0),
        ),
        BoxShadow(
          color: const Color(0xFF4ADE80).withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 0),
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: primaryGreen.withOpacity(0.3),
          blurRadius: 25,
          spreadRadius: 3,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: lightGreen.withOpacity(0.15),
          blurRadius: 15,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ];
    }
  }

  // Keep all your existing colors and gradients for backward compatibility
  static const Color mintGreen = Color(0xFF81E6D9);
  static const Color forestGreen = Color(0xFF276749);
  static const Color emeraldGreen = Color(0xFF059669);
  static const Color limeGreen = Color(0xFF65D6AD);
  static const Color tealGreen = Color(0xFF319795);
  static const Color seafoamGreen = Color(0xFF4FD1C7);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryGreen, secondaryGreen],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // Add to ColorsManager class
  static LinearGradient getButtonGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5EF38C), // Bright neon green
          Color(0xFF4ADE80), // Mid green
          Color(0xFF34D399), // Deep emerald
        ],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF48BB78), // Primary green
          Color(0xFF38A169), // Secondary green
        ],
      );
    }
  }

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
  static Color getHintTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withOpacity(0.5) : Colors.grey.shade600;
  }

  // 🎨 Adaptive icon color (unfocused state)
  static Color getIconColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withOpacity(0.6) : Colors.grey.shade500;
  }

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
  static const Color inputBorder = Color(0xFFCBD5E0);
  static const Color focusedBorder = primaryGreen;

  // 🎨 Status Colors
  static const Color success = Color(0xFF48BB78);
  // static const Color warning = Color(0xFFFBD38D);
  static const Color warning = Colors.orange;
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

  // Add to ColorsManager class (after line with orange color)

  // 🎨 Enhanced Fitness Card Colors (Better Contrast)
  static const Color muscleMassOrange = Color(
    0xFFFF8C42,
  ); // Brighter, better contrast
  static const Color muscleMassDark = Color(
    0xFFE67E30,
  ); // Darker shade for gradient
  static const Color bodyFatBlue = Color(
    0xFF5B9BD5,
  ); // Better blue for body fat
  static const Color bodyFatDark = Color(
    0xFF3B7EBD,
  ); // Darker blue for gradient

  // 🎨 Card Style Gradients
  static const LinearGradient weightCardGradient = LinearGradient(
    colors: [primaryGreen, Color(0xFF2F9B63)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient bodyFatCardGradient = LinearGradient(
    colors: [bodyFatBlue, bodyFatDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient muscleMassCardGradient = LinearGradient(
    colors: [muscleMassOrange, muscleMassDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
