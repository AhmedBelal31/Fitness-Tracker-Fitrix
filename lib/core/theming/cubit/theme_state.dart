import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// enum AppThemeMode { light, dark, system }

// class ThemeState extends Equatable {
//   final ThemeMode themeMode;
//   final AppThemeMode appThemeMode;
//
//   const ThemeState({required this.themeMode, required this.appThemeMode});
//
//   factory ThemeState.initial() {
//     return const ThemeState(
//       themeMode: ThemeMode.dark,
//       appThemeMode: AppThemeMode.dark,
//     );
//   }
//
//   ThemeState copyWith({ThemeMode? themeMode, AppThemeMode? appThemeMode}) {
//     return ThemeState(
//       themeMode: themeMode ?? this.themeMode,
//       appThemeMode: appThemeMode ?? this.appThemeMode,
//     );
//   }
//
//   @override
//   List<Object?> get props => [themeMode, appThemeMode];
// }
import 'package:equatable/equatable.dart';
import '../dark_theme_variant.dart';

enum AppThemeMode { light, dark, system }

class ThemeState extends Equatable {
  final AppThemeMode appThemeMode;
  final DarkThemeVariant darkThemeVariant;

  const ThemeState({
    required this.appThemeMode,
    this.darkThemeVariant = DarkThemeVariant.classic,
  });

  ThemeState copyWith({
    AppThemeMode? appThemeMode,
    DarkThemeVariant? darkThemeVariant,
  }) {
    return ThemeState(
      appThemeMode: appThemeMode ?? this.appThemeMode,
      darkThemeVariant: darkThemeVariant ?? this.darkThemeVariant,
    );
  }

  @override
  List<Object?> get props => [appThemeMode, darkThemeVariant];
}
