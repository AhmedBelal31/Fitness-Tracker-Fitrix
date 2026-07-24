import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// class AppTheme {
//   static String getFontFamily(Locale locale) {
//     if (locale.languageCode == 'ar') {
//       return GoogleFonts.cairo().fontFamily!;
//     } else {
//       return GoogleFonts.montserrat().fontFamily!;
//     }
//   }
//
//   static ThemeData getLightTheme(Locale locale) {
//     final fontFamily = getFontFamily(locale);
//
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       scaffoldBackgroundColor: ColorsManager.lightScaffoldBackground,
//       fontFamily: fontFamily,
//       appBarTheme: AppBarTheme(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         scrolledUnderElevation: 0,
//         titleTextStyle: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: ColorsManager.lightPrimaryText,
//         ),
//         iconTheme: const IconThemeData(color: ColorsManager.lightPrimaryText),
//       ),
//       primaryColor: ColorsManager.primaryGreen,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: ColorsManager.primaryGreen,
//         brightness: Brightness.light,
//         surface: ColorsManager.lightCardBackground,
//       ),
//       cardTheme: CardThemeData(
//         color: ColorsManager.lightCardBackground,
//         elevation: 2,
//         shadowColor: Colors.black.withValues(alpha: 0.08),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: ColorsManager.lightInputBackground,
//         hintStyle: TextStyle(
//           fontFamily: fontFamily,
//           color: Colors.grey.shade600,
//           fontSize: 14,
//         ),
//         labelStyle: TextStyle(
//           fontFamily: fontFamily,
//           color: ColorsManager.lightSecondaryText,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: ColorsManager.lightBorder),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: ColorsManager.lightBorder, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(
//             color: ColorsManager.primaryGreen,
//             width: 2,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: ColorsManager.error, width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: ColorsManager.error, width: 2),
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: ColorsManager.primaryGreen,
//           foregroundColor: Colors.white,
//           textStyle: TextStyle(
//             fontFamily: fontFamily,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 2,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: ColorsManager.primaryGreen,
//           textStyle: TextStyle(
//             fontFamily: fontFamily,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       iconTheme: const IconThemeData(color: ColorsManager.lightPrimaryText),
//       dividerTheme: DividerThemeData(
//         color: ColorsManager.lightBorder,
//         thickness: 1,
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: ColorsManager.lightCardBackground,
//         selectedItemColor: ColorsManager.primaryGreen,
//         unselectedItemColor: ColorsManager.lightSecondaryText,
//         elevation: 8,
//         type: BottomNavigationBarType.fixed,
//       ),
//       dialogTheme: DialogThemeData(
//         backgroundColor: ColorsManager.lightCardBackground,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         elevation: 8,
//       ),
//       textTheme: _buildTextTheme(fontFamily, Brightness.light),
//     );
//   }
//
//   static ThemeData getDarkTheme(Locale locale) {
//     final fontFamily = getFontFamily(locale);
//
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       scaffoldBackgroundColor: ColorsManager.darkScaffold,
//       fontFamily: fontFamily,
//       appBarTheme: AppBarTheme(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         scrolledUnderElevation: 0,
//         titleTextStyle: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: ColorsManager.darkPrimaryText,
//         ),
//         iconTheme: const IconThemeData(color: ColorsManager.darkPrimaryText),
//       ),
//       primaryColor: ColorsManager.darkPrimaryGreen,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: ColorsManager.darkPrimaryGreen,
//         brightness: Brightness.dark,
//         surface: ColorsManager.darkSurface,
//         primary: ColorsManager.darkPrimaryGreen,
//         secondary: ColorsManager.darkSecondaryGreen,
//         error: const Color(0xFFFF6B6B),
//       ),
//       cardTheme: CardThemeData(
//         color: ColorsManager.darkSurface,
//         elevation: 4,
//         shadowColor: Colors.black.withValues(alpha: 0.4),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       ),
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: ColorsManager.darkInputBackground,
//         hintStyle: TextStyle(
//           fontFamily: fontFamily,
//           color: ColorsManager.darkHintText,
//           fontSize: 14,
//         ),
//         labelStyle: TextStyle(
//           fontFamily: fontFamily,
//           color: ColorsManager.darkSecondaryText,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: ColorsManager.darkBorder),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: BorderSide(color: ColorsManager.darkBorder, width: 1),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(
//             color: ColorsManager.darkPrimaryGreen,
//             width: 2,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16),
//           borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
//         ),
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: ColorsManager.darkPrimaryGreen,
//           foregroundColor: ColorsManager.darkScaffold,
//           textStyle: TextStyle(
//             fontFamily: fontFamily,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           elevation: 2,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//         ),
//       ),
//       textButtonTheme: TextButtonThemeData(
//         style: TextButton.styleFrom(
//           foregroundColor: ColorsManager.darkPrimaryGreen,
//           textStyle: TextStyle(
//             fontFamily: fontFamily,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       iconTheme: const IconThemeData(color: ColorsManager.darkPrimaryText),
//       dividerTheme: DividerThemeData(
//         color: ColorsManager.darkBorder,
//         thickness: 1,
//       ),
//       bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//         backgroundColor: ColorsManager.darkSurface,
//         selectedItemColor: ColorsManager.darkPrimaryGreen,
//         unselectedItemColor: ColorsManager.darkHintText,
//         elevation: 8,
//         type: BottomNavigationBarType.fixed,
//       ),
//       dialogTheme: DialogThemeData(
//         backgroundColor: ColorsManager.darkSurface,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         elevation: 8,
//       ),
//       textTheme: _buildTextTheme(fontFamily, Brightness.dark),
//     );
//   }
//
//   static TextTheme _buildTextTheme(String fontFamily, Brightness brightness) {
//     final textColor = brightness == Brightness.light
//         ? ColorsManager.lightPrimaryText
//         : ColorsManager.darkPrimaryText;
//
//     final secondaryColor = brightness == Brightness.light
//         ? ColorsManager.lightSecondaryText
//         : ColorsManager.darkSecondaryText;
//
//     return TextTheme(
//       displayLarge: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 32,
//         fontWeight: FontWeight.bold,
//         color: textColor,
//         letterSpacing: 0.5,
//       ),
//       displayMedium: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 28,
//         fontWeight: FontWeight.bold,
//         color: textColor,
//         letterSpacing: 0.5,
//       ),
//       displaySmall: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: textColor,
//         letterSpacing: 0.3,
//       ),
//       headlineLarge: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 22,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//         letterSpacing: 0.3,
//       ),
//       headlineMedium: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 20,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//         letterSpacing: 0.3,
//       ),
//       headlineSmall: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 18,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//         letterSpacing: 0.3,
//       ),
//       bodyLarge: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 16,
//         fontWeight: FontWeight.normal,
//         color: textColor,
//         height: 1.5,
//       ),
//       bodyMedium: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 14,
//         fontWeight: FontWeight.normal,
//         color: textColor,
//         height: 1.5,
//       ),
//       bodySmall: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 12,
//         fontWeight: FontWeight.normal,
//         color: secondaryColor,
//         height: 1.4,
//       ),
//       labelLarge: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 14,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//         letterSpacing: 0.3,
//       ),
//       labelMedium: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 12,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//         letterSpacing: 0.3,
//       ),
//       labelSmall: TextStyle(
//         fontFamily: fontFamily,
//         fontSize: 11,
//         fontWeight: FontWeight.w500,
//         color: secondaryColor,
//         letterSpacing: 0.5,
//       ),
//     );
//   }
// }

