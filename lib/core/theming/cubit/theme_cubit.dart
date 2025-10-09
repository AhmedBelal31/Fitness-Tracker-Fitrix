import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial()) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeKey) ?? 'dark';

    final appThemeMode = AppThemeMode.values.firstWhere(
      (mode) => mode.name == themeModeString,
      orElse: () => AppThemeMode.dark,
    );

    _applyTheme(appThemeMode);
  }

  Future<void> setTheme(AppThemeMode appThemeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, appThemeMode.name);
    _applyTheme(appThemeMode);
  }

  void _applyTheme(AppThemeMode appThemeMode) {
    ThemeMode themeMode;

    switch (appThemeMode) {
      case AppThemeMode.light:
        themeMode = ThemeMode.light;
        break;
      case AppThemeMode.dark:
        themeMode = ThemeMode.dark;
        break;
      case AppThemeMode.system:
        themeMode = ThemeMode.system;
        break;
    }

    emit(state.copyWith(themeMode: themeMode, appThemeMode: appThemeMode));
  }

  void toggleTheme() {
    final newMode = state.appThemeMode == AppThemeMode.dark
        ? AppThemeMode.light
        : AppThemeMode.dark;
    setTheme(newMode);
  }
}
