import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/theme_cubit.dart';
import 'dark_theme_variant.dart';

class ColorsManager {
  // 🎨 LIGHT MODE COLORS
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
  static const Color warningYellow = Color(0xFFFBBF24); // Add this

  // Light mode specific
  static const Color lightScaffoldBackground = Colors.white;
  static const Color lightCardBackground = Colors.white;
  static const Color lightPrimaryText = Color(0xFF2D3748);
  static const Color lightSecondaryText = Color(0xFF4A5568);
  static const Color lightInputBackground = Color(0xFFF7FAFC);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // 🌙 DARK MODE COLOR VARIANTS

  // ===== Classic Dark (Default - Neon Green) =====
  static const Color classicDarkScaffold = Color(0xFF0A0E14);
  static const Color classicDarkSurface = Color(0xFF151B26);
  static const Color classicDarkSurfaceElevated = Color(0xFF1E2530);
  static const Color classicDarkPrimaryGreen = Color(0xFF5EF38C);
  static const Color classicDarkSecondaryGreen = Color(0xFF4ADE80);
  static const Color classicDarkAccentGreen = Color(0xFF7FFFA8);

  // ===== Midnight Blue Dark =====
  static const Color midnightDarkScaffold = Color(0xFF0D1117);
  static const Color midnightDarkSurface = Color(0xFF161B22);
  static const Color midnightDarkSurfaceElevated = Color(0xFF21262D);
  static const Color midnightDarkPrimary = Color(0xFF6B8CFF);
  static const Color midnightDarkSecondary = Color(0xFF4A5FDC);
  static const Color midnightDarkAccent = Color(0xFF8BA3FF);

  // ===== AMOLED Black =====
  static const Color amoledDarkScaffold = Color(0xFF000000);
  static const Color amoledDarkSurface = Color(0xFF0A0A0A);
  static const Color amoledDarkSurfaceElevated = Color(0xFF151515);
  static const Color amoledDarkPrimary = Color(0xFF90CAF9);
  static const Color amoledDarkSecondary = Color(0xFF64B5F6);
  static const Color amoledDarkAccent = Color(0xFFBBDEFB);

  // ===== Sunset Dark =====
  static const Color sunsetDarkScaffold = Color(0xFF1A0A14);
  static const Color sunsetDarkSurface = Color(0xFF2A1426);
  static const Color sunsetDarkSurfaceElevated = Color(0xFF3A1E36);
  static const Color sunsetDarkPrimary = Color(0xFFFF6B6B);
  static const Color sunsetDarkSecondary = Color(0xFFB946FF);
  static const Color sunsetDarkAccent = Color(0xFFFF9A9A);

  // ===== Forest Night Dark =====
  static const Color forestDarkScaffold = Color(0xFF0A1410);
  static const Color forestDarkSurface = Color(0xFF0F1E1A);
  static const Color forestDarkSurfaceElevated = Color(0xFF152824);
  static const Color forestDarkPrimary = Color(0xFF2DD4BF);
  static const Color forestDarkSecondary = Color(0xFF14B8A6);
  static const Color forestDarkAccent = Color(0xFF5EEAD4);

  // Dark mode text (shared across all dark variants)
  static const Color darkPrimaryText = Color(0xFFE8EAED);
  static const Color darkSecondaryText = Color(0xFF9CA3AF);
  static const Color darkHintText = Color(0xFF6B7280);
  static const Color darkInputBackground = Color(0xFF1A1F26);
  static const Color darkBorder = Color(0xFF2D3748);

  // 🔄 BACKWARD COMPATIBILITY ALIASES
  static const Color darkScaffold = classicDarkScaffold;
  static const Color darkSurface = classicDarkSurface;
  static const Color darkSurfaceElevated = classicDarkSurfaceElevated;
  static const Color darkPrimaryGreen = classicDarkPrimaryGreen;
  static const Color darkSecondaryGreen = classicDarkSecondaryGreen;
  static const Color darkAccentGreen = classicDarkAccentGreen;

  // 🎯 ADAPTIVE GETTERS WITH VARIANT SUPPORT

