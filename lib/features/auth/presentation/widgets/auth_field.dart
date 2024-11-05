import 'package:blog_app/config/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.obscureText = false});

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  static border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.all(20),
        enabledBorder: border(),
        focusedBorder: border(AppPalette.gradient2),
      ),
      obscureText: obscureText,
      // obscuringCharacter: "*",
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter $hintText";
        }
        return null;
      },
    );
  }
}
