import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      //app bar
      appBarTheme: const AppBarTheme(color: AppPalette.backgroundColor),
      //input field
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          errorBorder: _border(AppPalette.errorColor),
          focusedErrorBorder: _border(AppPalette.errorColor),
          enabledBorder: _border(),
          focusedBorder: _border(AppPalette.gradient1)),
      //chip theme
      chipTheme: const ChipThemeData(
          side: BorderSide.none,
          color: WidgetStatePropertyAll(AppPalette.backgroundColor)));
}
