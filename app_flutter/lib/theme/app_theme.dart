import 'package:flutter/material.dart';

abstract final class AppColors {
  static const canvas = Color(0xFFF6F7F2);
  static const card = Color(0xFFFFFFFF);
  static const forest = Color(0xFF205B50);
  static const deep = Color(0xFF183B36);
  static const mint = Color(0xFFE4EEE5);
  static const apricot = Color(0xFFD98557);
  static const warmCover = Color(0xFFF5E2CE);
  static const primaryText = Color(0xFF21332F);
  static const secondaryText = Color(0xFF748079);
  static const border = Color(0xFFE1E7E0);
  static const danger = Color(0xFFB54747);
}

abstract final class AppTheme {
  static ThemeData get light {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.forest,
      brightness: Brightness.light,
    ).copyWith(
      primary: AppColors.forest,
      onPrimary: Colors.white,
      surface: AppColors.card,
      onSurface: AppColors.primaryText,
      secondary: AppColors.apricot,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.canvas,
      fontFamily: 'Roboto',
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.card,
        hintStyle: const TextStyle(color: AppColors.secondaryText),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.forest, width: 1.5),
        ),
      ),
    );
  }
}
