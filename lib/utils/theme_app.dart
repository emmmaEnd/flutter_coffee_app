import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData darkTheme(){
    final theme = ThemeData.dark().copyWith(
      colorScheme:ColorScheme(
        brightness: Brightness.dark, 
        primary: const Color.fromARGB(255, 255, 255, 255), 
        onPrimary: const Color(0xFFA9A9A9), 
        secondary: const Color.fromARGB(255, 255, 255, 255), 
        onSecondary: const Color(0xFFA9A9A9),
        error: Colors.red, 
        onError: Colors.red, 
        surface: const Color.fromARGB(255, 255, 255, 255), 
        onSurface: const Color(0xFFA9A9A9))
    );
    return theme;
  }
  static ThemeData lightTheme(){
    final theme = ThemeData.light().copyWith(
      colorScheme:ColorScheme(
        brightness: Brightness.dark, 
        primary: const Color(0xFFE67D00), 
        onPrimary: const Color(0xFFAB2222), 
        secondary: const Color(0xFFE67D00), 
        onSecondary: const Color(0xFFAB2222),
        error: Colors.red, 
        onError: Colors.red,
        surface: const Color(0xFFF3C975), 
        onSurface: const Color(0xFFAB2222),
        )
    );
    return theme;
  }
}