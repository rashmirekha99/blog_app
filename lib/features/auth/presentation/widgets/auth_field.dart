import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureTExt;
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscureTExt = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureTExt,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is Missing";
        }
        return null;
      },
    );
  }
}
