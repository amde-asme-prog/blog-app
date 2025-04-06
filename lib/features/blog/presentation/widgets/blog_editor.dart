import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  const BlogEditor(
      {super.key,
      required this.hintText,
      required this.controller,
      this.maxLines});

  final String hintText;
  final TextEditingController controller;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Blog $hintText is required';
        }
        return null;
      },
    );
  }
}
