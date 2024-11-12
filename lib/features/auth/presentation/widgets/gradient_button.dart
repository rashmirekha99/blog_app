import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  const GradientButton({super.key,required this.buttonText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final buttonHeight = screenHeight * 0.07; // 7% of screen height
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(colors: [
            AppPalette.gradient2,
            AppPalette.gradient3,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            fixedSize: Size(screenWidth, buttonHeight),
            backgroundColor: AppPalette.transparentColor,
            shadowColor: AppPalette.transparentColor),
        child:  Text(
          buttonText,
          style: const TextStyle(
              color: AppPalette.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
