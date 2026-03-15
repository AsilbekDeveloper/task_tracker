import 'package:flutter/material.dart';
import 'package:task_tracker_app/core/app_text_styles.dart';
import '../colors/app_colors.dart';

final class AppTheme {
  AppTheme._();

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.brandPrimary,
    onPrimary: Colors.white,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
    surfaceContainerHighest: AppColors.lightSurfaceVariant,
    onSurfaceVariant: AppColors.lightOnSurfaceVariant,
    error: AppColors.brandDanger,
    onError: Colors.white,
    outline: AppColors.lightBorder,
    secondary: AppColors.brandPrimary,
    onSecondary: Colors.white,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.brandPrimary,
    onPrimary: Colors.white,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceContainerHighest: AppColors.darkSurfaceVariant,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    error: AppColors.brandDanger,
    onError: Colors.white,
    outline: AppColors.darkBorder,
    secondary: AppColors.brandPrimary,
    onSecondary: Colors.white,
  );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    textTheme: const TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      labelSmall: AppTextStyles.labelSmall,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTextStyles.bodyLarge,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
  );

  static final ThemeData darkTheme = lightTheme.copyWith(
    brightness: Brightness.dark,
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.surface,
  );
}