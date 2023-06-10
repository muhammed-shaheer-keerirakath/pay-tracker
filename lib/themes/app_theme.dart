import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.poppinsTextTheme(),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.green,
    onPrimary: Colors.white,
    secondary: Colors.green,
    onSecondary: Colors.black87,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black87,
    surface: Colors.white,
    onSurface: Colors.black87,
    outline: Colors.black87,
  ),
);

ThemeData darkThemeData = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.orange,
    onPrimary: Colors.white70,
    secondary: Colors.orange,
    onSecondary: Colors.black54,
    error: Colors.red,
    onError: Colors.black54,
    background: Colors.black54,
    onBackground: Colors.white70,
    surface: Colors.black54,
    onSurface: Colors.white70,
    outline: Colors.white70,
  ),
);
