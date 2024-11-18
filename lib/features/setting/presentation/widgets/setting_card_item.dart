import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class SettingCardItem extends StatelessWidget {
  const SettingCardItem({
    super.key,
    required this.icon,
    required this.name,
    required this.onPress,
  });
  final String name;
  final Widget icon;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: AppPalette.borderColor.withAlpha(80)))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            spacing: 20.0,
            children: [
              Text(name),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
