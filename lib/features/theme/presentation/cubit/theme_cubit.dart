import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Theme state
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object?> get props => [themeMode];
}

/// Cubit for managing theme mode
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.dark));

  /// Toggle between light and dark theme
  void toggleTheme() {
    final newMode = state.themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    emit(ThemeState(newMode));
  }

  /// Set specific theme mode
  void setThemeMode(ThemeMode mode) {
    emit(ThemeState(mode));
  }

  /// Check if current theme is dark
  bool get isDarkMode => state.themeMode == ThemeMode.dark;
}
