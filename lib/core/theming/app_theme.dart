import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: ColorsManager.primaryGreen,
      scaffoldBackgroundColor: ColorsManager.lightScaffoldBackground,
      fontFamily: GoogleFonts.montserrat().fontFamily,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.lightScaffoldBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.primaryGreen),
        titleTextStyle: TextStyle(
          color: ColorsManager.lightPrimaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsManager.primaryGreen,
          side: const BorderSide(color: ColorsManager.primaryGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorsManager.primaryGreen,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.error, width: 2),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: ColorsManager.primaryGreen),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: ColorsManager.primaryGreen,
        unselectedItemColor: Colors.grey,
        elevation: 8,
      ),

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: ColorsManager.primaryGreen,
        secondary: ColorsManager.primaryGreen,
        surface: Colors.white,
        error: ColorsManager.error,
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: ColorsManager.primaryGreen,
      scaffoldBackgroundColor: ColorsManager.scaffoldBackground,
      fontFamily: GoogleFonts.montserrat().fontFamily,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorsManager.scaffoldBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.primaryGreen),
        titleTextStyle: TextStyle(
          color: ColorsManager.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: ColorsManager.cardBackground,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryGreen,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsManager.primaryGreen,
          side: const BorderSide(color: ColorsManager.primaryGreen, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorsManager.cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ColorsManager.primaryGreen,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ColorsManager.error, width: 2),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: ColorsManager.primaryGreen),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.cardBackground,
        selectedItemColor: ColorsManager.primaryGreen,
        unselectedItemColor: ColorsManager.lightText,
        elevation: 8,
      ),

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: ColorsManager.primaryGreen,
        secondary: ColorsManager.primaryGreen,
        surface: ColorsManager.cardBackground,
        error: ColorsManager.error,
      ),
    );
  }
}
