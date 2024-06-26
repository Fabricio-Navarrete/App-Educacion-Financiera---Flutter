import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Colors.grey;
  static const _accentColor = Colors.green;
  static const _textColor = Colors.white;

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Agrega el brightness aquí
    primaryColor: _primaryColor,
    colorScheme: const ColorScheme.dark().copyWith( // Utiliza ColorScheme.dark()
      primary: _accentColor,
      secondary: _accentColor,
    ),
    
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(255, 63, 118, 182),
      textTheme: ButtonTextTheme.primary,
      
    ),
    cardTheme: CardTheme(
      color: _primaryColor[800],
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(_primaryColor[600]!),
        padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 15.0),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
  );
}