import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Warna Asas (Apple Standard)
  static const Color primaryBlue = Color(0xFF007AFF);
  static const Color backgroundLight = Color(0xFFF2F2F7); // Warna latar Settings iOS
  static const Color backgroundDark = CupertinoColors.black;
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1C1C1E);
  static const Color textLight = Colors.black;
  static const Color textDark = Colors.white;

  // (Light Mode)
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: '.SF Pro Display', // Font Apple
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: primaryBlue,
        brightness: Brightness.light,
      ),
      colorScheme: const ColorScheme.light(
        primary: primaryBlue,
        surface: cardLight,
      ),
      useMaterial3: true,
    );
  }

  // (Dark Mode)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryBlue,
      scaffoldBackgroundColor: backgroundDark,
      fontFamily: '.SF Pro Display',
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: primaryBlue,
        brightness: Brightness.dark,
        barBackgroundColor: Color(0xCC000000),
      ),
      colorScheme: const ColorScheme.dark(
        primary: primaryBlue,
        surface: cardDark,
      ),
      useMaterial3: true,
    );
  }
}