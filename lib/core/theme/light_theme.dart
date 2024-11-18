import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class LightThemeData {
  //light theme
  static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final lightThemeMode = ThemeData.light().copyWith(
      //input field
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(27),
          errorBorder: _border(AppPalette.errorColor),
          focusedErrorBorder: _border(AppPalette.errorColor),
          enabledBorder: _border(),
          focusedBorder: _border(AppPalette.gradient1)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppPalette.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppPalette.black,
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppPalette.textGreyColor,
        ),
        bodyMedium: TextStyle(color: AppPalette.black),
        headlineSmall: TextStyle(color: AppPalette.white, fontSize: 14),
        titleSmall: TextStyle(
          color: AppPalette.black,
        ),
      ),
      //navbar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppPalette.gradient1));
}
