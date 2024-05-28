import 'package:flutter/material.dart';

class AppTheme {
  static const _primaryColor = Colors.grey;
  static const _accentColor = Colors.green;
  static const _textColor = Colors.white;

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark, // Agrega el brightness aquí
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.dark().copyWith( // Utiliza ColorScheme.dark()
      primary: _accentColor,
      secondary: _accentColor,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: _textColor),
      bodyText2: TextStyle(color: _textColor),
      button: TextStyle(color: _textColor),
      caption: TextStyle(color: _textColor),
      headline1: TextStyle(color: _textColor),
      headline2: TextStyle(color: _textColor),
      headline3: TextStyle(color: _textColor),
      headline4: TextStyle(color: _textColor),
      headline5: TextStyle(color: _textColor),
      headline6: TextStyle(color: _textColor),
      overline: TextStyle(color: _textColor),
      subtitle1: TextStyle(color: _textColor),
      subtitle2: TextStyle(color: _textColor),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: _accentColor[400],
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
        backgroundColor: MaterialStateProperty.all<Color>(_accentColor[600]!),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(vertical: 15.0),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    ),
  );
}