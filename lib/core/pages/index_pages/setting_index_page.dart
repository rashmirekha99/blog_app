import 'package:blog_app/core/pages/not_found_page.dart';
import 'package:blog_app/features/setting/presentation/pages/setting_page.dart';

import 'package:flutter/material.dart';

class SettingIndexPage extends StatefulWidget {
  const SettingIndexPage({super.key});

  @override
  State<SettingIndexPage> createState() => _SettingIndexPageState();
}

class _SettingIndexPageState extends State<SettingIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (context) => const SettingPage());
          default:
            return MaterialPageRoute(
                builder: (context) => const NotFoundPage());
        }
      },
    );
  }
}
