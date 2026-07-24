import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState(this.locale);

  factory LocaleState.initial() {
    return const LocaleState(Locale('en'));
  }

  LocaleState copyWith({Locale? locale}) {
    return LocaleState(locale ?? this.locale);
  }

  @override
  List<Object?> get props => [locale];
}
