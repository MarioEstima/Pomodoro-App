import 'package:flutter/material.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
  ).copyWith(
    primary: AppColors.primary,
    surface: AppColors.background,
    onSurface: AppColors.textPrimary,
    secondary: AppColors.textSecondary,
    secondaryContainer: AppColors.mintStrong,
    onSecondaryContainer: AppColors.onMintStrong,
    surfaceContainerHighest: AppColors.neutralButton,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.icon),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 88,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
      ),
    ),
  );
}