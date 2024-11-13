import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    //hide current snack bar
    ..hideCurrentSnackBar()
    //show current snack bar
    ..showSnackBar(SnackBar(content: Text(message)));
}
