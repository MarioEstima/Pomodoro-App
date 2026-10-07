import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
    primary: AppColors.primary,
    surface: AppColors.background,
    onSurface: AppColors.textPrimary,
    secondaryContainer: AppColors.mintStrong,
    onSecondaryContainer: AppColors.onMintStrong,
  );

  final baseText = GoogleFonts.figtreeTextTheme(); // fonte para tudo

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.background,
 
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.figtree(
        color: AppColors.primary,
        fontSize: 28,
        fontWeight: FontWeight.w900,
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.icon),
  );
}
