import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay_tracker/themes/app_colors.dart';

ThemeData themeData = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,
    secondary: AppColors.primary,
    onSecondary: AppColors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black87,
    outline: AppColors.primary,
  ),
);

ThemeData darkThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    onPrimary: AppColors.black,
    secondary: AppColors.primaryDark,
    onSecondary: AppColors.black,
    error: Colors.red,
    onError: Colors.black54,
    surface: Colors.black,
    onSurface: Colors.white70,
    outline: AppColors.primaryDark,
  ),
);
