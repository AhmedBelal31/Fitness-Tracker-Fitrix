import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

// class AppTheme {
//   // ✅ Get font family based on locale
//   static String getFontFamily(Locale locale) {
//     if (locale.languageCode == 'ar') {
//       return GoogleFonts.cairo().fontFamily!;
//     } else {
//       return GoogleFonts.montserrat().fontFamily!;
//     }
//   }
//
//   // ✅ Light theme with locale-specific font
//   static ThemeData getLightTheme(Locale locale) {
//     final fontFamily = getFontFamily(locale);
//
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
//
//       // ✅ Apply font family to entire app
//       fontFamily: fontFamily,
//
//       // AppBar Theme
//       appBarTheme: AppBarTheme(
//         backgroundColor: ColorsManager.scaffoldBackground,
//         elevation: 0,
//         titleTextStyle: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: ColorsManager.primaryText,
//         ),
//         iconTheme: const IconThemeData(color: ColorsManager.primaryText),
//       ),
//
//       // Primary Color
//       primaryColor: ColorsManager.primaryGreen,
//       colorScheme: ColorScheme.fromSeed(
//         seedColor: ColorsManager.primaryGreen,
//         brightness: Brightness.light,
//       ),
//
//       // Input Decoration Theme
//       inputDecorationTheme: InputDecorationTheme(
//         filled: true,
//         fillColor: ColorsManager.inputBackground,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         hintStyle: TextStyle(fontFamily: fontFamily, color: Colors.grey[600]),
//       ),
//
//       // Button Theme
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: ColorsManager.primaryGreen,
//           textStyle: TextStyle(
//             fontFamily: fontFamily,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//
//       // Text Theme
//       textTheme: TextTheme(
//         displayLarge: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 32,
//           fontWeight: FontWeight.bold,
//           color: ColorsManager.primaryText,
//         ),
//         displayMedium: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 28,
//           fontWeight: FontWeight.bold,
//           color: ColorsManager.primaryText,
//         ),
//         displaySmall: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: ColorsManager.primaryText,
//         ),
//         headlineLarge: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 22,
//           fontWeight: FontWeight.w600,
//           color: ColorsManager.primaryText,
//         ),
//         headlineMedium: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 20,
//           fontWeight: FontWeight.w600,
//           color: ColorsManager.primaryText,
//         ),
//         headlineSmall: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 18,
//           fontWeight: FontWeight.w600,
//           color: ColorsManager.primaryText,
//         ),
//         bodyLarge: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 16,
//           fontWeight: FontWeight.normal,
//           color: ColorsManager.primaryText,
//         ),
//         bodyMedium: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 14,
//           fontWeight: FontWeight.normal,
//           color: ColorsManager.primaryText,
//         ),
//         bodySmall: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 12,
//           fontWeight: FontWeight.normal,
//           color: ColorsManager.primaryText,
//         ),
//         labelLarge: TextStyle(
//           fontFamily: fontFamily,
//           fontSize: 14,
//           fontWeight: FontWeight.w600,
//           color: ColorsManager.primaryText,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ✅ Get font family based on locale
  static String getFontFamily(Locale locale) {
    if (locale.languageCode == 'ar') {
      return GoogleFonts.cairo().fontFamily!;
    } else {
      return GoogleFonts.montserrat().fontFamily!;
    }
  }

  // ✅ Light theme
  static ThemeData getLightTheme(Locale locale) {
    final fontFamily = getFontFamily(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
      fontFamily: fontFamily,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorsManager.primaryText,
        ),
        iconTheme: const IconThemeData(color: ColorsManager.primaryText),
      ),

      // Primary Color
      primaryColor: ColorsManager.primaryGreen,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.primaryGreen,
        brightness: Brightness.light,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: ColorsManager.cardBackground,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(fontFamily: fontFamily, color: Colors.grey[600]),
      ),

      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Theme
      textTheme: _buildTextTheme(fontFamily, Brightness.light),
    );
  }

  // ✅ DARK THEME - Elegant & Modern
  static ThemeData getDarkTheme(Locale locale) {
    final fontFamily = getFontFamily(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0F1419), // Deep dark background
      fontFamily: fontFamily,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF0F1419),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFE8EAED), // Light text
        ),
        iconTheme: const IconThemeData(color: Color(0xFFE8EAED)),
      ),

      // Primary Color - Vibrant green for dark mode
      primaryColor: const Color(0xFF4ADE80), // Brighter green
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4ADE80),
        brightness: Brightness.dark,
        background: const Color(0xFF0F1419),
        surface: const Color(0xFF1A1F26), // Card background
        primary: const Color(0xFF4ADE80),
        secondary: const Color(0xFF38A169),
        error: const Color(0xFFFF6B6B),
      ),

      // Card Theme - Elevated dark cards
      cardTheme: CardThemeData(
        color: const Color(0xFF1A1F26),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Input Decoration Theme - Dark inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1A1F26),
        hintStyle: TextStyle(
          fontFamily: fontFamily,
          color: const Color(0xFF6B7280),
        ),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          color: const Color(0xFF9CA3AF),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D3748)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D3748)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF4ADE80), width: 2),
        ),
      ),

      // Button Theme - Vibrant green buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4ADE80),
          foregroundColor: const Color(0xFF0F1419),
          textStyle: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: Color(0xFFE8EAED)),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: Color(0xFF2D3748),
        thickness: 1,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1A1F26),
        selectedItemColor: Color(0xFF4ADE80),
        unselectedItemColor: Color(0xFF6B7280),
        elevation: 8,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF1A1F26),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Text Theme
      textTheme: _buildTextTheme(fontFamily, Brightness.dark),
    );
  }

  // ✅ Build text theme based on brightness
  static TextTheme _buildTextTheme(String fontFamily, Brightness brightness) {
    final textColor = brightness == Brightness.light
        ? const Color(0xFF2D3748)
        : const Color(0xFFE8EAED);

    final secondaryColor = brightness == Brightness.light
        ? const Color(0xFF4A5568)
        : const Color(0xFF9CA3AF);

    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}
