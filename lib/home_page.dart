import 'package:blog_app/core/constant/constant.dart';
import 'package:blog_app/features/blog/presentation/pages/my_blog_page.dart';
import 'package:blog_app/features/setting/presentation/setting_page.dart';
import 'package:blog_app/core/pages/index_pages/home_index_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomeIndexPage(),
          MyBlogPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: Constant.navBarHomeText,
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: Constant.navBarMyBlogText,
              icon: Icon(Icons.article),
            ),
            BottomNavigationBarItem(
              label: Constant.navBarSettingText,
              icon: Icon(Icons.settings),
            ),
          ]),
    );
  }
}