  static Color getScaffoldBackground(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return classicDarkScaffold;
        case DarkThemeVariant.midnight:
          return midnightDarkScaffold;
        case DarkThemeVariant.amoled:
          return amoledDarkScaffold;
        case DarkThemeVariant.sunset:
          return sunsetDarkScaffold;
        case DarkThemeVariant.forest:
          return forestDarkScaffold;
      }
    }
    return lightScaffoldBackground;
  }

  static Color getCardBackground(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return classicDarkSurface;
        case DarkThemeVariant.midnight:
          return midnightDarkSurface;
        case DarkThemeVariant.amoled:
          return amoledDarkSurface;
        case DarkThemeVariant.sunset:
          return sunsetDarkSurface;
        case DarkThemeVariant.forest:
          return forestDarkSurface;
      }
    }
    return lightCardBackground;
  }

  static Color getSurfaceElevated(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return classicDarkSurfaceElevated;
        case DarkThemeVariant.midnight:
          return midnightDarkSurfaceElevated;
        case DarkThemeVariant.amoled:
          return amoledDarkSurfaceElevated;
        case DarkThemeVariant.sunset:
          return sunsetDarkSurfaceElevated;
        case DarkThemeVariant.forest:
          return forestDarkSurfaceElevated;
      }
    }
    return grey100;
  }

  static Color getPrimaryGreen(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return classicDarkPrimaryGreen;
        case DarkThemeVariant.midnight:
          return midnightDarkPrimary;
        case DarkThemeVariant.amoled:
          return amoledDarkPrimary;
        case DarkThemeVariant.sunset:
          return sunsetDarkPrimary;
        case DarkThemeVariant.forest:
          return forestDarkPrimary;
      }
    }
    return primaryGreen;
  }

  static Color getSecondaryGreen(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return classicDarkSecondaryGreen;
        case DarkThemeVariant.midnight:
          return midnightDarkSecondary;
        case DarkThemeVariant.amoled:
          return amoledDarkSecondary;
        case DarkThemeVariant.sunset:
          return sunsetDarkSecondary;
        case DarkThemeVariant.forest:
          return forestDarkSecondary;
      }
    }
    return secondaryGreen;
  }

  static Color getAccentColor(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    if (Theme.of(context).brightness == Brightness.dark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return classicDarkAccentGreen;
        case DarkThemeVariant.midnight:
          return midnightDarkAccent;
        case DarkThemeVariant.amoled:
          return amoledDarkAccent;
        case DarkThemeVariant.sunset:
          return sunsetDarkAccent;
        case DarkThemeVariant.forest:
          return forestDarkAccent;
      }
    }
    return lightGreen;
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

  static Color getHintTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? darkHintText : grey500;
  }

  static Color getIconColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? Colors.white.withOpacity(0.6) : grey500;
  }

  // 🎨 ADAPTIVE GRADIENTS WITH VARIANTS

  static LinearGradient getBackgroundGradient(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0E14), Color(0xFF151B26), Color(0xFF0F1419)],
            stops: [0.0, 0.5, 1.0],
          );
        case DarkThemeVariant.midnight:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D1117), Color(0xFF161B22), Color(0xFF0D1117)],
            stops: [0.0, 0.5, 1.0],
          );
        case DarkThemeVariant.amoled:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF000000), Color(0xFF0A0A0A), Color(0xFF000000)],
            stops: [0.0, 0.5, 1.0],
          );
        case DarkThemeVariant.sunset:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A0A14), Color(0xFF2A1426), Color(0xFF1A0A14)],
            stops: [0.0, 0.5, 1.0],
          );
        case DarkThemeVariant.forest:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A1410), Color(0xFF0F1E1A), Color(0xFF0A1410)],
            stops: [0.0, 0.5, 1.0],
          );
      }
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF8F9FA), Colors.white, Color(0xFFF8F9FA)],
        stops: [0.0, 0.5, 1.0],
      );
    }
  }

  static LinearGradient getLogoGradient(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5EF38C), Color(0xFF4ADE80), Color(0xFF34D399)],
          );
        case DarkThemeVariant.midnight:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6B8CFF), Color(0xFF4A5FDC), Color(0xFF3B4DCC)],
          );
        case DarkThemeVariant.amoled:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF90CAF9), Color(0xFF64B5F6), Color(0xFF42A5F5)],
          );
        case DarkThemeVariant.sunset:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B6B), Color(0xFFB946FF), Color(0xFF9D36E0)],
          );
        case DarkThemeVariant.forest:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2DD4BF), Color(0xFF14B8A6), Color(0xFF0D9488)],
          );
      }
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF48BB78), Color(0xFF38A169), Color(0xFF2F855A)],
      );
    }
  }

  static LinearGradient getButtonGradient(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      switch (activeVariant) {
        case DarkThemeVariant.classic:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF5EF38C), Color(0xFF4ADE80), Color(0xFF34D399)],
          );
        case DarkThemeVariant.midnight:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6B8CFF), Color(0xFF4A5FDC)],
          );
        case DarkThemeVariant.amoled:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF90CAF9), Color(0xFF64B5F6)],
          );
        case DarkThemeVariant.sunset:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF6B6B), Color(0xFFB946FF)],
          );
        case DarkThemeVariant.forest:
          return const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2DD4BF), Color(0xFF14B8A6)],
          );
      }
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF48BB78), Color(0xFF38A169)],
      );
    }
  }

  // 🎨 ADAPTIVE SHADOWS

  static List<BoxShadow> getLogoShadow(
    BuildContext context, {
    DarkThemeVariant? variant,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (isDark) {
      final activeVariant = variant ?? _getDarkThemeVariant(context);
      Color glowColor;

      switch (activeVariant) {
        case DarkThemeVariant.classic:
          glowColor = classicDarkPrimaryGreen;
          break;
        case DarkThemeVariant.midnight:
          glowColor = midnightDarkPrimary;
          break;
        case DarkThemeVariant.amoled:
          glowColor = amoledDarkPrimary;
          break;
        case DarkThemeVariant.sunset:
          glowColor = sunsetDarkPrimary;
          break;
        case DarkThemeVariant.forest:
          glowColor = forestDarkPrimary;
          break;
      }

      return [
        BoxShadow(
          color: glowColor.withOpacity(0.4),
          blurRadius: 30,
          spreadRadius: 5,
          offset: const Offset(0, 0),
        ),
        BoxShadow(
          color: glowColor.withOpacity(0.3),
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

  // Helper method to get current dark theme variant from context
  static DarkThemeVariant _getDarkThemeVariant(BuildContext context) {
    try {
      final themeCubit = context.read<ThemeCubit>();
      return themeCubit.state.darkThemeVariant;
    } catch (e) {
      return DarkThemeVariant.classic; // Fallback
    }
  }

  // 🎨 STATIC GRADIENTS (Backward Compatibility)

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

  // 🧱 STATIC SHADOWS

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

  // 🎨 TEXT COLORS

  static const Color primaryText = Color(0xFF2D3748);
  static const Color secondaryText = Color(0xFF4A5568);
  static const Color lightText = Color(0xFF718096);
  static const Color placeholderText = Color(0xFF9CA3AF);
  static const Color whiteText = Colors.white;

  // 🎨 BACKGROUND COLORS

  static const Color scaffoldBackground = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color inputBackground = Color(0xFFF7FAFC);
  static const Color overlayBackground = Color(0x80000000);

  // 🎨 BORDER COLORS

  static const Color primaryBorder = primaryGreen;
  static const Color inputBorder = Color(0xFFCBD5E0);
  static const Color focusedBorder = primaryGreen;

  // 🎨 STATUS COLORS

  static const Color success = Color(0xFF48BB78);
  static const Color warning = Colors.orange;
  static const Color error = Color(0xFFE53E3E);
  static const Color info = Color(0xFF4299E1);

  // 🎨 STANDARD COLORS

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Color(0xFFE53E3E);
  static const Color darkRed = Color(0xFFC53030);
  static const Color blue = Color(0xFF4299E1);
  static const Color yellow = Color(0xFFFBD38D);
  static const Color orange = Color(0xFFED8936);

  // 🎨 GREY SCALE

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

  // 🎨 LEGACY COLORS (Backward Compatibility)

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

  // 🎨 FITNESS-SPECIFIC COLORS

  static const Color caloriesBurned = Color(0xFFFF6B6B);
  static const Color stepsColor = Color(0xFF4ECDC4);
  static const Color waterIntake = Color(0xFF45B7D1);
  static const Color workoutTime = Color(0xFF96CEB4);
  static const Color heartRate = Color(0xFFFF7675);
  static const Color proteinColor = Color(0xFFD63031);
  static const Color carbsColor = Color(0xFFE17055);
  static const Color fatsColor = Color(0xFFF39C12);

  // 🎨 PROGRESS COLORS

  static const Color progressLow = Color(0xFFFF7675);
  static const Color progressMedium = Color(0xFFFFDA79);
  static const Color progressHigh = Color(0xFF00B894);
  static const Color progressComplete = primaryGreen;

  // 🎨 DIFFICULTY LEVELS

  static const Color beginnerLevel = Color(0xFF74B9FF);
  static const Color intermediateLevel = Color(0xFFFFDA79);
  static const Color advancedLevel = Color(0xFFFF7675);
  static const Color expertLevel = Color(0xFF6C5CE7);

  // 🎨 ENHANCED FITNESS CARD COLORS

  static const Color muscleMassOrange = Color(0xFFFF8C42);
  static const Color muscleMassDark = Color(0xFFE67E30);
  static const Color bodyFatBlue = Color(0xFF5B9BD5);
  static const Color bodyFatDark = Color(0xFF3B7EBD);

  static const Color buttonDisabledBackground = Color(0xFF444444);
  static const Color darkCardBackground = classicDarkSurface;

  // 🎨 CARD STYLE GRADIENTS

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

  // 🎯 HELPER METHODS

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
