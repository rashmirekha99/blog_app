import 'package:flutter/material.dart';

class BlogField extends StatelessWidget {
  final TextEditingController controller;
  final String hinText;
  const BlogField({super.key, required this.controller, required this.hinText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.titleSmall,
      controller: controller,
      decoration: InputDecoration(
          labelStyle: Theme.of(context).textTheme.titleSmall,
          hintText: hinText),
      maxLines: null,
      validator: (value) {
        if (value!.isEmpty) {
          return '$hinText is missing';
        }
        return null;
      },
    );
  }
}
