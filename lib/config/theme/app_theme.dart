import 'package:blog_app/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final _fontFamily = 'Poppins';

  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      );

  static final _baseTheme = ThemeData(
    fontFamily: _fontFamily,
    useMaterial3: true,
    colorSchemeSeed: AppPalette.gradient1,
    textTheme: TextTheme(
      displayLarge: TextStyle(fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
      bodyLarge: TextStyle(fontSize: 16, height: 1.8),
      bodyMedium: TextStyle(fontSize: 14, height: 1.6),
      labelLarge: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
    ),
    chipTheme: ChipThemeData(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 3,
      shadowColor: AppPalette.shadowColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 2,
    ),
  );

  static final lightTheme = _baseTheme.copyWith(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPalette.lightBackgroundColor,
    primaryColor: AppPalette.gradient1,
    cardColor: AppPalette.whiteColor,
    chipTheme: _baseTheme.chipTheme.copyWith(
      backgroundColor: AppPalette.gradient1.withValues(alpha: 0.1),
      labelStyle:
          TextStyle(color: AppPalette.gradient1, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      filled: true,
      fillColor: AppPalette.whiteColor,
      hintStyle: TextStyle(color: AppPalette.greyColor.withValues(alpha: 0.7)),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient1),
      errorBorder: _border(AppPalette.errorColor),
      focusedErrorBorder: _border(AppPalette.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.gradient1,
        foregroundColor: AppPalette.whiteColor,
        minimumSize: Size(double.infinity, 56),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 2,
      ),
    ),
    appBarTheme: _baseTheme.appBarTheme.copyWith(
      backgroundColor: AppPalette.lightBackgroundColor,
      foregroundColor: AppPalette.textDarkColor,
      iconTheme: IconThemeData(color: AppPalette.textDarkColor),
    ),
  );

  static final darkTheme = _baseTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    primaryColor: AppPalette.gradient2,
    cardColor: AppPalette.cardDarkColor,
    textTheme: _baseTheme.textTheme.apply(
      bodyColor: AppPalette.whiteColor,
      displayColor: AppPalette.whiteColor,
    ),
    chipTheme: _baseTheme.chipTheme.copyWith(
      backgroundColor: AppPalette.gradient2.withValues(alpha: 0.2),
      labelStyle:
          TextStyle(color: AppPalette.gradient2, fontWeight: FontWeight.w500),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(20),
      filled: true,
      fillColor: AppPalette.cardDarkColor,
      hintStyle: TextStyle(color: AppPalette.greyColor),
      border: _border(AppPalette.borderColor),
      enabledBorder: _border(AppPalette.borderColor),
      focusedBorder: _border(AppPalette.gradient2),
      errorBorder: _border(AppPalette.errorColor),
      focusedErrorBorder: _border(AppPalette.errorColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.gradient2,
        foregroundColor: AppPalette.whiteColor,
        minimumSize: Size(double.infinity, 56),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        elevation: 3,
        shadowColor: AppPalette.gradient2.withValues(alpha: 0.3),
      ),
    ),
    appBarTheme: _baseTheme.appBarTheme.copyWith(
      backgroundColor: AppPalette.backgroundColor,
      foregroundColor: AppPalette.whiteColor,
      iconTheme: IconThemeData(color: AppPalette.whiteColor),
    ),
  );
}
