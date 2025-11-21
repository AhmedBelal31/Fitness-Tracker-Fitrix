// utils/navigation_helper.dart
import 'package:flutter/material.dart';

extension NavigationHelper on BuildContext {
  // Navigate to a new screen
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  // Navigate and replace current screen
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
    ).pushReplacementNamed<T, TO>(routeName, arguments: arguments);
  }

  // Navigate and clear all previous routes
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil<T>(routeName, predicate, arguments: arguments);
  }

  // Pop current screen
  void pop<T extends Object?>([T? result]) {
    return Navigator.of(this).pop<T>(result);
  }

  // Check if can pop
  bool canPop() {
    return Navigator.of(this).canPop();
  }
}
