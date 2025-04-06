import 'package:blog_app/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: AppPalette.borderColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: AppPalette.gradient1,
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    brightness: Brightness.light,
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(AppPalette.backgroundColor),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient1),
      errorBorder: _border(AppPalette.errorColor),
      focusedErrorBorder: _border(AppPalette.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: AppPalette.gradient1,
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.gradient1,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
