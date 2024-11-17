import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/setting/presentation/widgets/setting_card_item.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        spacing: 20,
        children: [
          SettingCardItem(
            icon: Icons.color_lens,
            name: 'Theme',
            onPress: () {},
          ),
          SettingCardItem(
            icon: Icons.logout_outlined,
            name: 'Log Out',
            onPress: () {},
          ),
        ],
      ),
    );
  }
}
