import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color cloudPurple = Color(0xFFAD7CE6);
  static const Color cloudPink = Color(0xFFEAA4DF);
  static const Color cloudLilac = Color(0xFFCBA9F0);
  static const Color cloudRed = Color(0xFFF1EDF8);

  static const Color backgroundLight = Color(0xFFF2F2F7);
  static const Color backgroundDark = CupertinoColors.black;
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1C1C1E);

  // (Light Mode)
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: cloudPurple,
      scaffoldBackgroundColor: backgroundLight,
      fontFamily: '.SF Pro Display',
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: cloudPurple,
        brightness: Brightness.light,
      ),
      colorScheme: const ColorScheme.light(
        primary: cloudPurple,
        secondary: cloudPink,
        surface: cardLight,
      ),
      useMaterial3: true,
    );
  }

  // (Dark Mode)
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: cloudPurple,
      scaffoldBackgroundColor: backgroundDark,
      fontFamily: '.SF Pro Display',
      cupertinoOverrideTheme: const CupertinoThemeData(
        primaryColor: cloudPurple,
        brightness: Brightness.dark,
        barBackgroundColor: Color(0xCC000000), 
      ),
      colorScheme: const ColorScheme.dark(
        primary: cloudPurple,
        secondary: cloudPink,
        surface: cardDark,
      ),
      useMaterial3: true,
    );
  }
}