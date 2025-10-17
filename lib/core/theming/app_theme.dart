import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // ✅ Get font family based on locale
  static String getFontFamily(Locale locale) {
    if (locale.languageCode == 'ar') {
      return GoogleFonts.cairo().fontFamily!;
    } else {
      return GoogleFonts.montserrat().fontFamily!;
    }
  }

  // ✅ Light theme with locale-specific font
  static ThemeData getLightTheme(Locale locale) {
    final fontFamily = getFontFamily(locale);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: ColorsManager.scaffoldBackground,

      // ✅ Apply font family to entire app
      fontFamily: fontFamily,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
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
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: ColorsManager.primaryText,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ColorsManager.primaryText,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorsManager.primaryText,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: ColorsManager.primaryText,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ColorsManager.primaryText,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorsManager.primaryText,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: ColorsManager.primaryText,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: ColorsManager.primaryText,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: ColorsManager.primaryText,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: ColorsManager.primaryText,
        ),
      ),
    );
  }
}