import 'dark_theme_variant.dart';

class AppTheme {
  static String getFontFamily(Locale locale) {
    if (locale.languageCode == 'ar') {
      return GoogleFonts.cairo().fontFamily!;
    } else {
      return GoogleFonts.montserrat().fontFamily!;
    }
  }

  static ThemeData getLightTheme(Locale locale) {
    final fontFamily = getFontFamily(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorsManager.lightScaffoldBackground,
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsManager.lightPrimaryText,
        ),
        iconTheme: const IconThemeData(color: ColorsManager.lightPrimaryText),
      ),
      primaryColor: ColorsManager.primaryGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.primaryGreen,
        brightness: Brightness.light,
        surface: ColorsManager.lightCardBackground,
        primary: ColorsManager.primaryGreen,
        secondary: ColorsManager.secondaryGreen,
        tertiary: ColorsManager.lightGreen,
        error: ColorsManager.error,
      ),
      cardTheme: CardThemeData(
        color: ColorsManager.lightCardBackground,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.lightInputBackground,
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          color: Colors.grey.shade600,
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          color: ColorsManager.lightSecondaryText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.lightBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ColorsManager.primaryGreen,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorsManager.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: ColorsManager.error, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          foregroundColor: Colors.white,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorsManager.primaryGreen,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: ColorsManager.lightPrimaryText),
      dividerTheme: DividerThemeData(
        color: ColorsManager.lightBorder,
        thickness: 1,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.lightCardBackground,
        selectedItemColor: ColorsManager.primaryGreen,
        unselectedItemColor: ColorsManager.lightSecondaryText,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorsManager.lightCardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
      ),
      textTheme: _buildTextTheme(fontFamily, Brightness.light),
    );
  }

  /// Get dark theme with specific variant
  static ThemeData getDarkTheme(
    Locale locale, {
    DarkThemeVariant variant = DarkThemeVariant.classic,
  }) {
    final fontFamily = getFontFamily(locale);

    // Get colors based on variant
    final scaffoldColor = _getDarkScaffoldColor(variant);
    final surfaceColor = _getDarkSurfaceColor(variant);
    final primaryColor = _getDarkPrimaryColor(variant);
    final secondaryColor = _getDarkSecondaryColor(variant);
    final accentColor = _getDarkAccentColor(variant);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: scaffoldColor,
      fontFamily: fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsManager.darkPrimaryText,
        ),
        iconTheme: const IconThemeData(color: ColorsManager.darkPrimaryText),
      ),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        surface: surfaceColor,
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: accentColor,
        error: const Color(0xFFFF6B6B),
        surfaceContainerHighest: _getDarkSurfaceElevatedColor(variant),
      ),
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.darkInputBackground,
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          color: ColorsManager.darkHintText,
          fontSize: 14,
        ),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          color: ColorsManager.darkSecondaryText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.darkBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: _getButtonTextColor(variant),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: ColorsManager.darkPrimaryText),
      dividerTheme: DividerThemeData(
        color: ColorsManager.darkBorder,
        thickness: 1,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: ColorsManager.darkHintText,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
      ),
      textTheme: _buildTextTheme(fontFamily, Brightness.dark),
    );
  }

  // Helper methods to get variant-specific colors
  static Color _getDarkScaffoldColor(DarkThemeVariant variant) {
    switch (variant) {
      case DarkThemeVariant.classic:
        return ColorsManager.classicDarkScaffold;
      case DarkThemeVariant.midnight:
        return ColorsManager.midnightDarkScaffold;
      case DarkThemeVariant.amoled:
        return ColorsManager.amoledDarkScaffold;
      case DarkThemeVariant.sunset:
        return ColorsManager.sunsetDarkScaffold;
      case DarkThemeVariant.forest:
        return ColorsManager.forestDarkScaffold;
    }
  }

  static Color _getDarkSurfaceColor(DarkThemeVariant variant) {
    switch (variant) {
      case DarkThemeVariant.classic:
        return ColorsManager.classicDarkSurface;
      case DarkThemeVariant.midnight:
        return ColorsManager.midnightDarkSurface;
      case DarkThemeVariant.amoled:
        return ColorsManager.amoledDarkSurface;
      case DarkThemeVariant.sunset:
        return ColorsManager.sunsetDarkSurface;
      case DarkThemeVariant.forest:
        return ColorsManager.forestDarkSurface;
    }
  }

  static Color _getDarkSurfaceElevatedColor(DarkThemeVariant variant) {
    switch (variant) {
      case DarkThemeVariant.classic:
        return ColorsManager.classicDarkSurfaceElevated;
      case DarkThemeVariant.midnight:
        return ColorsManager.midnightDarkSurfaceElevated;
      case DarkThemeVariant.amoled:
        return ColorsManager.amoledDarkSurfaceElevated;
      case DarkThemeVariant.sunset:
        return ColorsManager.sunsetDarkSurfaceElevated;
      case DarkThemeVariant.forest:
        return ColorsManager.forestDarkSurfaceElevated;
    }
  }

  static Color _getDarkPrimaryColor(DarkThemeVariant variant) {
    switch (variant) {
      case DarkThemeVariant.classic:
        return ColorsManager.classicDarkPrimaryGreen;
      case DarkThemeVariant.midnight:
        return ColorsManager.midnightDarkPrimary;
      case DarkThemeVariant.amoled:
        return ColorsManager.amoledDarkPrimary;
      case DarkThemeVariant.sunset:
        return ColorsManager.sunsetDarkPrimary;
      case DarkThemeVariant.forest:
        return ColorsManager.forestDarkPrimary;
    }
  }

  static Color _getDarkSecondaryColor(DarkThemeVariant variant) {
    switch (variant) {
      case DarkThemeVariant.classic:
        return ColorsManager.classicDarkSecondaryGreen;
      case DarkThemeVariant.midnight:
        return ColorsManager.midnightDarkSecondary;
      case DarkThemeVariant.amoled:
        return ColorsManager.amoledDarkSecondary;
      case DarkThemeVariant.sunset:
        return ColorsManager.sunsetDarkSecondary;
      case DarkThemeVariant.forest:
        return ColorsManager.forestDarkSecondary;
    }
  }

  static Color _getDarkAccentColor(DarkThemeVariant variant) {
    switch (variant) {
      case DarkThemeVariant.classic:
        return ColorsManager.classicDarkAccentGreen;
      case DarkThemeVariant.midnight:
        return ColorsManager.midnightDarkAccent;
      case DarkThemeVariant.amoled:
        return ColorsManager.amoledDarkAccent;
      case DarkThemeVariant.sunset:
        return ColorsManager.sunsetDarkAccent;
      case DarkThemeVariant.forest:
        return ColorsManager.forestDarkAccent;
    }
  }

  static Color _getButtonTextColor(DarkThemeVariant variant) {
    // AMOLED and Sunset variants look better with white text on buttons
    if (variant == DarkThemeVariant.amoled) {
      return Colors.white;
    }
    // For other variants, use dark scaffold color for contrast
    return _getDarkScaffoldColor(variant);
  }

  static TextTheme _buildTextTheme(String fontFamily, Brightness brightness) {
    final textColor = brightness == Brightness.light
        ? ColorsManager.lightPrimaryText
        : ColorsManager.darkPrimaryText;

    final secondaryColor = brightness == Brightness.light
        ? ColorsManager.lightSecondaryText
        : ColorsManager.darkSecondaryText;

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.5,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.5,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: 0.3,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: secondaryColor,
        height: 1.4,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.3,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
    );
  }
}
