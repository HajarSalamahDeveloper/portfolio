import 'package:flutter/material.dart';

/// Application color palette following a professional dark theme
/// with vibrant cyan/teal accents
class AppColors {
  AppColors._();

  // Primary colors - Deep blue/purple gradient
  static const Color primaryDark = Color(0xFF2D3561);
  static const Color primaryMedium = Color(0xFF5B4B8A);
  static const Color primaryLight = Color(0xFF7B68AA);

  // Accent colors - Vibrant cyan/teal
  static const Color accentCyan = Color(0xFF00D9FF);
  static const Color accentTeal = Color(0xFF00B8D4);
  static const Color accentBlue = Color(0xFF0099CC);

  // Background colors
  static const Color backgroundDark = Color(0xFF0F1419);
  static const Color backgroundMedium = Color(0xFF1A1F2E);
  static const Color backgroundLight = Color(0xFF252A3A);
  static const Color backgroundCard = Color(0xFF1E2433);

  // Surface colors with glassmorphism
  static const Color surfaceGlass = Color(0x33FFFFFF);
  static const Color surfaceGlassDark = Color(0x1AFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B8C8);
  static const Color textTertiary = Color(0xFF6B7280);

  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primaryMedium],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [accentCyan, accentTeal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [backgroundDark, backgroundMedium],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Status colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Shadow colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Glow effect colors
  static Color glowCyan = accentCyan.withOpacity(0.3);
  static Color glowTeal = accentTeal.withOpacity(0.3);
  static Color glowPrimary = primaryMedium.withOpacity(0.3);
}
