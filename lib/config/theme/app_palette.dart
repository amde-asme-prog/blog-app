import 'package:flutter/material.dart';

class AppPalette {
  AppPalette._();

  // Dark theme colors
  static const Color backgroundColor = Color(0xFF121218);
  static const Color cardDarkColor = Color(0xFF1E1E26);
  static const Color borderColor = Color(0xFF343343);

  // Light theme colors
  static const Color lightBackgroundColor = Color(0xFFF8F9FA);

  // Gradient colors
  static const Color gradient1 = Color(0xFFBB3FDD);
  static const Color gradient2 = Color(0xFFFB6DA9);
  static const Color gradient3 = Color(0xFFFF9F7C);

  // Common colors
  static const Color whiteColor = Colors.white;
  static const Color textDarkColor = Color(0xFF1A1A2E);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color errorColor = Color(0xFFFF5252);
  static const Color transparentColor = Colors.transparent;
  static const Color shadowColor = Color(0x1A000000);

  // Blog card colors
  static const List<Color> blogCardColors = [
    Color(0xFFF5F5FF),
    Color(0xFFFFF5F5),
    Color(0xFFF5FFF9),
    Color(0xFFFFFBF5),
  ];

  // Blog card dark colors
  static const List<Color> blogCardDarkColors = [
    Color(0xFF252535),
    Color(0xFF352525),
    Color(0xFF253525),
    Color(0xFF353025),
  ];

  // Linear gradient for buttons and special elements
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradient1, gradient2, gradient3],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
