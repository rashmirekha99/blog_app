import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  const BlogField({super.key, required this.controller, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hinText),
      maxLines: null,
    );
  }
}
