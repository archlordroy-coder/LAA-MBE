import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF0F172A);
  static const background = Color(0xFFF7F9FB);
  static const surface = Colors.white;
  static const sidebarBackground = Color(0xFFF2F4F6);
  static const accent = Color(0xFF0053DB);
  static const textPrimary = Color(0xFF191C1E);
  static const textSecondary = Color(0xFF45464D);
  static const secondaryContainer = Color(0xFFD5E3FC);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        background: AppColors.background,
        surface: AppColors.surface,
        primary: AppColors.primary,
        onPrimary: Colors.white,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Inter',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          letterSpacing: -0.02 * 32,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
