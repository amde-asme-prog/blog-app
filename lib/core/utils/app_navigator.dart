import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();
  static push(context, page) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => page),
      );

  static pushReplacement(context, page) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => page),
      );

  static pushAndRemoveUntil(context, page, bool route) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }

  static pop(context) => Navigator.of(context).pop();
}
