import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

enum DarkThemeVariant {
  classic, // Your current dark theme (green neon)
  midnight, // Deep blue dark theme
  amoled, // Pure black AMOLED theme
  sunset, // Orange/Purple dark theme
  forest, // Dark green/teal theme
}

extension DarkThemeVariantExtension on DarkThemeVariant {
  String getName(String languageCode) {
    final isArabic = languageCode == 'ar';

    switch (this) {
      case DarkThemeVariant.classic:
        return isArabic ? 'داكن كلاسيكي' : 'Classic Dark';
      case DarkThemeVariant.midnight:
        return isArabic ? 'أزرق منتصف الليل' : 'Midnight Blue';
      case DarkThemeVariant.amoled:
        return isArabic ? 'أسود AMOLED' : 'AMOLED Black';
      case DarkThemeVariant.sunset:
        return isArabic ? 'غروب الشمس' : 'Sunset';
      case DarkThemeVariant.forest:
        return isArabic ? 'ليل الغابة' : 'Forest Night';
    }
  }

  String getDescription(String languageCode) {
    final isArabic = languageCode == 'ar';

    switch (this) {
      case DarkThemeVariant.classic:
        return isArabic
            ? 'لمسات خضراء نيون على خلفية داكنة'
            : 'Neon green accents on dark background';
      case DarkThemeVariant.midnight:
        return isArabic
            ? 'ثيم أزرق داكن للعرض الليلي'
            : 'Deep blue theme for nighttime viewing';
      case DarkThemeVariant.amoled:
        return isArabic
            ? 'أسود نقي لشاشات OLED'
            : 'Pure black for OLED screens';
      case DarkThemeVariant.sunset:
        return isArabic
            ? 'درجات دافئة من البرتقالي والبنفسجي'
            : 'Warm orange and purple tones';
      case DarkThemeVariant.forest:
        return isArabic
            ? 'لمسات زمردية داكنة وتركواز'
            : 'Dark emerald and teal accents';
    }
  }

  // Keep the old getters for backward compatibility
  String get name => getName('en');
  String get description => getDescription('en');

  IconData get icon {
    switch (this) {
      case DarkThemeVariant.classic:
        return Icons.nightlight;
      case DarkThemeVariant.midnight:
        return Icons.nights_stay;
      case DarkThemeVariant.amoled:
        return Icons.dark_mode;
      case DarkThemeVariant.sunset:
        return Icons.wb_twilight;
      case DarkThemeVariant.forest:
        return Icons.forest;
    }
  }

  List<Color> get gradientColors {
    switch (this) {
      case DarkThemeVariant.classic:
        return [const Color(0xFF5EF38C), const Color(0xFF4ADE80)];
      case DarkThemeVariant.midnight:
        return [const Color(0xFF6B8CFF), const Color(0xFF4A5FDC)];
      case DarkThemeVariant.amoled:
        return [Colors.grey.shade400, Colors.grey.shade600];
      case DarkThemeVariant.sunset:
        return [const Color(0xFFFF6B6B), const Color(0xFFB946FF)];
      case DarkThemeVariant.forest:
        return [const Color(0xFF2DD4BF), const Color(0xFF14B8A6)];
    }
  }
}
