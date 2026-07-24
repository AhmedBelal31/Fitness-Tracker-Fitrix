import 'dart:async';
import 'package:fitrix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../enums/animation_type.dart';
import 'app_prefs.dart';
import 'package:intl/intl.dart';

extension LanguageExtension on BuildContext {
  bool get isArabic => Prefs.getData(key: 'language') == "ar";
  bool get isEnglish => Prefs.getData(key: 'language') == "en";
}

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
}

// extension NullableStringExtension on String? {
//   String orLocalizedNA(BuildContext context) {
//     final local = S.of(context);
//     return this.isNullOrEmpty() ? local.not_available : this!;
//   }
// }

extension DateFormatting on DateTime {
  String toApiFormat() {
    return DateFormat('yyyy-MM-dd', 'en_US').format(this);
  }
}

dynamic parseEmptyResponse(dynamic data) {
  if (data == null ||
      data == '' ||
      (data is Map && data.isEmpty) ||
      (data is List && data.isEmpty)) {
    return null;
  } else {
    return data;
  }
}

extension NavigatorExtension on NavigatorState {
  Future<T?> pushWithAnimation<T extends Object?>(
    Widget screen, {
    Duration duration = const Duration(milliseconds: 300),
    AnimationType animationType = AnimationType.slideFromRight,
  }) {
    return push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, _) => screen,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          switch (animationType) {
            case AnimationType.slideFromRight:
              return SlideTransition(
                position: Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              );
            case AnimationType.slideFromBottom:
              return SlideTransition(
                position: Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                    .animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                child: child,
              );
            case AnimationType.scale:
              return ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: child,
              );
            case AnimationType.fade:
              return FadeTransition(opacity: animation, child: child);
          }
        },
      ),
    );
  }
}

extension StringCapitalizeExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension StringPriceFormatter on String {
  String formatToTwoDecimals() {
    try {
      double value = double.parse(this);
      if (value % 1 == 0) {
        return value.toInt().toString();
      } else {
        return value.toStringAsFixed(2);
      }
    } catch (_) {
      return '0';
    }
  }
}

extension DoublePriceFormatter on double {
  String formatToTwoDecimals() {
    if (this == toInt()) {
      return toInt().toString();
    } else {
      return toStringAsFixed(2);
    }
  }
}

extension PercentageExtension on dynamic {
  /// Converts percentage value to double between 0.0 and 100.0
  /// Handles cases where percentage might be:
  /// - Already as percentage (70 = 70%)
  /// - As decimal (0.7 = 70%)
  /// - As integer 1 (1 = 100%)
  double toPercentage() {
    if (this == null) return 0.0;

    double value = 0.0;

    // Convert to double first
    if (this is int) {
      value = (this as int).toDouble();
    } else if (this is double) {
      value = this as double;
    } else if (this is String) {
      value = double.tryParse(this as String) ?? 0.0;
    } else {
      return 0.0;
    }

    // Handle different percentage formats
    if (value <= 1.0 && value >= 0.0) {
      return value * 100.0;
    } else if (value > 1.0) {
      return value.clamp(0.0, 100.0);
    }

    return 0.0;
  }

  /// Converts percentage value to decimal between 0.0 and 1.0
  /// Useful for progress indicators that expect decimal values
  double toDecimal() {
    final percentage = toPercentage();
    return percentage / 100.0;
  }
}

class NavigationBlocker extends StatefulWidget {
  final Widget child;

  const NavigationBlocker({super.key, required this.child});

  @override
  State<NavigationBlocker> createState() => _NavigationBlockerState();
}

class _NavigationBlockerState extends State<NavigationBlocker>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
